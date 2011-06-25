
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include "kmip.h"

#define DEBUG 1

uint8_t current_type = 0;
uint16_t current_tag = 0;
int i = 0;
int n = 0;

uint8_t *current_byte_ptr = NULL;
uint8_t *current_byte_string = NULL;
int current_string_len = 0;
char *current_string = NULL;
uint8_t *eof = NULL;

union {
  uint64_t u64;
  uint8_t arr[8];
} current_long;

union {
  uint32_t u32;
  uint8_t arr[4];
} current_len;

union {
  int u32;
  uint8_t arr[4];
} current_int;

%%{
	machine KmipState;
	write data;
}%%

kmip_response_message_t *response( uint8_t *buf, int len )
{
	uint8_t *p = buf, *pe = buf + len;
	int cs;

	kmip_response_message_t *response = ( kmip_response_message_t *)malloc(sizeof( kmip_response_message_t));
        if (response == NULL)
            return NULL;

%%{
	alphtype unsigned char;

	action check {current_len.u32--}

	long_data = ( extend when check )* %when !check @{ current_long.arr[current_len.u32] = *p; };
	len = extend{4} @{ current_byte_ptr = p; for (i=0; i < 4; i++) { current_len.arr[i] = *current_byte_ptr--; }  } ;
	get_int = extend{4} @{ current_byte_ptr = p; for (i=0; i < 4; i++) { current_int.arr[i] = *current_byte_ptr--; }  } extend{4} ;
	type = extend @{ current_type = (uint8_t)*p };
	tag = extend{2} @{ current_tag = (uint8_t)*p };

	action uuid_action {
	        current_string = (char *)malloc(37);
		strncpy(current_string, p-35, 36);
		current_string[36] = '\0';
		printf( "uuid: %s\n", current_string );
	}
	uuid = xdigit{8} '-' xdigit{4} '-' xdigit{4} '-' xdigit{4} '-' xdigit{12} @uuid_action extend{4} ;

	text_string = ( extend when check )* %when !check @{ current_byte_string[(current_string_len-1) - current_len.u32] = *p; };

	action byte_string_action {
	       	if (current_len.u32 == 0) {
		  	printf( "byte string : ");
			for (i=0; i < current_string_len; i++)
			    printf("0x%02x ", current_byte_string[i]);
			printf("\n");
			/* free(current_byte_string);*/
			/* consume any remaining bytes of padding */
			i = current_string_len % 8;
		  	/* printf("%d mod %d\n", current_string_len, i); */
			if (i != 0)
			   p = p + (8-i);
		}
	}

	action byte_string_malloc {
	       	if (current_byte_string != NULL)
	       	   free(current_byte_string);
	       	current_byte_string = (uint8_t *)malloc(current_len.u32+1);
		current_byte_string[current_len.u32+1] = '\0';
		current_string_len = current_len.u32;
		if (DEBUG)
		   printf( "byte string malloc: %d\n", current_len.u32+1 );
	}

	include "kmip-common.rl";

	action print_int {
	       printf("int: %d\n", current_int.u32);
	}

	action print_err { 
		printf("\r\nsyntax error at:\n");
		n = pe-p;
		for (i=0; i < n; i++)
		    printf("0x%02x ", *(p+i));
		printf("\n");
	}

	unique_batch_item_id_data = ( extend when check )* %when !check @{ current_byte_string[(current_string_len-1) - current_len.u32] = *p; };
	key_value = key_material_byte_string | key_material_struct ;

	register_locate_destroy_payload = unique_identifier;
	add_attribute_payload =  unique_identifier attribute;
	get_attribute_list_payload =  unique_identifier attribute_name*;
	get_attributes_payload = unique_identifier attribute* ;
	get_payload = object_type unique_identifier ( private_key | public_key | certificate );
	create_key_pair_payload = unique_identifier{2};
	response_payload = response_payload_tt len @response_payload_action ( get_attributes_payload | unique_identifier | create_key_pair_payload | get_payload ) ;

	batch_item = batch_item_tt @batch_item_action len operation unique_batch_item_id? result_status response_payload;

	response_message = response_message_tt len @response_message_action response_header ( batch_item? ) ;
		
	main := response_message <>err(print_err);
	# Initialize and execute.
	write init;
	write exec;
}%%

	return response;
};

int main(int argc, char **argv)
{
	FILE *file;
	char *buffer;
	unsigned long fileLen;

	printf("%d %s\n", argc, argv[1]);
	if (argc != 2)
	   exit(1);
	file = fopen(argv[1], "rb");
	if (!file)
	{
		fprintf(stderr, "can't open file %s", argv[1]);
		exit(1);
	}

	fseek(file, 0, SEEK_END);
	fileLen=ftell(file);
	fseek(file, 0, SEEK_SET);

	buffer=(char *)malloc(fileLen+1);

	if (!buffer)
	{
		fprintf(stderr, "Memory error!");
        fclose(file);
		exit(1);
	}

	fread(buffer, fileLen, 1, file);
	fclose(file);
	kmip_response_message_t *response_message = response( buffer, fileLen );
	return 0;
}

