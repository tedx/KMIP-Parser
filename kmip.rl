#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include "kmip.h"

kmip_name_value_pair_t *kmip_name_value_pairs = NULL;
kmip_action_function_t *kmip_actions = NULL;
kmip_action_function_t *kmip_action = NULL;

#define DEBUG 1

%%{
	machine KmipState;
	write data;
}%%

int kmip_parse( uint8_t *buf, int len, bson** b)
{
	uint8_t *p = buf, *pe = buf + len;
	int cs;
	int i = 0;
	int n = 0;  
	int rc = 0;
	uint8_t *eof;
	kmip_parser_state_t *parser_state = NULL;

	parser_state = (kmip_parser_state_t *)malloc(sizeof(kmip_parser_state_t));
	*b = ( bson * )malloc( sizeof( bson ) );
	parser_state->bb = ( bson_buffer * )malloc( sizeof( bson_buffer ) );
	bson_buffer_init( parser_state->bb );

%%{
	alphtype unsigned char;

	action check {parser_state->current_len.u32--}

	long_data = ( extend when check )* %when !check @{ parser_state->current_long.arr[parser_state->current_len.u32] = *p; };
	len = extend{4} @{ parser_state->current_byte_ptr = p; for (i=0; i < 4; i++) { parser_state->current_len.arr[i] = *parser_state->current_byte_ptr--; }  } ;
	get_int = extend{4} @{ parser_state->current_byte_ptr = p; for (i=0; i < 4; i++) { parser_state->current_int.arr[i] = *parser_state->current_byte_ptr--; }  } extend{4} ;

	action uuid_action {
	        parser_state->current_string = (char *)malloc(37);
		strncpy((char*)parser_state->current_string, (char*)(p-35), 36);
		parser_state->current_string[36] = '\0';
		printf( "uuid: %s\n", parser_state->current_string );
	}
	uuid = xdigit{8} '-' xdigit{4} '-' xdigit{4} '-' xdigit{4} '-' xdigit{12} @uuid_action extend{4} ;

	text_string = ( extend when check )* %when !check @{ parser_state->current_byte_string[(parser_state->current_string_len-1) - parser_state->current_len.u32] = *p; };

	include "kmip-common.rl";

	action print_int {
	       printf("int: %d\n", parser_state->current_int.u32);
	}

	action print_err { 
		printf("\r\nsyntax error at:\n");
		n = pe-p;
		for (i=0; i < n; i++)
		    printf("0x%02x ", *(p+i));
		printf("\n");
		rc = -1;
	}

	# Response payloads
	register_locate_destroy_response_payload = unique_identifier;
	add_attribute_response_payload =  unique_identifier attribute;
	get_attribute_list_response_payload =  unique_identifier attribute_name*;
	get_attributes_response_payload = unique_identifier attribute* ;
	get_response_payload = object_type unique_identifier ( private_key | public_key | certificate );
	create_key_pair_response_payload = unique_identifier{2};
	response_payload = response_payload_tt len @response_payload_init ( get_attributes_response_payload | unique_identifier | create_key_pair_response_payload | get_response_payload | add_attribute_response_payload | get_attribute_list_response_payload ) @response_payload_action ;
	# Request payloads
	register_request_payload = object_type template_attribute ( private_key | public_key | certificate );
	locate_request_payload = maximum_items? attribute*;
	get_request_payload = uuid | key_format_type | uuid key_format_type;
	destroy_request_payload = uuid;
	create_key_pair_request_payload = common_template_attribute private_key_template_attribute public_key_template_attribute;
	request_payload = request_payload_tt len @request_payload_init ( register_request_payload | locate_request_payload | get_request_payload | destroy_request_payload | create_key_pair_request_payload ) @request_payload_action;

	batch_item = batch_item_tt @batch_item_init len operation unique_batch_item_id? ( result_status response_payload | request_payload ) @batch_item_action ;

	response_message = response_message_tt len @response_message_init response_header ( batch_item? ) @response_message_action ;
	request_message = request_message_tt len @request_message_init request_header ( batch_item? ) @request_message_action ;
		
	main := ( request_message | response_message ) <>err(print_err);
	# Initialize and execute.
	write init;
	write exec;
}%%
	if (rc == 0) {
	   bson_from_buffer( *b, parser_state->bb );
	} else {
	  free(b);
	}
	free(parser_state);
	return rc;
}


