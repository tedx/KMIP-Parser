
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include "kmip.h"

#define DEBUG 0

uint8_t current_type = 0;
uint16_t current_tag = 0;
int i = 0;
int n = 0;

uint8_t *current_byte_string = NULL;
int current_string_len = 0;
char *current_string = NULL;
char *eof = NULL;

union {
  uint64_t u64;
  uint8_t arr[8];
} current_long;

union {
  uint32_t u32;
  uint8_t arr[4];
} current_len;

uint8_t *current_byte_ptr = NULL;

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
            return	  NULL;

%%{
	alphtype unsigned char;
#	import "kmip.h";

	KMIP_HEADER = 0x42;

	KMIP_TAG_ACTIVATION_DATE = 0x0001;
	KMIP_TAG_APPLICATION_DATA = 0x0002;
	KMIP_TAG_APPLICATION_NAMESPACE = 0x0003;
	KMIP_TAG_APPLICATION_SPECIFIC_INFORMATION = 0x0004;
	KMIP_TAG_ARCHIVE_DATE = 0x0005;
	KMIP_TAG_ASYNCHRONOUS_CORRELATION_VALUE = 0x0006;
	KMIP_TAG_ASYNCHRONOUS_INDICATOR = 0x0007;
	KMIP_TAG_ATTRIBUTE = 0x0008;
	KMIP_TAG_ATTRIBUTE_INDEX = 0x0009;
	KMIP_TAG_ATTRIBUTE_NAME = 0x000A;
	KMIP_TAG_ATTRIBUTE_VALUE = 0x000B;
	KMIP_TAG_AUTHENTICATION = 0x000C;
	KMIP_TAG_BATCH_COUNT = 0x000D;
	KMIP_TAG_BATCH_ERROR_CONTINUATION_OPTION = 0x000E;
	KMIP_TAG_BATCH_ITEM = 0x000F;
	KMIP_TAG_BATCH_ORDER_OPTION = 0x0010;
	KMIP_TAG_BLOCK_CIPHER_MODE = 0x0011;
	KMIP_TAG_CANCELLATION_RESULT = 0x0012;
	KMIP_TAG_CERTIFICATE = 0x0013;
	KMIP_TAG_CERTIFICATE_IDENTIFIER = 0x0014;
	KMIP_TAG_CERTIFICATE_ISSUER = 0x0015;
	KMIP_TAG_CERTIFICATE_ISSUER_ALTERNATIVE = 0x0016;
	KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED = 0x0017;
	KMIP_TAG_CERTIFICATE_REQUEST = 0x0018;
	KMIP_TAG_CERTIFICATE_REQUEST_TYPE = 0x0019;
	KMIP_TAG_CERTIFICATE_SUBJECT = 0x001A;
	KMIP_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME = 0x001B;
	KMIP_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME = 0x001C;
	KMIP_TAG_CERTIFICATE_TYPE = 0x001D;
	KMIP_TAG_CERTIFICATE_VALUE = 0x001E;
	KMIP_TAG_COMMON_TEMPLATE_ATTRIBUTE = 0x001F;
	KMIP_TAG_COMPROMISE_DATE = 0x0020;
	KMIP_TAG_COMPROMISE_OCCURRENCE_DATE = 0x0021;
	KMIP_TAG_CONTACT_INFORMATION = 0x0022;
	KMIP_TAG_CREDENTIAL = 0x0023;
	KMIP_TAG_CREDENTIAL_TYPE = 0x0024;
	KMIP_TAG_CREDENTIAL_VALUE = 0x0025;
	KMIP_TAG_CRITICALITY_INDICATOR = 0x0026;
	KMIP_TAG_CRT_COEFFICIENT = 0x0027;
	KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM = 0x0028;
	KMIP_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS = 0x0029;
	KMIP_TAG_CRYPTOGRAPHIC_LENGTH = 0x002A;
	KMIP_TAG_CRYPTOGRAPHIC_PARAMETERS = 0x002B;
	KMIP_TAG_CRYPTOGRAPHIC_USAGE_MASK = 0x002C;
	KMIP_TAG_CUSTOM_ATTRIBUTE = 0x002D;
	KMIP_TAG_D = 0x002E;
	KMIP_TAG_DEACTIVATION_DATE = 0x002F;
	KMIP_TAG_DERIVATION_DATA = 0x0030;
	KMIP_TAG_DERIVATION_METHOD = 0x0031;
	KMIP_TAG_DERIVATION_PARAMETERS = 0x0032;
	KMIP_TAG_DESTROY_DATE = 0x0033;
	KMIP_TAG_DIGEST = 0x0034;
	KMIP_TAG_DIGEST_VALUE = 0x0035;
	KMIP_TAG_ENCRYPTION_KEY_INFORMATION = 0x0036;
	KMIP_TAG_G = 0x0037;
	KMIP_TAG_HASHING_ALGORITHM = 0x0038;
	KMIP_TAG_INITIAL_DATE = 0x0039;
	KMIP_TAG_INITIALIZATION_VECTOR = 0x003A;
	KMIP_TAG_ISSUER = 0x003B;
	KMIP_TAG_ITERATION_COUNT = 0x003C;
	KMIP_TAG_IV_COUNTER_NONCE = 0x003D;
	KMIP_TAG_J = 0x003E;
	KMIP_TAG_KEY = 0x003F;
	KMIP_TAG_KEY_BLOCK = 0x0040;
	KMIP_TAG_KEY_COMPRESSION_TYPE = 0x0041;
	KMIP_TAG_KEY_FORMAT_TYPE = 0x0042;
	KMIP_TAG_KEY_MATERIAL = 0x0043;
	KMIP_TAG_KEY_PART_IDENTIFIER = 0x0044;
	KMIP_TAG_KEY_VALUE = 0x0045;
	KMIP_TAG_KEY_WRAPPING_DATA = 0x0046;
	KMIP_TAG_KEY_WRAPPING_SPECIFICATION = 0x0047;
	KMIP_TAG_LAST_CHANGE_DATE = 0x0048;
	KMIP_TAG_LEASE_TIME = 0x0049;
	KMIP_TAG_LINK = 0x004A;
	KMIP_TAG_LINK_TYPE = 0x004B;
	KMIP_TAG_LINKED_OBJECT_IDENTIFIER = 0x004C;
	KMIP_TAG_MAC_SIGNATURE = 0x004D;
	KMIP_TAG_MAC_SIGNATURE_KEY_INFORMATION = 0x004E;
	KMIP_TAG_MAXIMUM_ITEMS = 0x004F;
	KMIP_TAG_MAXIMUM_RESPONSE_SIZE = 0x0050;
	KMIP_TAG_MESSAGE_EXTENSION = 0x0051;
	KMIP_TAG_MODULUS = 0x0052;
	KMIP_TAG_NAME = 0x0053;
	KMIP_TAG_NAME_TYPE = 0x0054;
	KMIP_TAG_NAME_VALUE = 0x0055;
	KMIP_TAG_OBJECT_GROUP = 0x0056;
	KMIP_TAG_OBJECT_TYPE = 0x0057;
	KMIP_TAG_OFFSET = 0x0058;
	KMIP_TAG_OPAQUE_DATA_TYPE = 0x0059;
	KMIP_TAG_OPAQUE_DATA_VALUE = 0x005A;
	KMIP_TAG_OPAQUE_OBJECT = 0x005B;
	KMIP_TAG_OPERATION = 0x005C;
	KMIP_TAG_OPERATION_POLICY_NAME = 0x005D;
	KMIP_TAG_P = 0x005E;
	KMIP_TAG_PADDING_METHOD = 0x005F;
	KMIP_TAG_PRIME_EXPONENT_P = 0x0060;
	KMIP_TAG_PRIME_EXPONENT_Q = 0x0061;
	KMIP_TAG_PRIME_FIELD_SIZE = 0x0062;
	KMIP_TAG_PRIVATE_EXPONENT = 0x0063;
	KMIP_TAG_PRIVATE_KEY = 0x0064;
	KMIP_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE = 0x0065;
	KMIP_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER = 0x0066;
	KMIP_TAG_PROCESS_START_DATE = 0x0067;
	KMIP_TAG_PROTECT_STOP_DATE = 0x0068;
	KMIP_TAG_PROTOCOL_VERSION = 0x0069;
	KMIP_TAG_PROTOCOL_VERSION_MAJOR = 0x006A;
	KMIP_TAG_PROTOCOL_VERSION_MINOR = 0x006B;
	KMIP_TAG_PUBLIC_EXPONENT = 0x006C;
	KMIP_TAG_PUBLIC_KEY = 0x006D;
	KMIP_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE = 0x006E;
	KMIP_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER = 0x006F;
	KMIP_TAG_PUT_FUNCTION = 0x0070;
	KMIP_TAG_Q = 0x0071;
	KMIP_TAG_Q_STRING = 0x0072;
	KMIP_TAG_QLENGTH = 0x0073;
	KMIP_TAG_QUERY_FUNCTION = 0x0074;
	KMIP_TAG_RECOMMENDED_CURVE = 0x0075;
	KMIP_TAG_REPLACED_UNIQUE_IDENTIFIER = 0x0076;
	KMIP_TAG_REQUEST_HEADER = 0x0077;
	KMIP_TAG_REQUEST_MESSAGE = 0x0078;
	KMIP_TAG_REQUEST_PAYLOAD = 0x0079;
	KMIP_TAG_RESPONSE_HEADER = 0x007A;
	KMIP_TAG_RESPONSE_MESSAGE = 0x007B;
	KMIP_TAG_RESPONSE_PAYLOAD = 0x007C;
	KMIP_TAG_RESULT_MESSAGE = 0x007D;
	KMIP_TAG_RESULT_REASON = 0x007E;
	KMIP_TAG_RESULT_STATUS = 0x007F;
	KMIP_TAG_REVOCATION_MESSAGE = 0x0080;
	KMIP_TAG_REVOCATION_REASON = 0x0081;
	KMIP_TAG_REVOCATION_REASON_CODE = 0x0082;
	KMIP_TAG_KEY_ROLE_TYPE = 0x0083;
	KMIP_TAG_SALT = 0x0084;
	KMIP_TAG_SECRET_DATA = 0x0085;
	KMIP_TAG_SECRET_DATA_TYPE = 0x0086;
	KMIP_TAG_SERIAL_NUMBER = 0x0087;
	KMIP_TAG_SERVER_INFORMATION = 0x0088;
	KMIP_TAG_SPLIT_KEY = 0x0089;
	KMIP_TAG_SPLIT_KEY_METHOD = 0x008A;
	KMIP_TAG_SPLIT_KEY_PARTS = 0x008B;
	KMIP_TAG_SPLIT_KEY_THRESHOLD = 0x008C;
	KMIP_TAG_STATE = 0x008D;
	KMIP_TAG_STORAGE_STATUS_MASK = 0x008E;
	KMIP_TAG_SYMMETRIC_KEY = 0x008F;
	KMIP_TAG_TEMPLATE = 0x0090;
	KMIP_TAG_TEMPLATE_ATTRIBUTE = 0x0091;
	KMIP_TAG_TIME_STAMP = 0x92;
	KMIP_TAG_UNIQUE_BATCH_ITEM_ID = 0x0093;
	KMIP_TAG_UNIQUE_IDENTIFIER = 0x0094;
	KMIP_TAG_USAGE_LIMITS = 0x0095;
	KMIP_TAG_USAGE_LIMITS_COUNT = 0x0096;
	KMIP_TAG_USAGE_LIMITS_TOTAL = 0x0097;
	KMIP_TAG_USAGE_LIMITS_UNIT = 0x0098;
	KMIP_TAG_USERNAME = 0x0099;
	KMIP_TAG_VALIDITY_DATE = 0x009A;
	KMIP_TAG_VALIDITY_INDICATOR = 0x009B;
	KMIP_TAG_VENDOR_EXTENSION = 0x009C;
	KMIP_TAG_VENDOR_IDENTIFICATION = 0x009D;
	KMIP_TAG_WRAPPING_METHOD = 0x009E;
	KMIP_TAG_X = 0x009F;
	KMIP_TAG_Y = 0x00A0;
	KMIP_TAG_PASSWORD = 0x00A1;

	KMIP_ITEM_TYPE_STRUCTURE = 1;
	KMIP_ITEM_TYPE_INTEGER = 2;  
	KMIP_ITEM_TYPE_LONG_INTEGER = 3;
	KMIP_ITEM_TYPE_BIG_INTEGER = 4;
	KMIP_ITEM_TYPE_ENUMERATION = 5;
	KMIP_ITEM_TYPE_BOOLEAN = 6;
	KMIP_ITEM_TYPE_TEXT_STRING = 7;
	KMIP_ITEM_TYPE_BYTE_STRING = 8;
	KMIP_ITEM_TYPE_DATE_TIME = 9;
	KMIP_ITEM_TYPE_INTERVAL = 0xA;

	action batch_item_action { 
		printf( "batch_item\n");
	}

	action batch_count_action { 
		printf( "batch_count: %d\n", current_int.u32 );
	}

	action response_message_tt_action { 
		printf( "response_message_tt\n" );
	}

	action response_message_ttl_action { 
		printf( "response_message_ttl\n" );
		printf("len: %d\n", current_len.u32);
	}

	action response_header_ttl_action { 
		printf( "response_header_ttl\n" );
	        printf("len: %d\n", current_len.u32);
	}

	action response_header_action { 
		printf( "response_header\n" );
	}

	action protocol_version_action { 
		printf( "protocol_version\n" );
	}

	action protocol_version_tt_action { 
		printf( "protocol_version_tt\n" );
	}

	action protocol_major_version_action { 
		printf( "protocol_major_version: %d\n", current_int.u32 );
	}

	action protocol_minor_version_action { 
		printf( "protocol_minor_version: %d\n", current_int.u32 );
	}

	action timestamp_action {
	       	  if (current_len.u32 == 0) {
		     printf( "timestamp 0x%lx\n", current_long.u64);
		  }
	}

	action timestamp_tt_action { 
		printf( "timestamp_tt\n" );
	}

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

	action result_status_action { 
		printf( "result_status: %d\n", current_int.u32 );
	}

	action uuid_action {
	        current_string = (char *)malloc(37);
		strncpy(current_string, p-35, 36);
		current_string[36] = '\0';
		printf( "uuid: %s\n", current_string );
	}

	action attribute_action { 
		printf( "attribute\n" );
	}

	action response_payload_action { 
		printf( "response_payload\n" );
	}

	action get_attributes_payload_action { 
		printf( "get_attributes_payload\n" );
	}

	action response_message_action { 
		printf( "response_message\n" );
	}

	action operation_action { 
		printf( "operation: 0x%x\n", current_int.u32 );
	}

	action link_type_action { 
		printf( "link_type: 0x%x\n", current_int.u32 );
	}

	action attribute_name_action {
	       if (current_len.u32 == 0) {
	       	  printf( "attribute_name: %s\n", current_byte_string );
		  /* consume any remaining bytes of padding */
		  i = current_string_len % 8;
	  	  printf("%d mod %d\n", current_string_len, i);
		  if (i != 0)
		     p = p + (8-i);
	       }
	}

	action byte_string_action {
	       	  if (current_len.u32 == 0) {
		  	printf( "byte string : ");
			for (i=0; i < current_string_len; i++)
			    printf("0x%02x ", current_byte_string[i]);
			printf("\n");
			/* free(current_byte_string);*/
			/* consume any remaining bytes of padding */
			i = current_string_len % 8;
		  	printf("%d mod %d\n", current_string_len, i);
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

	action check {current_len.u32--}

	long_data = ( extend when check )* %when !check @{ current_long.arr[current_len.u32] = *p; };
	len = extend{4} @{ current_byte_ptr = p; for (i=0; i < 4; i++) { current_len.arr[i] = *current_byte_ptr--; }  } ;
	get_int = extend{4} @{ current_byte_ptr = p; for (i=0; i < 4; i++) { current_int.arr[i] = *current_byte_ptr--; }  } extend{4} ;
	type = extend @{ current_type = (uint8_t)*p };
	tag = extend{2} @{ current_tag = (uint8_t)*p };
	uuid = xdigit{8} '-' xdigit{4} '-' xdigit{4} '-' xdigit{4} '-' xdigit{12} @uuid_action extend{4} ;

	response_message_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_MESSAGE KMIP_ITEM_TYPE_STRUCTURE ;
	response_header_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_HEADER KMIP_ITEM_TYPE_STRUCTURE ;
	response_payload_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_PAYLOAD KMIP_ITEM_TYPE_STRUCTURE ;
	protocol_version_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION KMIP_ITEM_TYPE_STRUCTURE ;
	protocol_minor_version_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION_MINOR KMIP_ITEM_TYPE_INTEGER ;
	protocol_major_version_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION_MAJOR KMIP_ITEM_TYPE_INTEGER ;
	timestamp_tt = KMIP_HEADER 0 KMIP_TAG_TIME_STAMP KMIP_ITEM_TYPE_DATE_TIME ;
	batch_count_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_COUNT KMIP_ITEM_TYPE_INTEGER ;
	batch_item_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_ITEM KMIP_ITEM_TYPE_STRUCTURE ;
	operation_tt = KMIP_HEADER 0 KMIP_TAG_OPERATION KMIP_ITEM_TYPE_ENUMERATION ;
	result_status_tt = KMIP_HEADER 0 KMIP_TAG_RESULT_STATUS KMIP_ITEM_TYPE_ENUMERATION ;
	unique_identifier_tt = KMIP_HEADER 0 KMIP_TAG_UNIQUE_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
	unique_batch_item_id_tt = KMIP_HEADER 0 KMIP_TAG_UNIQUE_BATCH_ITEM_ID KMIP_ITEM_TYPE_BYTE_STRING ;
	attribute_name_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_NAME KMIP_ITEM_TYPE_TEXT_STRING ;
	object_type_tt = KMIP_HEADER 0 KMIP_TAG_OBJECT_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
	attribute_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE ;
	key_block_tt = KMIP_HEADER 0 KMIP_TAG_KEY_BLOCK KMIP_ITEM_TYPE_STRUCTURE ;
	private_key_tt = KMIP_HEADER 0 KMIP_TAG_PRIVATE_KEY KMIP_ITEM_TYPE_STRUCTURE ;
	public_key_tt = KMIP_HEADER 0 KMIP_TAG_PUBLIC_KEY KMIP_ITEM_TYPE_STRUCTURE ;
	certificate_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE KMIP_ITEM_TYPE_STRUCTURE ;
	certificate_type_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
	certificate_value_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
	attribute_value_struct_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_VALUE KMIP_ITEM_TYPE_STRUCTURE ;
	attribute_value_enum_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_VALUE KMIP_ITEM_TYPE_ENUMERATION ;
	issuer_tt = KMIP_HEADER 0 KMIP_TAG_ISSUER KMIP_ITEM_TYPE_TEXT_STRING ;
	serial_number_tt = KMIP_HEADER 0 KMIP_TAG_SERIAL_NUMBER KMIP_ITEM_TYPE_TEXT_STRING ;
	certificate_issuer_distinguished_name_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED KMIP_ITEM_TYPE_TEXT_STRING ;
	key_format_type_tt = KMIP_HEADER 0 KMIP_TAG_KEY_FORMAT_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
	key_value_tt = KMIP_HEADER 0 KMIP_TAG_KEY_VALUE KMIP_ITEM_TYPE_STRUCTURE ;
	key_material_tt = KMIP_HEADER 0 KMIP_TAG_KEY_MATERIAL KMIP_ITEM_TYPE_BYTE_STRING ;
	cryptographic_algorithm_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM KMIP_ITEM_TYPE_ENUMERATION ;
	cryptographic_length_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_LENGTH KMIP_ITEM_TYPE_INTEGER ;
	link_type_tt = KMIP_HEADER 0 KMIP_TAG_LINK_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
	linked_object_identifier_tt = KMIP_HEADER 0 KMIP_TAG_LINKED_OBJECT_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;

	unique_batch_item_id_data = ( extend when check )* %when !check @{ current_byte_string[(current_string_len-1) - current_len.u32] = *p; };
	certificate_value_data = ( extend when check )* %when !check @{ printf("[%d]:0x%02x\n", current_len.u32, *p); };
	text_string = ( extend when check )* %when !check @{ current_byte_string[(current_string_len-1) - current_len.u32] = *p; };
	key_material_data = ( extend when check )* %when !check @{ current_byte_string[(current_string_len-1) - current_len.u32] = *p; };

	link_type = link_type_tt len get_int @link_type_action;
	linked_object_identifier = linked_object_identifier_tt len uuid;
	cryptographic_algorithm = cryptographic_algorithm_tt len get_int;
	cryptographic_length = cryptographic_length_tt len get_int;
	key_material = key_material_tt len @byte_string_malloc key_material_data @byte_string_action;
	key_format_type = key_format_type_tt len get_int;
	key_value = key_value_tt len key_material;

	object_type = object_type_tt len get_int @{ printf("object_type\n"); };
	timestamp = timestamp_tt len long_data @timestamp_action;
	batch_count = batch_count_tt len get_int @batch_count_action;
	protocol_major_version = protocol_major_version_tt @protocol_major_version_action len get_int ;
	protocol_minor_version = protocol_minor_version_tt @protocol_minor_version_action len get_int ;
	protocol_version = protocol_version_tt @protocol_version_action len protocol_major_version protocol_minor_version ;
	certificate_type = certificate_type_tt len get_int;
	certificate_value = certificate_value_tt len certificate_value_data;
	issuer = issuer_tt len text_string;
	serial_number = serial_number_tt len text_string;

	certificate_issuer_distinguished_name = certificate_issuer_distinguished_name_tt len text_string;
	key_block = key_block_tt len key_format_type key_value cryptographic_algorithm cryptographic_length;
	batch_item_ttl = batch_item_tt len;
	response_message_ttl = response_message_tt len ;
	response_header_ttl = response_header_tt len ;
	response_payload_ttl = response_payload_tt len;
	operation = operation_tt len get_int @operation_action ;
	unique_batch_item_id = unique_batch_item_id_tt len @byte_string_malloc unique_batch_item_id_data @byte_string_action;
	result_status = result_status_tt len get_int @result_status_action ;
	unique_identifier = unique_identifier_tt len uuid;

	register_locate_destroy_payload = unique_identifier;

	attribute_name = attribute_name_tt len @byte_string_malloc text_string @attribute_name_action;
	attribute_value_struct = attribute_value_struct_tt len ( link_type linked_object_identifier | issuer serial_number | certificate_issuer_distinguished_name );
	attribute_value_enum = attribute_value_enum_tt len get_int;

	private_key = private_key_tt len key_block;
	public_key = public_key_tt len key_block;
	certificate = certificate_tt len certificate_type certificate_value;

	attribute = attribute_tt @attribute_action len attribute_name attribute_index? ( attribute_value_struct | attribute_value_enum );

	add_attribute_payload =  unique_identifier attribute;
	get_attribute_list_payload =  unique_identifier attribute_name*;
	get_attributes_payload = unique_identifier attribute* ;
	get_payload = object_type unique_identifier ( private_key | public_key | certificate );
	create_key_pair_payload = unique_identifier{2};

	response_header = response_header_ttl @response_header_action protocol_version timestamp batch_count ;
	response_payload = response_payload_ttl @response_payload_action ( get_attributes_payload | unique_identifier | create_key_pair_payload | get_payload ) ;
	batch_item = batch_item_tt @batch_item_action len operation unique_batch_item_id? result_status response_payload;

	response_message = response_message_ttl @response_message_action response_header ( batch_item? ) ;
		
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

