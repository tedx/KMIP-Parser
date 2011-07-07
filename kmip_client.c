#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include "kmip.h"

int main(int argc, char **argv)
{
	FILE *file;
	uint8_t *buffer;
	unsigned long fileLen;
	bson *b = NULL;

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

	buffer = (uint8_t *)malloc(fileLen+1);

	if (!buffer)
	{
		fprintf(stderr, "Memory error!");
        fclose(file);
		exit(1);
	}

	fread(buffer, fileLen, 1, file);
	fclose(file);

	KMIP_ACTION_HANDLER( "request_message_init",  &kmip_request_message_init_handler );
	KMIP_ACTION_HANDLER( "request_header_init",  &kmip_request_header_init_handler ); 
	KMIP_ACTION_HANDLER( "operation_action",  &kmip_operation_action_handler ); 
	KMIP_ACTION_HANDLER( "object_type_action",  &kmip_object_type_action_handler ); 
	KMIP_ACTION_HANDLER( "key_format_type_action",  &kmip_key_format_type_action_handler ); 
	KMIP_ACTION_HANDLER( "key_material_byte_string_init",  &kmip_byte_string_init_handler );
	KMIP_ACTION_HANDLER( "key_material_byte_string_action",  &kmip_key_material_action_handler ); 
	KMIP_ACTION_HANDLER( "attribute_name_init",  &kmip_byte_string_init_handler );
	KMIP_ACTION_HANDLER( "attribute_name_action",  &kmip_attribute_name_action_handler ); 
	KMIP_ACTION_HANDLER( "attribute_value_integer_action",  &kmip_attribute_value_int_action_handler );

	if (kmip_parse( buffer, fileLen, &b) == 0) {
	  bson_print(b);
	  free(b);
	}
	return 0;
}