void kmip_byte_string_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs) 
{
	int i = 0;
       	if (parser_state->current_len.u32 == 0) {
	  	printf( "byte string : ");
		for (i=0; i < parser_state->current_string_len; i++)
		    printf("0x%02x ", parser_state->current_byte_string[i]);
		printf("\n");
		/* consume any remaining bytes of padding */
		i = parser_state->current_string_len % 8;
	  	/* printf("%d mod %d\n", parser_state->current_string_len, i); */
		if (i != 0)
		   *p = *p + (8-i);
	}
}

void kmip_byte_string_init_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs) 
{
       	if (parser_state->current_byte_string != NULL)
       	   free(parser_state->current_byte_string);
       	parser_state->current_byte_string = (uint8_t *)malloc(parser_state->current_len.u32+1);
	parser_state->current_byte_string[parser_state->current_len.u32+1] = '\0';
	parser_state->current_string_len = parser_state->current_len.u32;
	if (DEBUG)
	   printf( "byte string malloc: %d\n", parser_state->current_len.u32+1 );
}

void kmip_operation_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	char *operation = NULL;
	printf("operation_action_handler: %d\n", parser_state->current_int.u32);
	switch (parser_state->current_int.u32) {
	case KMIP_OPERATION_CREATE:
	     asprintf(&operation, "%s", "Create");
	break;
	case KMIP_OPERATION_CREATE_KEY_PAIR:
	     asprintf(&operation, "%s", "Create Key Pair");
	break;
	case KMIP_OPERATION_REGISTER:
	     asprintf(&operation, "%s", "Register");
	break;
	case KMIP_OPERATION_REKEY:
	     asprintf(&operation, "%s", "Rekey");
	break;
	case KMIP_OPERATION_DERIVE_KEY:
	     asprintf(&operation, "%s", "Derive Key");
	break;
	case KMIP_OPERATION_CERTIFY:
	     asprintf(&operation, "%s", "Certify");
	break;
	case KMIP_OPERATION_RECERTIFY:
	     asprintf(&operation, "%s", "Recertify");
	break;
	case KMIP_OPERATION_LOCATE:
	     asprintf(&operation, "%s", "Locate");
	break;
	case KMIP_OPERATION_CHECK:
	     asprintf(&operation, "%s", "Check");
	break;
	case KMIP_OPERATION_GET:
	     asprintf(&operation, "%s", "Get");
	break;
	case KMIP_OPERATION_GET_ATTRIBUTES:
	     asprintf(&operation, "%s", "Get Attributes");
	break;
	case KMIP_OPERATION_GET_ATTRIBUTE_LIST:
	     asprintf(&operation, "%s", "Get Attribute List");
	break;
	case KMIP_OPERATION_ADD_ATTRIBUTE:
	     asprintf(&operation, "%s", "Add Attribute");
	break;
	case KMIP_OPERATION_MODIFY_ATTRIBUTE:
	     asprintf(&operation, "%s", "Modify Attribute");
	break;
	case KMIP_OPERATION_DELETE_ATTRIBUTE:
	     asprintf(&operation, "%s", "Delete Attribute");
	break;
	case KMIP_OPERATION_OBTAIN_LEASE:
	     asprintf(&operation, "%s", "Obtain Lease");
	break;
	case KMIP_OPERATION_GET_USAGE_ALLOCATION:
	     asprintf(&operation, "%s", "Get Usage Allocation");
	break;
	case KMIP_OPERATION_ACTIVATE:
	     asprintf(&operation, "%s", "Activate");
	break;
	case KMIP_OPERATION_REVOKE:
	     asprintf(&operation, "%s", "Revoke");
	break;
	case KMIP_OPERATION_DESTROY:
	     asprintf(&operation, "%s", "Destroy");
	break;
	case KMIP_OPERATION_ARCHIVE:
	     asprintf(&operation, "%s", "Archive");
	break;
	case KMIP_OPERATION_RECOVER:
	     asprintf(&operation, "%s", "Recover");
	break;
	case KMIP_OPERATION_VALIDATE:
	     asprintf(&operation, "%s", "Validate");
	break;
	case KMIP_OPERATION_QUERY:
	     asprintf(&operation, "%s", "Query");
	break;
	case KMIP_OPERATION_CANCEL:
	     asprintf(&operation, "%s", "Cancel");
	break;
	case KMIP_OPERATION_POLL:
	     asprintf(&operation, "%s", "Poll");
	break;
	case KMIP_OPERATION_NOTIFY:
	     asprintf(&operation, "%s", "Notify");
	break;
	case KMIP_OPERATION_PUT:
	     asprintf(&operation, "%s", "Put");
	break;
	}
	bson_append_string( parser_state->bb, "Operation",  operation);
}
	
void kmip_object_type_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	printf("object_type_action_handler: %d\n", parser_state->current_int.u32);
	bson_append_int( parser_state->bb, "Object Type", parser_state->current_int.u32 );
}

void kmip_key_format_type_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	char *key_format_type = NULL;
	switch (parser_state->current_int.u32) {
	case KMIP_KEY_FORMAT_TYPE_RAW:
	     asprintf(&key_format_type, "%s", "Raw");
	break;
	case KMIP_KEY_FORMAT_TYPE_OPAQUE:
	     asprintf(&key_format_type, "%s", "Opaque");
	break;
	case KMIP_KEY_FORMAT_TYPE_PKCS1:
	     asprintf(&key_format_type, "%s", "PKCS1");
	break;
	case KMIP_KEY_FORMAT_TYPE_PKCS8:
	     asprintf(&key_format_type, "%s", "PKCS8");
	break;
	case KMIP_KEY_FORMAT_TYPE_X509:
	     asprintf(&key_format_type, "%s", "X509");
	break;
	case KMIP_KEY_FORMAT_TYPE_ECPRIVATEKEY:
	     asprintf(&key_format_type, "%s", "ECPRIVATEKEY");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_SYMMETRIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent Symmetric Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DSA_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent DSA Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DSA_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent DSA Public Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_RSA_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent RSA Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_RSA_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent RSA Public Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DH_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent DH Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DH_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent DH Public Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDSA_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECDSA Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDSA_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECDSA Public Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDH_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECDH Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDH_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECDH Public Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECMQV_PRIVATE_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECMQV Private Key");
	break;
	case KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECMQV_PUBLIC_KEY:
	     asprintf(&key_format_type, "%s", "Transparent ECMQV Public Key");
	break;
	}
	bson_append_string( parser_state->bb, "Key Format",  key_format_type);
}

void kmip_key_material_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	int i = 0;
	if (parser_state->current_len.u32 == 0) {
		/* consume any remaining bytes of padding */
		i = parser_state->current_string_len % 8;
		if (i != 0)
		   *p = *p + (8-i);
		bson_append_binary( parser_state->bb, "Key Material", (int)KMIP_ITEM_TYPE_BYTE_STRING,  (const char *)parser_state->current_byte_string, (int)parser_state->current_string_len);
	}
}

void kmip_attribute_value_int_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	printf("attribute_value_int_action_handler: %d\n", parser_state->current_int.u32);
	bson_append_int( parser_state->bb, parser_state->current_attribute_name, parser_state->current_int.u32 );
}

void kmip_attribute_name_action_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	if (parser_state->current_len.u32 == 0) {
	   parser_state->current_attribute_name = (char *)malloc(parser_state->current_string_len+1);
	   strncpy(parser_state->current_attribute_name, (char *)parser_state->current_byte_string, parser_state->current_string_len+1);
	   printf("attribute_name_action_handler: %s\n", parser_state->current_attribute_name);
	}
}

void kmip_request_message_init_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	printf("request_message_init_handler\n");
}

void kmip_request_header_init_handler(kmip_parser_state_t *parser_state, uint8_t **p, int cs)
{
	printf("request_header_init_handler\n");
}
