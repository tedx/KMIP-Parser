%%{
	machine KmipState;
	write data;
}%%

%%{

KMIP_HEADER = 0x42;

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


# KMIP_TAG_ACTIVATION_DATE
KMIP_TAG_ACTIVATION_DATE = 0x0001;

action activation_date_action {
	if (DEBUG)
		printf("activation_date\n");
}

action activation_date_init {
	if (DEBUG)
		printf("activation_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_activation_date_t)); */
}

activation_date_tt = KMIP_HEADER 0 KMIP_TAG_ACTIVATION_DATE KMIP_ITEM_TYPE_DATE_TIME ;
activation_date = activation_date_tt len @activation_date_init long_data @activation_date_action;

# KMIP_TAG_APPLICATION_DATA
KMIP_TAG_APPLICATION_DATA = 0x0002;

action application_data_action {
	if (DEBUG)
		printf("application_data\n");
}

action application_data_init {
	if (DEBUG)
		printf("application_data_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_application_data_t)); */
}

application_data_tt = KMIP_HEADER 0 KMIP_TAG_APPLICATION_DATA KMIP_ITEM_TYPE_TEXT_STRING ;
application_data = application_data_tt len @application_data_init text_string @application_data_action;

# KMIP_TAG_APPLICATION_NAMESPACE
KMIP_TAG_APPLICATION_NAMESPACE = 0x0003;

action application_namespace_action {
	if (DEBUG)
		printf("application_namespace\n");
}

action application_namespace_init {
	if (DEBUG)
		printf("application_namespace_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_application_namespace_t)); */
}

application_namespace_tt = KMIP_HEADER 0 KMIP_TAG_APPLICATION_NAMESPACE KMIP_ITEM_TYPE_TEXT_STRING ;
application_namespace = application_namespace_tt len @application_namespace_init text_string @application_namespace_action;

# KMIP_TAG_APPLICATION_SPECIFIC_INFORMATION
KMIP_TAG_APPLICATION_SPECIFIC_INFORMATION = 0x0004;

action application_specific_information_action {
	if (DEBUG)
		printf("application_specific_information\n");
}

action application_specific_information_init {
	if (DEBUG)
		printf("application_specific_information_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_application_specific_information_t)); */
}

application_specific_information_tt = KMIP_HEADER 0 KMIP_TAG_APPLICATION_SPECIFIC_INFORMATION KMIP_ITEM_TYPE_STRUCTURE ;
application_specific_information = application_specific_information_tt len @application_specific_information_init @application_specific_information_action;

# KMIP_TAG_ARCHIVE_DATE
KMIP_TAG_ARCHIVE_DATE = 0x0005;

action archive_date_action {
	if (DEBUG)
		printf("archive_date\n");
}

action archive_date_init {
	if (DEBUG)
		printf("archive_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_archive_date_t)); */
}

archive_date_tt = KMIP_HEADER 0 KMIP_TAG_ARCHIVE_DATE KMIP_ITEM_TYPE_DATE_TIME ;
archive_date = archive_date_tt len @archive_date_init long_data @archive_date_action;

# KMIP_TAG_ASYNCHRONOUS_CORRELATION_VALUE
KMIP_TAG_ASYNCHRONOUS_CORRELATION_VALUE = 0x0006;

action asynchronous_correlation_value_action {
	if (DEBUG)
		printf("asynchronous_correlation_value\n");
}

action asynchronous_correlation_value_init {
	if (DEBUG)
		printf("asynchronous_correlation_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_asynchronous_correlation_value_t)); */
}

asynchronous_correlation_value_tt = KMIP_HEADER 0 KMIP_TAG_ASYNCHRONOUS_CORRELATION_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
asynchronous_correlation_value = asynchronous_correlation_value_tt len @asynchronous_correlation_value_init text_string @asynchronous_correlation_value_action;

# KMIP_TAG_ASYNCHRONOUS_INDICATOR
KMIP_TAG_ASYNCHRONOUS_INDICATOR = 0x0007;

action asynchronous_indicator_action {
	if (DEBUG)
		printf("asynchronous_indicator\n");
}

action asynchronous_indicator_init {
	if (DEBUG)
		printf("asynchronous_indicator_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_asynchronous_indicator_t)); */
}

asynchronous_indicator_tt = KMIP_HEADER 0 KMIP_TAG_ASYNCHRONOUS_INDICATOR KMIP_ITEM_TYPE_BOOLEAN ;
asynchronous_indicator = asynchronous_indicator_tt len @asynchronous_indicator_init long_data @asynchronous_indicator_action;

# KMIP_TAG_ATTRIBUTE_INDEX
KMIP_TAG_ATTRIBUTE_INDEX = 0x0009;

action attribute_index_action {
	if (DEBUG)
		printf("attribute_index: %d\n", current_int.u32 );
}

action attribute_index_init {
	if (DEBUG)
		printf("attribute_index_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_index_t)); */
}

attribute_index_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_INDEX KMIP_ITEM_TYPE_INTEGER ;
attribute_index = attribute_index_tt len @attribute_index_init get_int @attribute_index_action;

# KMIP_TAG_ATTRIBUTE_NAME
KMIP_TAG_ATTRIBUTE_NAME = 0x000A;

action attribute_name_action {
	if (current_len.u32 == 0) {
	       	  printf( "attribute_name: %s\n", current_byte_string );
		  /* consume any remaining bytes of padding */
		  i = current_string_len % 8;
	  	  /* printf("%d mod %d\n", current_string_len, i); */
		  if (i != 0)
		     p = p + (8-i);
	}
}

action attribute_name_init {
	if (DEBUG)
		printf("attribute_name_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_name_t)); */
}

attribute_name_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_NAME KMIP_ITEM_TYPE_TEXT_STRING ;
attribute_name = attribute_name_tt len @attribute_name_init @byte_string_malloc text_string @attribute_name_action;

# KMIP_TAG_AUTHENTICATION
KMIP_TAG_AUTHENTICATION = 0x000C;

action authentication_action {
	if (DEBUG)
		printf("authentication\n");
}

action authentication_init {
	if (DEBUG)
		printf("authentication_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_authentication_t)); */
}

authentication_tt = KMIP_HEADER 0 KMIP_TAG_AUTHENTICATION KMIP_ITEM_TYPE_STRUCTURE ;
authentication = authentication_tt len @authentication_init @authentication_action;

# KMIP_TAG_BATCH_COUNT
KMIP_TAG_BATCH_COUNT = 0x000D;

action batch_count_action {
	if (DEBUG)
		printf("batch_count: %d\n", current_int.u32 );
}

action batch_count_init {
	if (DEBUG)
		printf("batch_count_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_batch_count_t)); */
}

batch_count_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_COUNT KMIP_ITEM_TYPE_INTEGER ;
batch_count = batch_count_tt len @batch_count_init get_int @batch_count_action;

# KMIP_TAG_BATCH_ERROR_CONTINUATION_OPTION
KMIP_TAG_BATCH_ERROR_CONTINUATION_OPTION = 0x000E;

action batch_error_continuation_option_action {
	if (DEBUG)
		printf("batch_error_continuation_option\n");
}

action batch_error_continuation_option_init {
	if (DEBUG)
		printf("batch_error_continuation_option_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_batch_error_continuation_option_t)); */
}

batch_error_continuation_option_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_ERROR_CONTINUATION_OPTION KMIP_ITEM_TYPE_ENUMERATION ;
batch_error_continuation_option = batch_error_continuation_option_tt len @batch_error_continuation_option_init get_int @batch_error_continuation_option_action;

# KMIP_TAG_BATCH_ITEM
KMIP_TAG_BATCH_ITEM = 0x000F;

action batch_item_action {
	if (DEBUG)
		printf("batch_item\n");
}

action batch_item_init {
	if (DEBUG)
		printf("batch_item_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_batch_item_t)); */
}

batch_item_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_ITEM KMIP_ITEM_TYPE_STRUCTURE ;
#batch_item = batch_item_tt len @batch_item_init @batch_item_action;

# KMIP_TAG_BATCH_ORDER_OPTION
KMIP_TAG_BATCH_ORDER_OPTION = 0x0010;

action batch_order_option_action {
	if (DEBUG)
		printf("batch_order_option\n");
}

action batch_order_option_init {
	if (DEBUG)
		printf("batch_order_option_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_batch_order_option_t)); */
}

batch_order_option_tt = KMIP_HEADER 0 KMIP_TAG_BATCH_ORDER_OPTION KMIP_ITEM_TYPE_BOOLEAN ;
batch_order_option = batch_order_option_tt len @batch_order_option_init long_data @batch_order_option_action;

# KMIP_TAG_BLOCK_CIPHER_MODE
KMIP_TAG_BLOCK_CIPHER_MODE = 0x0011;

action block_cipher_mode_action {
	if (DEBUG)
		printf("block_cipher_mode\n");
}

action block_cipher_mode_init {
	if (DEBUG)
		printf("block_cipher_mode_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_block_cipher_mode_t)); */
}

block_cipher_mode_tt = KMIP_HEADER 0 KMIP_TAG_BLOCK_CIPHER_MODE KMIP_ITEM_TYPE_ENUMERATION ;
block_cipher_mode = block_cipher_mode_tt len @block_cipher_mode_init get_int @block_cipher_mode_action;

# KMIP_TAG_CANCELLATION_RESULT
KMIP_TAG_CANCELLATION_RESULT = 0x0012;

action cancellation_result_action {
	if (DEBUG)
		printf("cancellation_result\n");
}

action cancellation_result_init {
	if (DEBUG)
		printf("cancellation_result_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cancellation_result_t)); */
}

cancellation_result_tt = KMIP_HEADER 0 KMIP_TAG_CANCELLATION_RESULT KMIP_ITEM_TYPE_ENUMERATION ;
cancellation_result = cancellation_result_tt len @cancellation_result_init get_int @cancellation_result_action;

# KMIP_TAG_CERTIFICATE_IDENTIFIER
KMIP_TAG_CERTIFICATE_IDENTIFIER = 0x0014;

action certificate_identifier_action {
	if (DEBUG)
		printf("certificate_identifier\n");
}

action certificate_identifier_init {
	if (DEBUG)
		printf("certificate_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_identifier_t)); */
}

certificate_identifier_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_IDENTIFIER KMIP_ITEM_TYPE_STRUCTURE ;
certificate_identifier = certificate_identifier_tt len @certificate_identifier_init @certificate_identifier_action;

# KMIP_TAG_CERTIFICATE_ISSUER
KMIP_TAG_CERTIFICATE_ISSUER = 0x0015;

action certificate_issuer_action {
	if (DEBUG)
		printf("certificate_issuer\n");
}

action certificate_issuer_init {
	if (DEBUG)
		printf("certificate_issuer_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_issuer_t)); */
}

certificate_issuer_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_ISSUER KMIP_ITEM_TYPE_STRUCTURE ;
certificate_issuer = certificate_issuer_tt len @certificate_issuer_init @certificate_issuer_action;

# KMIP_TAG_CERTIFICATE_ISSUER_ALTERNATIVE
KMIP_TAG_CERTIFICATE_ISSUER_ALTERNATIVE = 0x0016;

action certificate_issuer_alternative_action {
	if (DEBUG)
		printf("certificate_issuer_alternative\n");
}

action certificate_issuer_alternative_init {
	if (DEBUG)
		printf("certificate_issuer_alternative_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_issuer_alternative_t)); */
}

certificate_issuer_alternative_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_ISSUER_ALTERNATIVE KMIP_ITEM_TYPE_TEXT_STRING ;
certificate_issuer_alternative = certificate_issuer_alternative_tt len @certificate_issuer_alternative_init text_string @certificate_issuer_alternative_action;

# KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED
KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED = 0x0017;

action certificate_issuer_distinguished_action {
	if (DEBUG)
		printf("certificate_issuer_distinguished\n");
}

action certificate_issuer_distinguished_init {
	if (DEBUG)
		printf("certificate_issuer_distinguished_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_issuer_distinguished_t)); */
}

certificate_issuer_distinguished_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED KMIP_ITEM_TYPE_TEXT_STRING ;
certificate_issuer_distinguished = certificate_issuer_distinguished_tt len @certificate_issuer_distinguished_init text_string @certificate_issuer_distinguished_action;

# KMIP_TAG_CERTIFICATE_REQUEST
KMIP_TAG_CERTIFICATE_REQUEST = 0x0018;

action certificate_request_action {
	if (DEBUG)
		printf("certificate_request\n");
}

action certificate_request_init {
	if (DEBUG)
		printf("certificate_request_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_request_t)); */
}

certificate_request_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_REQUEST KMIP_ITEM_TYPE_BYTE_STRING ;
certificate_request = certificate_request_tt len @certificate_request_init text_string @certificate_request_action;

# KMIP_TAG_CERTIFICATE_REQUEST_TYPE
KMIP_TAG_CERTIFICATE_REQUEST_TYPE = 0x0019;

action certificate_request_type_action {
	if (DEBUG)
		printf("certificate_request_type\n");
}

action certificate_request_type_init {
	if (DEBUG)
		printf("certificate_request_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_request_type_t)); */
}

certificate_request_type_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_REQUEST_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
certificate_request_type = certificate_request_type_tt len @certificate_request_type_init get_int @certificate_request_type_action;

# KMIP_TAG_CERTIFICATE_SUBJECT
KMIP_TAG_CERTIFICATE_SUBJECT = 0x001A;

action certificate_subject_action {
	if (DEBUG)
		printf("certificate_subject\n");
}

action certificate_subject_init {
	if (DEBUG)
		printf("certificate_subject_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_subject_t)); */
}

certificate_subject_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_SUBJECT KMIP_ITEM_TYPE_STRUCTURE ;
certificate_subject = certificate_subject_tt len @certificate_subject_init @certificate_subject_action;

# KMIP_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME
KMIP_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME = 0x001B;

action certificate_subject_alternative_name_action {
	if (DEBUG)
		printf("certificate_subject_alternative_name\n");
}

action certificate_subject_alternative_name_init {
	if (DEBUG)
		printf("certificate_subject_alternative_name_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_subject_alternative_name_t)); */
}

certificate_subject_alternative_name_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME KMIP_ITEM_TYPE_TEXT_STRING ;
certificate_subject_alternative_name = certificate_subject_alternative_name_tt len @certificate_subject_alternative_name_init text_string @certificate_subject_alternative_name_action;

# KMIP_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME
KMIP_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME = 0x001C;

action certificate_subject_distinguished_name_action {
	if (DEBUG)
		printf("certificate_subject_distinguished_name\n");
}

action certificate_subject_distinguished_name_init {
	if (DEBUG)
		printf("certificate_subject_distinguished_name_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_subject_distinguished_name_t)); */
}

certificate_subject_distinguished_name_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME KMIP_ITEM_TYPE_TEXT_STRING ;
certificate_subject_distinguished_name = certificate_subject_distinguished_name_tt len @certificate_subject_distinguished_name_init text_string @certificate_subject_distinguished_name_action;

# KMIP_TAG_CERTIFICATE_TYPE
KMIP_TAG_CERTIFICATE_TYPE = 0x001D;

action certificate_type_action {
	if (DEBUG)
		printf("certificate_type\n");
}

action certificate_type_init {
	if (DEBUG)
		printf("certificate_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_type_t)); */
}

certificate_type_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
certificate_type = certificate_type_tt len @certificate_type_init get_int @certificate_type_action;

# KMIP_TAG_CERTIFICATE_VALUE
KMIP_TAG_CERTIFICATE_VALUE = 0x001E;

action certificate_value_action {
	if (DEBUG)
		printf("certificate_value\n");
}

action certificate_value_init {
	if (DEBUG)
		printf("certificate_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_value_t)); */
}

certificate_value_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
certificate_value = certificate_value_tt len @certificate_value_init text_string @certificate_value_action;

# KMIP_TAG_CERTIFICATE
KMIP_TAG_CERTIFICATE = 0x0013;

action certificate_action {
	if (DEBUG)
		printf("certificate\n");
}

action certificate_init {
	if (DEBUG)
		printf("certificate_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_certificate_t)); */
}

certificate_tt = KMIP_HEADER 0 KMIP_TAG_CERTIFICATE KMIP_ITEM_TYPE_STRUCTURE ;
certificate = certificate_tt len @certificate_init certificate_type certificate_value @certificate_action;

# KMIP_TAG_COMPROMISE_DATE
KMIP_TAG_COMPROMISE_DATE = 0x0020;

action compromise_date_action {
	if (DEBUG)
		printf("compromise_date\n");
}

action compromise_date_init {
	if (DEBUG)
		printf("compromise_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_compromise_date_t)); */
}

compromise_date_tt = KMIP_HEADER 0 KMIP_TAG_COMPROMISE_DATE KMIP_ITEM_TYPE_DATE_TIME ;
compromise_date = compromise_date_tt len @compromise_date_init long_data @compromise_date_action;

# KMIP_TAG_COMPROMISE_OCCURRENCE_DATE
KMIP_TAG_COMPROMISE_OCCURRENCE_DATE = 0x0021;

action compromise_occurrence_date_action {
	if (DEBUG)
		printf("compromise_occurrence_date\n");
}

action compromise_occurrence_date_init {
	if (DEBUG)
		printf("compromise_occurrence_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_compromise_occurrence_date_t)); */
}

compromise_occurrence_date_tt = KMIP_HEADER 0 KMIP_TAG_COMPROMISE_OCCURRENCE_DATE KMIP_ITEM_TYPE_DATE_TIME ;
compromise_occurrence_date = compromise_occurrence_date_tt len @compromise_occurrence_date_init long_data @compromise_occurrence_date_action;

# KMIP_TAG_CONTACT_INFORMATION
KMIP_TAG_CONTACT_INFORMATION = 0x0022;

action contact_information_action {
	if (DEBUG)
		printf("contact_information\n");
}

action contact_information_init {
	if (DEBUG)
		printf("contact_information_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_contact_information_t)); */
}

contact_information_tt = KMIP_HEADER 0 KMIP_TAG_CONTACT_INFORMATION KMIP_ITEM_TYPE_TEXT_STRING ;
contact_information = contact_information_tt len @contact_information_init text_string @contact_information_action;

# KMIP_TAG_CREDENTIAL
KMIP_TAG_CREDENTIAL = 0x0023;

action credential_action {
	if (DEBUG)
		printf("credential\n");
}

action credential_init {
	if (DEBUG)
		printf("credential_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_credential_t)); */
}

credential_tt = KMIP_HEADER 0 KMIP_TAG_CREDENTIAL KMIP_ITEM_TYPE_STRUCTURE ;
credential = credential_tt len @credential_init @credential_action;

# KMIP_TAG_CREDENTIAL_TYPE
KMIP_TAG_CREDENTIAL_TYPE = 0x0024;

action credential_type_action {
	if (DEBUG)
		printf("credential_type\n");
}

action credential_type_init {
	if (DEBUG)
		printf("credential_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_credential_type_t)); */
}

credential_type_tt = KMIP_HEADER 0 KMIP_TAG_CREDENTIAL_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
credential_type = credential_type_tt len @credential_type_init get_int @credential_type_action;

# KMIP_TAG_CREDENTIAL_VALUE
KMIP_TAG_CREDENTIAL_VALUE = 0x0025;

action credential_value_action {
	if (DEBUG)
		printf("credential_value\n");
}

action credential_value_init {
	if (DEBUG)
		printf("credential_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_credential_value_t)); */
}

#credential_value_tt = KMIP_HEADER 0 KMIP_TAG_CREDENTIAL_VALUE KMIP_ITEM_TYPE_ ;
#credential_value = credential_value_tt len @credential_value_init @credential_value_action;

# KMIP_TAG_CRITICALITY_INDICATOR
KMIP_TAG_CRITICALITY_INDICATOR = 0x0026;

action criticality_indicator_action {
	if (DEBUG)
		printf("criticality_indicator\n");
}

action criticality_indicator_init {
	if (DEBUG)
		printf("criticality_indicator_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_criticality_indicator_t)); */
}

criticality_indicator_tt = KMIP_HEADER 0 KMIP_TAG_CRITICALITY_INDICATOR KMIP_ITEM_TYPE_BOOLEAN ;
criticality_indicator = criticality_indicator_tt len @criticality_indicator_init long_data @criticality_indicator_action;

# KMIP_TAG_CRT_COEFFICIENT
KMIP_TAG_CRT_COEFFICIENT = 0x0027;

action crt_coefficient_action {
	if (DEBUG)
		printf("crt_coefficient\n");
}

action crt_coefficient_init {
	if (DEBUG)
		printf("crt_coefficient_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_crt_coefficient_t)); */
}

crt_coefficient_tt = KMIP_HEADER 0 KMIP_TAG_CRT_COEFFICIENT KMIP_ITEM_TYPE_BIG_INTEGER ;
crt_coefficient = crt_coefficient_tt len @crt_coefficient_init @crt_coefficient_action;

# KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM
KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM = 0x0028;

action cryptographic_algorithm_action {
	if (DEBUG)
		printf("cryptographic_algorithm\n");
}

action cryptographic_algorithm_init {
	if (DEBUG)
		printf("cryptographic_algorithm_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cryptographic_algorithm_t)); */
}

cryptographic_algorithm_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM KMIP_ITEM_TYPE_ENUMERATION ;
cryptographic_algorithm = cryptographic_algorithm_tt len @cryptographic_algorithm_init get_int @cryptographic_algorithm_action;

# KMIP_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS
KMIP_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS = 0x0029;

action cryptographic_domain_parameters_action {
	if (DEBUG)
		printf("cryptographic_domain_parameters\n");
}

action cryptographic_domain_parameters_init {
	if (DEBUG)
		printf("cryptographic_domain_parameters_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cryptographic_domain_parameters_t)); */
}

cryptographic_domain_parameters_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS KMIP_ITEM_TYPE_STRUCTURE ;
cryptographic_domain_parameters = cryptographic_domain_parameters_tt len @cryptographic_domain_parameters_init @cryptographic_domain_parameters_action;

# KMIP_TAG_CRYPTOGRAPHIC_LENGTH
KMIP_TAG_CRYPTOGRAPHIC_LENGTH = 0x002A;

action cryptographic_length_action {
	if (DEBUG)
		printf("cryptographic_length\n");
}

action cryptographic_length_init {
	if (DEBUG)
		printf("cryptographic_length_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cryptographic_length_t)); */
}

cryptographic_length_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_LENGTH KMIP_ITEM_TYPE_INTEGER ;
cryptographic_length = cryptographic_length_tt len @cryptographic_length_init get_int @cryptographic_length_action;

# KMIP_TAG_CRYPTOGRAPHIC_PARAMETERS
KMIP_TAG_CRYPTOGRAPHIC_PARAMETERS = 0x002B;

action cryptographic_parameters_action {
	if (DEBUG)
		printf("cryptographic_parameters\n");
}

action cryptographic_parameters_init {
	if (DEBUG)
		printf("cryptographic_parameters_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cryptographic_parameters_t)); */
}

cryptographic_parameters_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_PARAMETERS KMIP_ITEM_TYPE_STRUCTURE ;
cryptographic_parameters = cryptographic_parameters_tt len @cryptographic_parameters_init @cryptographic_parameters_action;

# KMIP_TAG_CRYPTOGRAPHIC_USAGE_MASK
KMIP_TAG_CRYPTOGRAPHIC_USAGE_MASK = 0x002C;

action cryptographic_usage_mask_action {
	if (DEBUG)
		printf("cryptographic_usage_mask\n");
}

action cryptographic_usage_mask_init {
	if (DEBUG)
		printf("cryptographic_usage_mask_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_cryptographic_usage_mask_t)); */
}

cryptographic_usage_mask_tt = KMIP_HEADER 0 KMIP_TAG_CRYPTOGRAPHIC_USAGE_MASK KMIP_ITEM_TYPE_INTEGER ;
cryptographic_usage_mask = cryptographic_usage_mask_tt len @cryptographic_usage_mask_init get_int @cryptographic_usage_mask_action;

# KMIP_TAG_CUSTOM_ATTRIBUTE
KMIP_TAG_CUSTOM_ATTRIBUTE = 0x002D;

action custom_attribute_action {
	if (DEBUG)
		printf("custom_attribute\n");
}

action custom_attribute_init {
	if (DEBUG)
		printf("custom_attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_custom_attribute_t)); */
}

#custom_attribute_tt = KMIP_HEADER 0 KMIP_TAG_CUSTOM_ATTRIBUTE KMIP_ITEM_TYPE_ ;
#custom_attribute = custom_attribute_tt len @custom_attribute_init @custom_attribute_action;

# KMIP_TAG_D
KMIP_TAG_D = 0x002E;

action d_action {
	if (DEBUG)
		printf("d\n");
}

action d_init {
	if (DEBUG)
		printf("d_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_d_t)); */
}

d_tt = KMIP_HEADER 0 KMIP_TAG_D KMIP_ITEM_TYPE_BIG_INTEGER ;
d = d_tt len @d_init @d_action;

# KMIP_TAG_DEACTIVATION_DATE
KMIP_TAG_DEACTIVATION_DATE = 0x002F;

action deactivation_date_action {
	if (DEBUG)
		printf("deactivation_date\n");
}

action deactivation_date_init {
	if (DEBUG)
		printf("deactivation_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_deactivation_date_t)); */
}

deactivation_date_tt = KMIP_HEADER 0 KMIP_TAG_DEACTIVATION_DATE KMIP_ITEM_TYPE_DATE_TIME ;
deactivation_date = deactivation_date_tt len @deactivation_date_init long_data @deactivation_date_action;

# KMIP_TAG_DERIVATION_DATA
KMIP_TAG_DERIVATION_DATA = 0x0030;

action derivation_data_action {
	if (DEBUG)
		printf("derivation_data\n");
}

action derivation_data_init {
	if (DEBUG)
		printf("derivation_data_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_derivation_data_t)); */
}

derivation_data_tt = KMIP_HEADER 0 KMIP_TAG_DERIVATION_DATA KMIP_ITEM_TYPE_BYTE_STRING ;
derivation_data = derivation_data_tt len @derivation_data_init text_string @derivation_data_action;

# KMIP_TAG_DERIVATION_METHOD
KMIP_TAG_DERIVATION_METHOD = 0x0031;

action derivation_method_action {
	if (DEBUG)
		printf("derivation_method\n");
}

action derivation_method_init {
	if (DEBUG)
		printf("derivation_method_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_derivation_method_t)); */
}

derivation_method_tt = KMIP_HEADER 0 KMIP_TAG_DERIVATION_METHOD KMIP_ITEM_TYPE_ENUMERATION ;
derivation_method = derivation_method_tt len @derivation_method_init get_int @derivation_method_action;

# KMIP_TAG_DERIVATION_PARAMETERS
KMIP_TAG_DERIVATION_PARAMETERS = 0x0032;

action derivation_parameters_action {
	if (DEBUG)
		printf("derivation_parameters\n");
}

action derivation_parameters_init {
	if (DEBUG)
		printf("derivation_parameters_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_derivation_parameters_t)); */
}

derivation_parameters_tt = KMIP_HEADER 0 KMIP_TAG_DERIVATION_PARAMETERS KMIP_ITEM_TYPE_STRUCTURE ;
derivation_parameters = derivation_parameters_tt len @derivation_parameters_init @derivation_parameters_action;

# KMIP_TAG_DESTROY_DATE
KMIP_TAG_DESTROY_DATE = 0x0033;

action destroy_date_action {
	if (DEBUG)
		printf("destroy_date\n");
}

action destroy_date_init {
	if (DEBUG)
		printf("destroy_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_destroy_date_t)); */
}

destroy_date_tt = KMIP_HEADER 0 KMIP_TAG_DESTROY_DATE KMIP_ITEM_TYPE_DATE_TIME ;
destroy_date = destroy_date_tt len @destroy_date_init long_data @destroy_date_action;

# KMIP_TAG_DIGEST
KMIP_TAG_DIGEST = 0x0034;

action digest_action {
	if (DEBUG)
		printf("digest\n");
}

action digest_init {
	if (DEBUG)
		printf("digest_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_digest_t)); */
}

digest_tt = KMIP_HEADER 0 KMIP_TAG_DIGEST KMIP_ITEM_TYPE_STRUCTURE ;
digest = digest_tt len @digest_init @digest_action;

# KMIP_TAG_DIGEST_VALUE
KMIP_TAG_DIGEST_VALUE = 0x0035;

action digest_value_action {
	if (DEBUG)
		printf("digest_value\n");
}

action digest_value_init {
	if (DEBUG)
		printf("digest_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_digest_value_t)); */
}

digest_value_tt = KMIP_HEADER 0 KMIP_TAG_DIGEST_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
digest_value = digest_value_tt len @digest_value_init text_string @digest_value_action;

# KMIP_TAG_ENCRYPTION_KEY_INFORMATION
KMIP_TAG_ENCRYPTION_KEY_INFORMATION = 0x0036;

action encryption_key_information_action {
	if (DEBUG)
		printf("encryption_key_information\n");
}

action encryption_key_information_init {
	if (DEBUG)
		printf("encryption_key_information_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_encryption_key_information_t)); */
}

encryption_key_information_tt = KMIP_HEADER 0 KMIP_TAG_ENCRYPTION_KEY_INFORMATION KMIP_ITEM_TYPE_STRUCTURE ;
encryption_key_information = encryption_key_information_tt len @encryption_key_information_init @encryption_key_information_action;

# KMIP_TAG_G
KMIP_TAG_G = 0x0037;

action g_action {
	if (DEBUG)
		printf("g\n");
}

action g_init {
	if (DEBUG)
		printf("g_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_g_t)); */
}

g_tt = KMIP_HEADER 0 KMIP_TAG_G KMIP_ITEM_TYPE_BIG_INTEGER ;
g = g_tt len @g_init @g_action;

# KMIP_TAG_HASHING_ALGORITHM
KMIP_TAG_HASHING_ALGORITHM = 0x0038;

action hashing_algorithm_action {
	if (DEBUG)
		printf("hashing_algorithm\n");
}

action hashing_algorithm_init {
	if (DEBUG)
		printf("hashing_algorithm_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_hashing_algorithm_t)); */
}

hashing_algorithm_tt = KMIP_HEADER 0 KMIP_TAG_HASHING_ALGORITHM KMIP_ITEM_TYPE_ENUMERATION ;
hashing_algorithm = hashing_algorithm_tt len @hashing_algorithm_init get_int @hashing_algorithm_action;

# KMIP_TAG_INITIAL_DATE
KMIP_TAG_INITIAL_DATE = 0x0039;

action initial_date_action {
	if (DEBUG)
		printf("initial_date\n");
}

action initial_date_init {
	if (DEBUG)
		printf("initial_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_initial_date_t)); */
}

initial_date_tt = KMIP_HEADER 0 KMIP_TAG_INITIAL_DATE KMIP_ITEM_TYPE_DATE_TIME ;
initial_date = initial_date_tt len @initial_date_init long_data @initial_date_action;

# KMIP_TAG_INITIALIZATION_VECTOR
KMIP_TAG_INITIALIZATION_VECTOR = 0x003A;

action initialization_vector_action {
	if (DEBUG)
		printf("initialization_vector\n");
}

action initialization_vector_init {
	if (DEBUG)
		printf("initialization_vector_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_initialization_vector_t)); */
}

initialization_vector_tt = KMIP_HEADER 0 KMIP_TAG_INITIALIZATION_VECTOR KMIP_ITEM_TYPE_BYTE_STRING ;
initialization_vector = initialization_vector_tt len @initialization_vector_init text_string @initialization_vector_action;

# KMIP_TAG_ISSUER
KMIP_TAG_ISSUER = 0x003B;

action issuer_action {
	if (DEBUG)
		printf("issuer\n");
}

action issuer_init {
	if (DEBUG)
		printf("issuer_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_issuer_t)); */
}

issuer_tt = KMIP_HEADER 0 KMIP_TAG_ISSUER KMIP_ITEM_TYPE_TEXT_STRING ;
issuer = issuer_tt len @issuer_init text_string @issuer_action;

# KMIP_TAG_ITERATION_COUNT
KMIP_TAG_ITERATION_COUNT = 0x003C;

action iteration_count_action {
	if (DEBUG)
		printf("iteration_count\n");
}

action iteration_count_init {
	if (DEBUG)
		printf("iteration_count_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_iteration_count_t)); */
}

iteration_count_tt = KMIP_HEADER 0 KMIP_TAG_ITERATION_COUNT KMIP_ITEM_TYPE_INTEGER ;
iteration_count = iteration_count_tt len @iteration_count_init get_int @iteration_count_action;

# KMIP_TAG_IV_COUNTER_NONCE
KMIP_TAG_IV_COUNTER_NONCE = 0x003D;

action iv_counter_nonce_action {
	if (DEBUG)
		printf("iv_counter_nonce\n");
}

action iv_counter_nonce_init {
	if (DEBUG)
		printf("iv_counter_nonce_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_iv_counter_nonce_t)); */
}

iv_counter_nonce_tt = KMIP_HEADER 0 KMIP_TAG_IV_COUNTER_NONCE KMIP_ITEM_TYPE_BYTE_STRING ;
iv_counter_nonce = iv_counter_nonce_tt len @iv_counter_nonce_init text_string @iv_counter_nonce_action;

# KMIP_TAG_J
KMIP_TAG_J = 0x003E;

action j_action {
	if (DEBUG)
		printf("j\n");
}

action j_init {
	if (DEBUG)
		printf("j_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_j_t)); */
}

j_tt = KMIP_HEADER 0 KMIP_TAG_J KMIP_ITEM_TYPE_BIG_INTEGER ;
j = j_tt len @j_init @j_action;

# KMIP_TAG_KEY
KMIP_TAG_KEY = 0x003F;

action key_action {
	if (DEBUG)
		printf("key\n");
}

action key_init {
	if (DEBUG)
		printf("key_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_t)); */
}

key_tt = KMIP_HEADER 0 KMIP_TAG_KEY KMIP_ITEM_TYPE_BYTE_STRING ;
key = key_tt len @key_init text_string @key_action;

# KMIP_TAG_KEY_FORMAT_TYPE
KMIP_TAG_KEY_FORMAT_TYPE = 0x0042;

action key_format_type_action {
	if (DEBUG)
		printf("key_format_type\n");
}

action key_format_type_init {
	if (DEBUG)
		printf("key_format_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_format_type_t)); */
}

key_format_type_tt = KMIP_HEADER 0 KMIP_TAG_KEY_FORMAT_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
key_format_type = key_format_type_tt len @key_format_type_init get_int @key_format_type_action;

# KMIP_TAG_KEY_MATERIAL
KMIP_TAG_KEY_MATERIAL = 0x0043;

action key_material_byte_string_action {
	if (DEBUG)
		printf("key_material_byte_string\n");
}

action key_material_byte_string_init {
	if (DEBUG)
		printf("key_material_byte_string_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_material_byte_string_t)); */
}

key_material_byte_string_tt = KMIP_HEADER 0 KMIP_TAG_KEY_MATERIAL KMIP_ITEM_TYPE_BYTE_STRING ;
key_material_byte_string = key_material_byte_string_tt len @byte_string_malloc text_string @byte_string_action;

action key_material_struct_action {
	if (DEBUG)
		printf("key_material_struct\n");
}

action key_material_struct_init {
	if (DEBUG)
		printf("key_material_struct_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_material_struct_t)); */
}

key_material_struct_tt = KMIP_HEADER 0 KMIP_TAG_KEY_MATERIAL KMIP_ITEM_TYPE_STRUCTURE ;
key_material_struct = key_material_struct_tt len @key_material_struct_init @key_material_struct_action;

# KMIP_TAG_KEY_VALUE
KMIP_TAG_KEY_VALUE = 0x0045;

action key_value_struct_action {
	if (DEBUG)
		printf("key_value_struct\n");
}

action key_value_struct_init {
	if (DEBUG)
		printf("key_value_struct_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_value_t)); */
}

key_value_struct_tt = KMIP_HEADER 0 KMIP_TAG_KEY_VALUE KMIP_ITEM_TYPE_STRUCTURE ;
key_value_struct = key_value_struct_tt len @key_value_struct_init ( key_material_struct | key_material_byte_string );

action key_value_byte_string_action {
	if (DEBUG)
		printf("key_value_byte_string\n");
}

action key_value_byte_string_init {
	if (DEBUG)
		printf("key_value_byte_string_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_value_t)); */
}

key_value_byte_string_tt = KMIP_HEADER 0 KMIP_TAG_KEY_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
key_value_byte_string = key_value_byte_string_tt len @key_value_byte_string_init @key_value_byte_string_action;

# KMIP_TAG_KEY_BLOCK
KMIP_TAG_KEY_BLOCK = 0x0040;

action key_block_action {
	if (DEBUG)
		printf("key_block\n");
}

action key_block_init {
	if (DEBUG)
		printf("key_block_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_block_t)); */
}

key_block_tt = KMIP_HEADER 0 KMIP_TAG_KEY_BLOCK KMIP_ITEM_TYPE_STRUCTURE ;
key_block = key_block_tt len @key_block_init key_format_type ( key_value_struct | key_value_byte_string ) cryptographic_algorithm cryptographic_length @key_block_action;

# KMIP_TAG_KEY_COMPRESSION_TYPE
KMIP_TAG_KEY_COMPRESSION_TYPE = 0x0041;

action key_compression_type_action {
	if (DEBUG)
		printf("key_compression_type\n");
}

action key_compression_type_init {
	if (DEBUG)
		printf("key_compression_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_compression_type_t)); */
}

key_compression_type_tt = KMIP_HEADER 0 KMIP_TAG_KEY_COMPRESSION_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
key_compression_type = key_compression_type_tt len @key_compression_type_init get_int @key_compression_type_action;

# KMIP_TAG_KEY_PART_IDENTIFIER
KMIP_TAG_KEY_PART_IDENTIFIER = 0x0044;

action key_part_identifier_action {
	if (DEBUG)
		printf("key_part_identifier\n");
}

action key_part_identifier_init {
	if (DEBUG)
		printf("key_part_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_part_identifier_t)); */
}

key_part_identifier_tt = KMIP_HEADER 0 KMIP_TAG_KEY_PART_IDENTIFIER KMIP_ITEM_TYPE_INTEGER ;
key_part_identifier = key_part_identifier_tt len @key_part_identifier_init get_int @key_part_identifier_action;

# KMIP_TAG_KEY_WRAPPING_DATA
KMIP_TAG_KEY_WRAPPING_DATA = 0x0046;

action key_wrapping_data_action {
	if (DEBUG)
		printf("key_wrapping_data\n");
}

action key_wrapping_data_init {
	if (DEBUG)
		printf("key_wrapping_data_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_wrapping_data_t)); */
}

key_wrapping_data_tt = KMIP_HEADER 0 KMIP_TAG_KEY_WRAPPING_DATA KMIP_ITEM_TYPE_STRUCTURE ;
key_wrapping_data = key_wrapping_data_tt len @key_wrapping_data_init @key_wrapping_data_action;

# KMIP_TAG_KEY_WRAPPING_SPECIFICATION
KMIP_TAG_KEY_WRAPPING_SPECIFICATION = 0x0047;

action key_wrapping_specification_action {
	if (DEBUG)
		printf("key_wrapping_specification\n");
}

action key_wrapping_specification_init {
	if (DEBUG)
		printf("key_wrapping_specification_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_wrapping_specification_t)); */
}

key_wrapping_specification_tt = KMIP_HEADER 0 KMIP_TAG_KEY_WRAPPING_SPECIFICATION KMIP_ITEM_TYPE_STRUCTURE ;
key_wrapping_specification = key_wrapping_specification_tt len @key_wrapping_specification_init @key_wrapping_specification_action;

# KMIP_TAG_LAST_CHANGE_DATE
KMIP_TAG_LAST_CHANGE_DATE = 0x0048;

action last_change_date_action {
	if (DEBUG)
		printf("last_change_date\n");
}

action last_change_date_init {
	if (DEBUG)
		printf("last_change_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_last_change_date_t)); */
}

last_change_date_tt = KMIP_HEADER 0 KMIP_TAG_LAST_CHANGE_DATE KMIP_ITEM_TYPE_DATE_TIME ;
last_change_date = last_change_date_tt len @last_change_date_init @last_change_date_action;

# KMIP_TAG_LEASE_TIME
KMIP_TAG_LEASE_TIME = 0x0049;

action lease_time_action {
	if (DEBUG)
		printf("lease_time\n");
}

action lease_time_init {
	if (DEBUG)
		printf("lease_time_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_lease_time_t)); */
}

lease_time_tt = KMIP_HEADER 0 KMIP_TAG_LEASE_TIME KMIP_ITEM_TYPE_INTERVAL ;
lease_time = lease_time_tt len @lease_time_init long_data @lease_time_action;

# KMIP_TAG_LINK
KMIP_TAG_LINK = 0x004A;

action link_action {
	if (DEBUG)
		printf("link\n");
}

action link_init {
	if (DEBUG)
		printf("link_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_link_t)); */
}

link_tt = KMIP_HEADER 0 KMIP_TAG_LINK KMIP_ITEM_TYPE_STRUCTURE ;
link = link_tt len @link_init @link_action;

# KMIP_TAG_LINK_TYPE
KMIP_TAG_LINK_TYPE = 0x004B;

action link_type_action {
	if (DEBUG)
		printf("link_type: 0x%x\n", current_int.u32 );
}

action link_type_init {
	if (DEBUG)
		printf("link_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_link_type_t)); */
}

link_type_tt = KMIP_HEADER 0 KMIP_TAG_LINK_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
link_type = link_type_tt len @link_type_init get_int @link_type_action;

# KMIP_TAG_LINKED_OBJECT_IDENTIFIER
KMIP_TAG_LINKED_OBJECT_IDENTIFIER = 0x004C;

action linked_object_identifier_action {
	if (DEBUG)
		printf("linked_object_identifier\n");
}

action linked_object_identifier_init {
	if (DEBUG)
		printf("linked_object_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_linked_object_identifier_t)); */
}

linked_object_identifier_tt = KMIP_HEADER 0 KMIP_TAG_LINKED_OBJECT_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
linked_object_identifier = linked_object_identifier_tt len @linked_object_identifier_init uuid @linked_object_identifier_action;

# KMIP_TAG_MAC_SIGNATURE
KMIP_TAG_MAC_SIGNATURE = 0x004D;

action mac_signature_action {
	if (DEBUG)
		printf("mac_signature\n");
}

action mac_signature_init {
	if (DEBUG)
		printf("mac_signature_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_mac_signature_t)); */
}

mac_signature_tt = KMIP_HEADER 0 KMIP_TAG_MAC_SIGNATURE KMIP_ITEM_TYPE_BYTE_STRING ;
mac_signature = mac_signature_tt len @mac_signature_init text_string @mac_signature_action;

# KMIP_TAG_MAC_SIGNATURE_KEY_INFORMATION
KMIP_TAG_MAC_SIGNATURE_KEY_INFORMATION = 0x004E;

action mac_signature_key_information_action {
	if (DEBUG)
		printf("mac_signature_key_information\n");
}

action mac_signature_key_information_init {
	if (DEBUG)
		printf("mac_signature_key_information_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_mac_signature_key_information_t)); */
}

mac_signature_key_information_tt = KMIP_HEADER 0 KMIP_TAG_MAC_SIGNATURE_KEY_INFORMATION KMIP_ITEM_TYPE_TEXT_STRING ;
mac_signature_key_information = mac_signature_key_information_tt len @mac_signature_key_information_init text_string @mac_signature_key_information_action;

# KMIP_TAG_MAXIMUM_ITEMS
KMIP_TAG_MAXIMUM_ITEMS = 0x004F;

action maximum_items_action {
	if (DEBUG)
		printf("maximum_items\n");
}

action maximum_items_init {
	if (DEBUG)
		printf("maximum_items_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_maximum_items_t)); */
}

maximum_items_tt = KMIP_HEADER 0 KMIP_TAG_MAXIMUM_ITEMS KMIP_ITEM_TYPE_INTEGER ;
maximum_items = maximum_items_tt len @maximum_items_init get_int @maximum_items_action;

# KMIP_TAG_MAXIMUM_RESPONSE_SIZE
KMIP_TAG_MAXIMUM_RESPONSE_SIZE = 0x0050;

action maximum_response_size_action {
	if (DEBUG)
		printf("maximum_response_size\n");
}

action maximum_response_size_init {
	if (DEBUG)
		printf("maximum_response_size_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_maximum_response_size_t)); */
}

maximum_response_size_tt = KMIP_HEADER 0 KMIP_TAG_MAXIMUM_RESPONSE_SIZE KMIP_ITEM_TYPE_INTEGER ;
maximum_response_size = maximum_response_size_tt len @maximum_response_size_init get_int @maximum_response_size_action;

# KMIP_TAG_MESSAGE_EXTENSION
KMIP_TAG_MESSAGE_EXTENSION = 0x0051;

action message_extension_action {
	if (DEBUG)
		printf("message_extension\n");
}

action message_extension_init {
	if (DEBUG)
		printf("message_extension_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_message_extension_t)); */
}

message_extension_tt = KMIP_HEADER 0 KMIP_TAG_MESSAGE_EXTENSION KMIP_ITEM_TYPE_STRUCTURE ;
message_extension = message_extension_tt len @message_extension_init @message_extension_action;

# KMIP_TAG_MODULUS
KMIP_TAG_MODULUS = 0x0052;

action modulus_action {
	if (DEBUG)
		printf("modulus\n");
}

action modulus_init {
	if (DEBUG)
		printf("modulus_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_modulus_t)); */
}

modulus_tt = KMIP_HEADER 0 KMIP_TAG_MODULUS KMIP_ITEM_TYPE_BIG_INTEGER ;
modulus = modulus_tt len @modulus_init @modulus_action;

# KMIP_TAG_NAME
KMIP_TAG_NAME = 0x0053;

action name_action {
	if (DEBUG)
		printf("name\n");
}

action name_init {
	if (DEBUG)
		printf("name_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_name_t)); */
}

name_tt = KMIP_HEADER 0 KMIP_TAG_NAME KMIP_ITEM_TYPE_STRUCTURE ;
name = name_tt len @name_init @name_action;

# KMIP_TAG_NAME_TYPE
KMIP_TAG_NAME_TYPE = 0x0054;

action name_type_action {
	if (DEBUG)
		printf("name_type\n");
}

action name_type_init {
	if (DEBUG)
		printf("name_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_name_type_t)); */
}

name_type_tt = KMIP_HEADER 0 KMIP_TAG_NAME_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
name_type = name_type_tt len @name_type_init @name_type_action;

# KMIP_TAG_NAME_VALUE
KMIP_TAG_NAME_VALUE = 0x0055;

action name_value_action {
	if (DEBUG)
		printf("name_value\n");
}

action name_value_init {
	if (DEBUG)
		printf("name_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_name_value_t)); */
}

name_value_tt = KMIP_HEADER 0 KMIP_TAG_NAME_VALUE KMIP_ITEM_TYPE_TEXT_STRING ;
name_value = name_value_tt len @name_value_init text_string @name_value_action;

# KMIP_TAG_OBJECT_GROUP
KMIP_TAG_OBJECT_GROUP = 0x0056;

action object_group_action {
	if (DEBUG)
		printf("object_group\n");
}

action object_group_init {
	if (DEBUG)
		printf("object_group_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_object_group_t)); */
}

object_group_tt = KMIP_HEADER 0 KMIP_TAG_OBJECT_GROUP KMIP_ITEM_TYPE_TEXT_STRING ;
object_group = object_group_tt len @object_group_init text_string @object_group_action;

# KMIP_TAG_OBJECT_TYPE
KMIP_TAG_OBJECT_TYPE = 0x0057;

action object_type_action {
	if (DEBUG)
		printf("object_type: %d\n", current_int.u32 );
}

action object_type_init {
	if (DEBUG)
		printf("object_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_object_type_t)); */
}

object_type_tt = KMIP_HEADER 0 KMIP_TAG_OBJECT_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
object_type = object_type_tt len @object_type_init get_int @object_type_action;

# KMIP_TAG_OFFSET
KMIP_TAG_OFFSET = 0x0058;

action offset_action {
	if (DEBUG)
		printf("offset\n");
}

action offset_init {
	if (DEBUG)
		printf("offset_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_offset_t)); */
}

offset_tt = KMIP_HEADER 0 KMIP_TAG_OFFSET KMIP_ITEM_TYPE_INTERVAL ;
offset = offset_tt len @offset_init @offset_action;

# KMIP_TAG_OPAQUE_DATA_TYPE
KMIP_TAG_OPAQUE_DATA_TYPE = 0x0059;

action opaque_data_type_action {
	if (DEBUG)
		printf("opaque_data_type\n");
}

action opaque_data_type_init {
	if (DEBUG)
		printf("opaque_data_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_opaque_data_type_t)); */
}

opaque_data_type_tt = KMIP_HEADER 0 KMIP_TAG_OPAQUE_DATA_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
opaque_data_type = opaque_data_type_tt len @opaque_data_type_init get_int @opaque_data_type_action;

# KMIP_TAG_OPAQUE_DATA_VALUE
KMIP_TAG_OPAQUE_DATA_VALUE = 0x005A;

action opaque_data_value_action {
	if (DEBUG)
		printf("opaque_data_value\n");
}

action opaque_data_value_init {
	if (DEBUG)
		printf("opaque_data_value_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_opaque_data_value_t)); */
}

opaque_data_value_tt = KMIP_HEADER 0 KMIP_TAG_OPAQUE_DATA_VALUE KMIP_ITEM_TYPE_BYTE_STRING ;
opaque_data_value = opaque_data_value_tt len @opaque_data_value_init text_string @opaque_data_value_action;

# KMIP_TAG_OPAQUE_OBJECT
KMIP_TAG_OPAQUE_OBJECT = 0x005B;

action opaque_object_action {
	if (DEBUG)
		printf("opaque_object\n");
}

action opaque_object_init {
	if (DEBUG)
		printf("opaque_object_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_opaque_object_t)); */
}

opaque_object_tt = KMIP_HEADER 0 KMIP_TAG_OPAQUE_OBJECT KMIP_ITEM_TYPE_STRUCTURE ;
opaque_object = opaque_object_tt len @opaque_object_init @opaque_object_action;

# KMIP_TAG_OPERATION
KMIP_TAG_OPERATION = 0x005C;

action operation_action {
	if (DEBUG)
		printf("operation: 0x%x\n", current_int.u32 );
}

action operation_init {
	if (DEBUG)
		printf("operation_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_operation_t)); */
}

operation_tt = KMIP_HEADER 0 KMIP_TAG_OPERATION KMIP_ITEM_TYPE_ENUMERATION ;
operation = operation_tt len @operation_init get_int @operation_action;

# KMIP_TAG_OPERATION_POLICY_NAME
KMIP_TAG_OPERATION_POLICY_NAME = 0x005D;

action operation_policy_name_action {
	if (DEBUG)
		printf("operation_policy_name\n");
}

action operation_policy_name_init {
	if (DEBUG)
		printf("operation_policy_name_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_operation_policy_name_t)); */
}

operation_policy_name_tt = KMIP_HEADER 0 KMIP_TAG_OPERATION_POLICY_NAME KMIP_ITEM_TYPE_TEXT_STRING ;
operation_policy_name = operation_policy_name_tt len @operation_policy_name_init text_string @operation_policy_name_action;

# KMIP_TAG_P
KMIP_TAG_P = 0x005E;

action p_action {
	if (DEBUG)
		printf("p\n");
}

action p_init {
	if (DEBUG)
		printf("p_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_p_t)); */
}

p_tt = KMIP_HEADER 0 KMIP_TAG_P KMIP_ITEM_TYPE_BIG_INTEGER ;
p = p_tt len @p_init @p_action;

# KMIP_TAG_PADDING_METHOD
KMIP_TAG_PADDING_METHOD = 0x005F;

action padding_method_action {
	if (DEBUG)
		printf("padding_method\n");
}

action padding_method_init {
	if (DEBUG)
		printf("padding_method_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_padding_method_t)); */
}

padding_method_tt = KMIP_HEADER 0 KMIP_TAG_PADDING_METHOD KMIP_ITEM_TYPE_ENUMERATION ;
padding_method = padding_method_tt len @padding_method_init get_int @padding_method_action;

# KMIP_TAG_PRIME_EXPONENT_P
KMIP_TAG_PRIME_EXPONENT_P = 0x0060;

action prime_exponent_p_action {
	if (DEBUG)
		printf("prime_exponent_p\n");
}

action prime_exponent_p_init {
	if (DEBUG)
		printf("prime_exponent_p_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_prime_exponent_p_t)); */
}

prime_exponent_p_tt = KMIP_HEADER 0 KMIP_TAG_PRIME_EXPONENT_P KMIP_ITEM_TYPE_BIG_INTEGER ;
prime_exponent_p = prime_exponent_p_tt len @prime_exponent_p_init @prime_exponent_p_action;

# KMIP_TAG_PRIME_EXPONENT_Q
KMIP_TAG_PRIME_EXPONENT_Q = 0x0061;

action prime_exponent_q_action {
	if (DEBUG)
		printf("prime_exponent_q\n");
}

action prime_exponent_q_init {
	if (DEBUG)
		printf("prime_exponent_q_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_prime_exponent_q_t)); */
}

prime_exponent_q_tt = KMIP_HEADER 0 KMIP_TAG_PRIME_EXPONENT_Q KMIP_ITEM_TYPE_BIG_INTEGER ;
prime_exponent_q = prime_exponent_q_tt len @prime_exponent_q_init @prime_exponent_q_action;

# KMIP_TAG_PRIME_FIELD_SIZE
KMIP_TAG_PRIME_FIELD_SIZE = 0x0062;

action prime_field_size_action {
	if (DEBUG)
		printf("prime_field_size\n");
}

action prime_field_size_init {
	if (DEBUG)
		printf("prime_field_size_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_prime_field_size_t)); */
}

prime_field_size_tt = KMIP_HEADER 0 KMIP_TAG_PRIME_FIELD_SIZE KMIP_ITEM_TYPE_BIG_INTEGER ;
prime_field_size = prime_field_size_tt len @prime_field_size_init @prime_field_size_action;

# KMIP_TAG_PRIVATE_EXPONENT
KMIP_TAG_PRIVATE_EXPONENT = 0x0063;

action private_exponent_action {
	if (DEBUG)
		printf("private_exponent\n");
}

action private_exponent_init {
	if (DEBUG)
		printf("private_exponent_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_private_exponent_t)); */
}

private_exponent_tt = KMIP_HEADER 0 KMIP_TAG_PRIVATE_EXPONENT KMIP_ITEM_TYPE_BIG_INTEGER ;
private_exponent = private_exponent_tt len @private_exponent_init @private_exponent_action;

# KMIP_TAG_PRIVATE_KEY
KMIP_TAG_PRIVATE_KEY = 0x0064;

action private_key_action {
	if (DEBUG)
		printf("private_key\n");
}

action private_key_init {
	if (DEBUG)
		printf("private_key_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_private_key_t)); */
}

private_key_tt = KMIP_HEADER 0 KMIP_TAG_PRIVATE_KEY KMIP_ITEM_TYPE_STRUCTURE ;
private_key = private_key_tt len @private_key_init key_block @private_key_action;

# KMIP_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER
KMIP_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER = 0x0066;

action private_key_unique_identifier_action {
	if (DEBUG)
		printf("private_key_unique_identifier\n");
}

action private_key_unique_identifier_init {
	if (DEBUG)
		printf("private_key_unique_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_private_key_unique_identifier_t)); */
}

private_key_unique_identifier_tt = KMIP_HEADER 0 KMIP_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
private_key_unique_identifier = private_key_unique_identifier_tt len @private_key_unique_identifier_init uuid @private_key_unique_identifier_action;

# KMIP_TAG_PROCESS_START_DATE
KMIP_TAG_PROCESS_START_DATE = 0x0067;

action process_start_date_action {
	if (DEBUG)
		printf("process_start_date\n");
}

action process_start_date_init {
	if (DEBUG)
		printf("process_start_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_process_start_date_t)); */
}

process_start_date_tt = KMIP_HEADER 0 KMIP_TAG_PROCESS_START_DATE KMIP_ITEM_TYPE_DATE_TIME ;
process_start_date = process_start_date_tt len @process_start_date_init long_data @process_start_date_action;

# KMIP_TAG_PROTECT_STOP_DATE
KMIP_TAG_PROTECT_STOP_DATE = 0x0068;

action protect_stop_date_action {
	if (DEBUG)
		printf("protect_stop_date\n");
}

action protect_stop_date_init {
	if (DEBUG)
		printf("protect_stop_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_protect_stop_date_t)); */
}

protect_stop_date_tt = KMIP_HEADER 0 KMIP_TAG_PROTECT_STOP_DATE KMIP_ITEM_TYPE_DATE_TIME ;
protect_stop_date = protect_stop_date_tt len @protect_stop_date_init long_data @protect_stop_date_action;

# KMIP_TAG_PROTOCOL_VERSION_MAJOR
KMIP_TAG_PROTOCOL_VERSION_MAJOR = 0x006A;

action protocol_version_major_action {
	if (DEBUG)
		printf("protocol_version_major: %d\n", current_int.u32 );
}

action protocol_version_major_init {
	if (DEBUG)
		printf("protocol_version_major_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_protocol_version_major_t)); */
}

protocol_version_major_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION_MAJOR KMIP_ITEM_TYPE_INTEGER ;
protocol_version_major = protocol_version_major_tt len @protocol_version_major_init get_int @protocol_version_major_action;

# KMIP_TAG_PROTOCOL_VERSION_MINOR
KMIP_TAG_PROTOCOL_VERSION_MINOR = 0x006B;

action protocol_version_minor_action {
	if (DEBUG)
		printf("protocol_version_minor: %d\n", current_int.u32 );
}

action protocol_version_minor_init {
	if (DEBUG)
		printf("protocol_version_minor_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_protocol_version_minor_t)); */
}

protocol_version_minor_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION_MINOR KMIP_ITEM_TYPE_INTEGER ;
protocol_version_minor = protocol_version_minor_tt len @protocol_version_minor_init get_int @protocol_version_minor_action;

# KMIP_TAG_PROTOCOL_VERSION
KMIP_TAG_PROTOCOL_VERSION = 0x0069;

action protocol_version_action {
	if (DEBUG)
		printf("protocol_version\n");
}

action protocol_version_init {
	if (DEBUG)
		printf("protocol_version_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_protocol_version_t)); */
}

protocol_version_tt = KMIP_HEADER 0 KMIP_TAG_PROTOCOL_VERSION KMIP_ITEM_TYPE_STRUCTURE ;
protocol_version = protocol_version_tt len @protocol_version_init protocol_version_major protocol_version_minor @protocol_version_action;

# KMIP_TAG_PUBLIC_EXPONENT
KMIP_TAG_PUBLIC_EXPONENT = 0x006C;

action public_exponent_action {
	if (DEBUG)
		printf("public_exponent\n");
}

action public_exponent_init {
	if (DEBUG)
		printf("public_exponent_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_public_exponent_t)); */
}

public_exponent_tt = KMIP_HEADER 0 KMIP_TAG_PUBLIC_EXPONENT KMIP_ITEM_TYPE_BIG_INTEGER ;
public_exponent = public_exponent_tt len @public_exponent_init @public_exponent_action;

# KMIP_TAG_PUBLIC_KEY
KMIP_TAG_PUBLIC_KEY = 0x006D;

action public_key_action {
	if (DEBUG)
		printf("public_key\n");
}

action public_key_init {
	if (DEBUG)
		printf("public_key_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_public_key_t)); */
}

public_key_tt = KMIP_HEADER 0 KMIP_TAG_PUBLIC_KEY KMIP_ITEM_TYPE_STRUCTURE ;
public_key = public_key_tt len @public_key_init key_block @public_key_action;

# KMIP_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER
KMIP_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER = 0x006F;

action public_key_unique_identifier_action {
	if (DEBUG)
		printf("public_key_unique_identifier\n");
}

action public_key_unique_identifier_init {
	if (DEBUG)
		printf("public_key_unique_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_public_key_unique_identifier_t)); */
}

public_key_unique_identifier_tt = KMIP_HEADER 0 KMIP_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
public_key_unique_identifier = public_key_unique_identifier_tt len @public_key_unique_identifier_init uuid @public_key_unique_identifier_action;

# KMIP_TAG_PUT_FUNCTION
KMIP_TAG_PUT_FUNCTION = 0x0070;

action put_function_action {
	if (DEBUG)
		printf("put_function\n");
}

action put_function_init {
	if (DEBUG)
		printf("put_function_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_put_function_t)); */
}

put_function_tt = KMIP_HEADER 0 KMIP_TAG_PUT_FUNCTION KMIP_ITEM_TYPE_ENUMERATION ;
put_function = put_function_tt len @put_function_init get_int @put_function_action;

# KMIP_TAG_Q
KMIP_TAG_Q = 0x0071;

action q_action {
	if (DEBUG)
		printf("q\n");
}

action q_init {
	if (DEBUG)
		printf("q_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_q_t)); */
}

q_tt = KMIP_HEADER 0 KMIP_TAG_Q KMIP_ITEM_TYPE_BIG_INTEGER ;
q = q_tt len @q_init @q_action;

# KMIP_TAG_Q_STRING
KMIP_TAG_Q_STRING = 0x0072;

action q_string_action {
	if (DEBUG)
		printf("q_string\n");
}

action q_string_init {
	if (DEBUG)
		printf("q_string_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_q_string_t)); */
}

q_string_tt = KMIP_HEADER 0 KMIP_TAG_Q_STRING KMIP_ITEM_TYPE_BYTE_STRING ;
q_string = q_string_tt len @q_string_init text_string @q_string_action;

# KMIP_TAG_QLENGTH
KMIP_TAG_QLENGTH = 0x0073;

action qlength_action {
	if (DEBUG)
		printf("qlength\n");
}

action qlength_init {
	if (DEBUG)
		printf("qlength_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_qlength_t)); */
}

qlength_tt = KMIP_HEADER 0 KMIP_TAG_QLENGTH KMIP_ITEM_TYPE_INTEGER ;
qlength = qlength_tt len @qlength_init get_int @qlength_action;

# KMIP_TAG_QUERY_FUNCTION
KMIP_TAG_QUERY_FUNCTION = 0x0074;

action query_function_action {
	if (DEBUG)
		printf("query_function\n");
}

action query_function_init {
	if (DEBUG)
		printf("query_function_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_query_function_t)); */
}

query_function_tt = KMIP_HEADER 0 KMIP_TAG_QUERY_FUNCTION KMIP_ITEM_TYPE_ENUMERATION ;
query_function = query_function_tt len @query_function_init get_int @query_function_action;

# KMIP_TAG_RECOMMENDED_CURVE
KMIP_TAG_RECOMMENDED_CURVE = 0x0075;

action recommended_curve_action {
	if (DEBUG)
		printf("recommended_curve\n");
}

action recommended_curve_init {
	if (DEBUG)
		printf("recommended_curve_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_recommended_curve_t)); */
}

recommended_curve_tt = KMIP_HEADER 0 KMIP_TAG_RECOMMENDED_CURVE KMIP_ITEM_TYPE_ENUMERATION ;
recommended_curve = recommended_curve_tt len @recommended_curve_init get_int @recommended_curve_action;

# KMIP_TAG_REPLACED_UNIQUE_IDENTIFIER
KMIP_TAG_REPLACED_UNIQUE_IDENTIFIER = 0x0076;

action replaced_unique_identifier_action {
	if (DEBUG)
		printf("replaced_unique_identifier\n");
}

action replaced_unique_identifier_init {
	if (DEBUG)
		printf("replaced_unique_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_replaced_unique_identifier_t)); */
}

replaced_unique_identifier_tt = KMIP_HEADER 0 KMIP_TAG_REPLACED_UNIQUE_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
replaced_unique_identifier = replaced_unique_identifier_tt len @replaced_unique_identifier_init uuid @replaced_unique_identifier_action;

# KMIP_TAG_REQUEST_HEADER
KMIP_TAG_REQUEST_HEADER = 0x0077;

action request_header_action {
	if (DEBUG)
		printf("request_header\n");
}

action request_header_init {
	if (DEBUG)
		printf("request_header_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_request_header_t)); */
}

request_header_tt = KMIP_HEADER 0 KMIP_TAG_REQUEST_HEADER KMIP_ITEM_TYPE_STRUCTURE ;
request_header = request_header_tt len @request_header_init protocol_version batch_count @request_header_action;

# KMIP_TAG_REQUEST_MESSAGE
KMIP_TAG_REQUEST_MESSAGE = 0x0078;

action request_message_action {
	if (DEBUG)
		printf("request_message\n");
}

action request_message_init {
	if (DEBUG)
		printf("request_message_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_request_message_t)); */
}

request_message_tt = KMIP_HEADER 0 KMIP_TAG_REQUEST_MESSAGE KMIP_ITEM_TYPE_STRUCTURE ;
#request_message = request_message_tt len @request_message_init @request_message_action;

# KMIP_TAG_REQUEST_PAYLOAD
KMIP_TAG_REQUEST_PAYLOAD = 0x0079;

action request_payload_action {
	if (DEBUG)
		printf("request_payload\n");
}

action request_payload_init {
	if (DEBUG)
		printf("request_payload_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_request_payload_t)); */
}

request_payload_tt = KMIP_HEADER 0 KMIP_TAG_REQUEST_PAYLOAD KMIP_ITEM_TYPE_STRUCTURE ;
#request_payload = request_payload_tt len @request_payload_init @request_payload_action;

# KMIP_TAG_TIME_STAMP
KMIP_TAG_TIME_STAMP = 0x0092;

action time_stamp_action {
	if (DEBUG) {
       	   if (current_len.u32 == 0) {
	      printf( "timestamp 0x%lx\n", (long unsigned int)current_long.u64);
	   }
	}
}

action time_stamp_init {
	if (DEBUG)
		printf("time_stamp_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_time_stamp_t)); */
}

time_stamp_tt = KMIP_HEADER 0 KMIP_TAG_TIME_STAMP KMIP_ITEM_TYPE_DATE_TIME ;
time_stamp = time_stamp_tt len @time_stamp_init long_data @time_stamp_action;

# KMIP_TAG_RESPONSE_HEADER
KMIP_TAG_RESPONSE_HEADER = 0x007A;

action response_header_action {
	if (DEBUG)
		printf("response_header\n");
}

action response_header_init {
	if (DEBUG)
		printf("response_header_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_response_header_t)); */
}

response_header_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_HEADER KMIP_ITEM_TYPE_STRUCTURE ;
response_header = response_header_tt len @response_header_init protocol_version time_stamp batch_count @response_header_action;

# KMIP_TAG_RESPONSE_MESSAGE
KMIP_TAG_RESPONSE_MESSAGE = 0x007B;

action response_message_action {
	if (DEBUG)
		printf("response_message\n");
}

action response_message_init {
	if (DEBUG)
		printf("response_message_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_response_message_t)); */
}

response_message_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_MESSAGE KMIP_ITEM_TYPE_STRUCTURE ;
#response_message = response_message_tt len @response_message_init @response_message_action;

# KMIP_TAG_RESPONSE_PAYLOAD
KMIP_TAG_RESPONSE_PAYLOAD = 0x007C;

action response_payload_action {
	if (DEBUG)
		printf("response_payload\n");
}

action response_payload_init {
	if (DEBUG)
		printf("response_payload_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_response_payload_t)); */
}

response_payload_tt = KMIP_HEADER 0 KMIP_TAG_RESPONSE_PAYLOAD KMIP_ITEM_TYPE_STRUCTURE ;
#response_payload = response_payload_tt len @response_payload_init ( get_attributes_payload | unique_identifier | create_key_pair_payload | get_payload ) @response_payload_action;

# KMIP_TAG_RESULT_MESSAGE
KMIP_TAG_RESULT_MESSAGE = 0x007D;

action result_message_action {
	if (DEBUG)
		printf("result_message\n");
}

action result_message_init {
	if (DEBUG)
		printf("result_message_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_result_message_t)); */
}

result_message_tt = KMIP_HEADER 0 KMIP_TAG_RESULT_MESSAGE KMIP_ITEM_TYPE_STRUCTURE ;
result_message = result_message_tt len @result_message_init @result_message_action;

# KMIP_TAG_RESULT_REASON
KMIP_TAG_RESULT_REASON = 0x007E;

action result_reason_action {
	if (DEBUG)
		printf("result_reason\n");
}

action result_reason_init {
	if (DEBUG)
		printf("result_reason_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_result_reason_t)); */
}

result_reason_tt = KMIP_HEADER 0 KMIP_TAG_RESULT_REASON KMIP_ITEM_TYPE_ENUMERATION ;
result_reason = result_reason_tt len @result_reason_init get_int @result_reason_action;

# KMIP_TAG_RESULT_STATUS
KMIP_TAG_RESULT_STATUS = 0x007F;

action result_status_action {
	if (DEBUG)
		printf("result_status: %d\n", current_int.u32 );
}

action result_status_init {
	if (DEBUG)
		printf("result_status_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_result_status_t)); */
}

result_status_tt = KMIP_HEADER 0 KMIP_TAG_RESULT_STATUS KMIP_ITEM_TYPE_ENUMERATION ;
result_status = result_status_tt len @result_status_init get_int @result_status_action;

# KMIP_TAG_REVOCATION_MESSAGE
KMIP_TAG_REVOCATION_MESSAGE = 0x0080;

action revocation_message_action {
	if (DEBUG)
		printf("revocation_message\n");
}

action revocation_message_init {
	if (DEBUG)
		printf("revocation_message_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_revocation_message_t)); */
}

revocation_message_tt = KMIP_HEADER 0 KMIP_TAG_REVOCATION_MESSAGE KMIP_ITEM_TYPE_TEXT_STRING ;
revocation_message = revocation_message_tt len @revocation_message_init text_string @revocation_message_action;

# KMIP_TAG_REVOCATION_REASON
KMIP_TAG_REVOCATION_REASON = 0x0081;

action revocation_reason_action {
	if (DEBUG)
		printf("revocation_reason\n");
}

action revocation_reason_init {
	if (DEBUG)
		printf("revocation_reason_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_revocation_reason_t)); */
}

revocation_reason_tt = KMIP_HEADER 0 KMIP_TAG_REVOCATION_REASON KMIP_ITEM_TYPE_STRUCTURE ;
revocation_reason = revocation_reason_tt len @revocation_reason_init @revocation_reason_action;

# KMIP_TAG_REVOCATION_REASON_CODE
KMIP_TAG_REVOCATION_REASON_CODE = 0x0082;

action revocation_reason_code_action {
	if (DEBUG)
		printf("revocation_reason_code\n");
}

action revocation_reason_code_init {
	if (DEBUG)
		printf("revocation_reason_code_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_revocation_reason_code_t)); */
}

revocation_reason_code_tt = KMIP_HEADER 0 KMIP_TAG_REVOCATION_REASON_CODE KMIP_ITEM_TYPE_ENUMERATION ;
revocation_reason_code = revocation_reason_code_tt len @revocation_reason_code_init get_int @revocation_reason_code_action;

# KMIP_TAG_KEY_ROLE_TYPE
KMIP_TAG_KEY_ROLE_TYPE = 0x0083;

action key_role_type_action {
	if (DEBUG)
		printf("key_role_type\n");
}

action key_role_type_init {
	if (DEBUG)
		printf("key_role_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_key_role_type_t)); */
}

#key_role_type_tt = KMIP_HEADER 0 KMIP_TAG_KEY_ROLE_TYPE KMIP_ITEM_TYPE_ ;
#key_role_type = key_role_type_tt len @key_role_type_init @key_role_type_action;

# KMIP_TAG_SALT
KMIP_TAG_SALT = 0x0084;

action salt_action {
	if (DEBUG)
		printf("salt\n");
}

action salt_init {
	if (DEBUG)
		printf("salt_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_salt_t)); */
}

salt_tt = KMIP_HEADER 0 KMIP_TAG_SALT KMIP_ITEM_TYPE_BYTE_STRING ;
salt = salt_tt len @salt_init text_string @salt_action;

# KMIP_TAG_SECRET_DATA
KMIP_TAG_SECRET_DATA = 0x0085;

action secret_data_action {
	if (DEBUG)
		printf("secret_data\n");
}

action secret_data_init {
	if (DEBUG)
		printf("secret_data_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_secret_data_t)); */
}

secret_data_tt = KMIP_HEADER 0 KMIP_TAG_SECRET_DATA KMIP_ITEM_TYPE_STRUCTURE ;
secret_data = secret_data_tt len @secret_data_init @secret_data_action;

# KMIP_TAG_SECRET_DATA_TYPE
KMIP_TAG_SECRET_DATA_TYPE = 0x0086;

action secret_data_type_action {
	if (DEBUG)
		printf("secret_data_type\n");
}

action secret_data_type_init {
	if (DEBUG)
		printf("secret_data_type_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_secret_data_type_t)); */
}

secret_data_type_tt = KMIP_HEADER 0 KMIP_TAG_SECRET_DATA_TYPE KMIP_ITEM_TYPE_ENUMERATION ;
secret_data_type = secret_data_type_tt len @secret_data_type_init get_int @secret_data_type_action;

# KMIP_TAG_SERIAL_NUMBER
KMIP_TAG_SERIAL_NUMBER = 0x0087;

action serial_number_action {
	if (DEBUG)
		printf("serial_number\n");
}

action serial_number_init {
	if (DEBUG)
		printf("serial_number_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_serial_number_t)); */
}

serial_number_tt = KMIP_HEADER 0 KMIP_TAG_SERIAL_NUMBER KMIP_ITEM_TYPE_TEXT_STRING ;
serial_number = serial_number_tt len @serial_number_init text_string @serial_number_action;

# KMIP_TAG_ATTRIBUTE_VALUE
KMIP_TAG_ATTRIBUTE_VALUE = 0x000B;

action attribute_value_struct_action {
	if (DEBUG)
		printf("attribute_value_struct\n");
}

action attribute_value_struct_init {
	if (DEBUG)
		printf("attribute_value_struct_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_value_t)); */
}

attribute_value_struct_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_VALUE KMIP_ITEM_TYPE_STRUCTURE ;
attribute_value_struct = attribute_value_struct_tt len @attribute_value_struct_init ( link_type linked_object_identifier | issuer serial_number | certificate_issuer_distinguished ) @attribute_value_struct_action;

action attribute_value_enum_action {
	if (DEBUG)
		printf("attribute_value_enum: %d\n", current_int.u32);
}

action attribute_value_enum_init {
	if (DEBUG)
		printf("attribute_value_enum_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_value_t)); */
}

attribute_value_enum_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_VALUE KMIP_ITEM_TYPE_ENUMERATION ;
attribute_value_enum = attribute_value_enum_tt len @attribute_value_enum_init get_int @attribute_value_enum_action;

action attribute_value_integer_action {
	if (DEBUG)
		printf("attribute_value_integer: %d\n", current_int.u32);
}

action attribute_value_integer_init {
	if (DEBUG)
		printf("attribute_value_integer_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_value_t)); */
}

attribute_value_integer_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE_VALUE KMIP_ITEM_TYPE_INTEGER ;
attribute_value_integer = attribute_value_integer_tt len @attribute_value_integer_init get_int @attribute_value_integer_action;

# KMIP_TAG_ATTRIBUTE
KMIP_TAG_ATTRIBUTE = 0x0008;

action attribute_action {
	if (DEBUG)
		printf("attribute\n");
}

action attribute_init {
	if (DEBUG)
		printf("attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_attribute_t)); */
}

attribute_tt = KMIP_HEADER 0 KMIP_TAG_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE ;
attribute = attribute_tt len @attribute_init attribute_name attribute_index? ( attribute_value_struct | attribute_value_enum | attribute_value_integer ) @attribute_action;

# KMIP_TAG_COMMON_TEMPLATE_ATTRIBUTE
KMIP_TAG_COMMON_TEMPLATE_ATTRIBUTE = 0x001F;

action common_template_attribute_action {
	if (DEBUG)
		printf("common_template_attribute\n");
}

action common_template_attribute_init {
	if (DEBUG)
		printf("common_template_attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_common_template_attribute_t)); */
}

common_template_attribute_tt = KMIP_HEADER 0 KMIP_TAG_COMMON_TEMPLATE_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE;
common_template_attribute = common_template_attribute_tt len @common_template_attribute_init attribute* @common_template_attribute_action;

# KMIP_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE
KMIP_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE = 0x0065;

action private_key_template_attribute_action {
	if (DEBUG)
		printf("private_key_template_attribute\n");
}

action private_key_template_attribute_init {
	if (DEBUG)
		printf("private_key_template_attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_private_key_template_attribute_t)); */
}

private_key_template_attribute_tt = KMIP_HEADER 0 KMIP_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE ;
private_key_template_attribute = private_key_template_attribute_tt len @private_key_template_attribute_init attribute* @private_key_template_attribute_action;

# KMIP_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE
KMIP_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE = 0x006E;

action public_key_template_attribute_action {
	if (DEBUG)
		printf("public_key_template_attribute\n");
}

action public_key_template_attribute_init {
	if (DEBUG)
		printf("public_key_template_attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_public_key_template_attribute_t)); */
}

public_key_template_attribute_tt = KMIP_HEADER 0 KMIP_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE ;
public_key_template_attribute = public_key_template_attribute_tt len @public_key_template_attribute_init attribute* @public_key_template_attribute_action;

# KMIP_TAG_SERVER_INFORMATION
KMIP_TAG_SERVER_INFORMATION = 0x0088;

action server_information_action {
	if (DEBUG)
		printf("server_information\n");
}

action server_information_init {
	if (DEBUG)
		printf("server_information_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_server_information_t)); */
}

server_information_tt = KMIP_HEADER 0 KMIP_TAG_SERVER_INFORMATION KMIP_ITEM_TYPE_STRUCTURE ;
server_information = server_information_tt len @server_information_init @server_information_action;

# KMIP_TAG_SPLIT_KEY
KMIP_TAG_SPLIT_KEY = 0x0089;

action split_key_action {
	if (DEBUG)
		printf("split_key\n");
}

action split_key_init {
	if (DEBUG)
		printf("split_key_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_split_key_t)); */
}

split_key_tt = KMIP_HEADER 0 KMIP_TAG_SPLIT_KEY KMIP_ITEM_TYPE_STRUCTURE ;
split_key = split_key_tt len @split_key_init @split_key_action;

# KMIP_TAG_SPLIT_KEY_METHOD
KMIP_TAG_SPLIT_KEY_METHOD = 0x008A;

action split_key_method_action {
	if (DEBUG)
		printf("split_key_method\n");
}

action split_key_method_init {
	if (DEBUG)
		printf("split_key_method_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_split_key_method_t)); */
}

split_key_method_tt = KMIP_HEADER 0 KMIP_TAG_SPLIT_KEY_METHOD KMIP_ITEM_TYPE_ENUMERATION ;
split_key_method = split_key_method_tt len @split_key_method_init get_int @split_key_method_action;

# KMIP_TAG_SPLIT_KEY_PARTS
KMIP_TAG_SPLIT_KEY_PARTS = 0x008B;

action split_key_parts_action {
	if (DEBUG)
		printf("split_key_parts\n");
}

action split_key_parts_init {
	if (DEBUG)
		printf("split_key_parts_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_split_key_parts_t)); */
}

split_key_parts_tt = KMIP_HEADER 0 KMIP_TAG_SPLIT_KEY_PARTS KMIP_ITEM_TYPE_INTEGER ;
split_key_parts = split_key_parts_tt len @split_key_parts_init get_int @split_key_parts_action;

# KMIP_TAG_SPLIT_KEY_THRESHOLD
KMIP_TAG_SPLIT_KEY_THRESHOLD = 0x008C;

action split_key_threshold_action {
	if (DEBUG)
		printf("split_key_threshold\n");
}

action split_key_threshold_init {
	if (DEBUG)
		printf("split_key_threshold_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_split_key_threshold_t)); */
}

split_key_threshold_tt = KMIP_HEADER 0 KMIP_TAG_SPLIT_KEY_THRESHOLD KMIP_ITEM_TYPE_INTEGER ;
split_key_threshold = split_key_threshold_tt len @split_key_threshold_init get_int @split_key_threshold_action;

# KMIP_TAG_STATE
KMIP_TAG_STATE = 0x008D;

action state_action {
	if (DEBUG)
		printf("state\n");
}

action state_init {
	if (DEBUG)
		printf("state_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_state_t)); */
}

state_tt = KMIP_HEADER 0 KMIP_TAG_STATE KMIP_ITEM_TYPE_ENUMERATION ;
state = state_tt len @state_init get_int @state_action;

# KMIP_TAG_STORAGE_STATUS_MASK
KMIP_TAG_STORAGE_STATUS_MASK = 0x008E;

action storage_status_mask_action {
	if (DEBUG)
		printf("storage_status_mask\n");
}

action storage_status_mask_init {
	if (DEBUG)
		printf("storage_status_mask_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_storage_status_mask_t)); */
}

storage_status_mask_tt = KMIP_HEADER 0 KMIP_TAG_STORAGE_STATUS_MASK KMIP_ITEM_TYPE_INTEGER ;
storage_status_mask = storage_status_mask_tt len @storage_status_mask_init get_int @storage_status_mask_action;

# KMIP_TAG_SYMMETRIC_KEY
KMIP_TAG_SYMMETRIC_KEY = 0x008F;

action symmetric_key_action {
	if (DEBUG)
		printf("symmetric_key\n");
}

action symmetric_key_init {
	if (DEBUG)
		printf("symmetric_key_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_symmetric_key_t)); */
}

symmetric_key_tt = KMIP_HEADER 0 KMIP_TAG_SYMMETRIC_KEY KMIP_ITEM_TYPE_STRUCTURE ;
symmetric_key = symmetric_key_tt len @symmetric_key_init @symmetric_key_action;

# KMIP_TAG_TEMPLATE
KMIP_TAG_TEMPLATE = 0x0090;

action template_action {
	if (DEBUG)
		printf("template\n");
}

action template_init {
	if (DEBUG)
		printf("template_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_template_t)); */
}

template_tt = KMIP_HEADER 0 KMIP_TAG_TEMPLATE KMIP_ITEM_TYPE_STRUCTURE ;
template = template_tt len @template_init @template_action;

# KMIP_TAG_TEMPLATE_ATTRIBUTE
KMIP_TAG_TEMPLATE_ATTRIBUTE = 0x0091;

action template_attribute_action {
	if (DEBUG)
		printf("template_attribute\n");
}

action template_attribute_init {
	if (DEBUG)
		printf("template_attribute_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_template_attribute_t)); */
}

template_attribute_tt = KMIP_HEADER 0 KMIP_TAG_TEMPLATE_ATTRIBUTE KMIP_ITEM_TYPE_STRUCTURE ;
template_attribute = template_attribute_tt len @template_attribute_init attribute* @template_attribute_action;

# KMIP_TAG_UNIQUE_BATCH_ITEM_ID
KMIP_TAG_UNIQUE_BATCH_ITEM_ID = 0x0093;

action unique_batch_item_id_action {
	if (DEBUG)
		printf("unique_batch_item_id\n");
}

action unique_batch_item_id_init {
	if (DEBUG)
		printf("unique_batch_item_id_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_unique_batch_item_id_t)); */
}

unique_batch_item_id_tt = KMIP_HEADER 0 KMIP_TAG_UNIQUE_BATCH_ITEM_ID KMIP_ITEM_TYPE_BYTE_STRING ;
unique_batch_item_id = unique_batch_item_id_tt len @unique_batch_item_id_init uuid @unique_batch_item_id_action;

# KMIP_TAG_UNIQUE_IDENTIFIER
KMIP_TAG_UNIQUE_IDENTIFIER = 0x0094;

action unique_identifier_action {
	if (DEBUG)
		printf("unique_identifier\n");
}

action unique_identifier_init {
	if (DEBUG)
		printf("unique_identifier_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_unique_identifier_t)); */
}

unique_identifier_tt = KMIP_HEADER 0 KMIP_TAG_UNIQUE_IDENTIFIER KMIP_ITEM_TYPE_TEXT_STRING ;
unique_identifier = unique_identifier_tt len @unique_identifier_init uuid @unique_identifier_action;

# KMIP_TAG_USAGE_LIMITS
KMIP_TAG_USAGE_LIMITS = 0x0095;

action usage_limits_action {
	if (DEBUG)
		printf("usage_limits\n");
}

action usage_limits_init {
	if (DEBUG)
		printf("usage_limits_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_usage_limits_t)); */
}

usage_limits_tt = KMIP_HEADER 0 KMIP_TAG_USAGE_LIMITS KMIP_ITEM_TYPE_STRUCTURE ;
usage_limits = usage_limits_tt len @usage_limits_init @usage_limits_action;

# KMIP_TAG_USAGE_LIMITS_COUNT
KMIP_TAG_USAGE_LIMITS_COUNT = 0x0096;

action usage_limits_count_action {
	if (DEBUG)
		printf("usage_limits_count\n");
}

action usage_limits_count_init {
	if (DEBUG)
		printf("usage_limits_count_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_usage_limits_count_t)); */
}

usage_limits_count_tt = KMIP_HEADER 0 KMIP_TAG_USAGE_LIMITS_COUNT KMIP_ITEM_TYPE_LONG_INTEGER ;
usage_limits_count = usage_limits_count_tt len @usage_limits_count_init long_data @usage_limits_count_action;

# KMIP_TAG_USAGE_LIMITS_TOTAL
KMIP_TAG_USAGE_LIMITS_TOTAL = 0x0097;

action usage_limits_total_action {
	if (DEBUG)
		printf("usage_limits_total\n");
}

action usage_limits_total_init {
	if (DEBUG)
		printf("usage_limits_total_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_usage_limits_total_t)); */
}

usage_limits_total_tt = KMIP_HEADER 0 KMIP_TAG_USAGE_LIMITS_TOTAL KMIP_ITEM_TYPE_LONG_INTEGER ;
usage_limits_total = usage_limits_total_tt len @usage_limits_total_init long_data @usage_limits_total_action;

# KMIP_TAG_USAGE_LIMITS_UNIT
KMIP_TAG_USAGE_LIMITS_UNIT = 0x0098;

action usage_limits_unit_action {
	if (DEBUG)
		printf("usage_limits_unit\n");
}

action usage_limits_unit_init {
	if (DEBUG)
		printf("usage_limits_unit_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_usage_limits_unit_t)); */
}

usage_limits_unit_tt = KMIP_HEADER 0 KMIP_TAG_USAGE_LIMITS_UNIT KMIP_ITEM_TYPE_ENUMERATION ;
usage_limits_unit = usage_limits_unit_tt len @usage_limits_unit_init get_int @usage_limits_unit_action;

# KMIP_TAG_USERNAME
KMIP_TAG_USERNAME = 0x0099;

action username_action {
	if (DEBUG)
		printf("username\n");
}

action username_init {
	if (DEBUG)
		printf("username_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_username_t)); */
}

username_tt = KMIP_HEADER 0 KMIP_TAG_USERNAME KMIP_ITEM_TYPE_TEXT_STRING ;
username = username_tt len @username_init text_string @username_action;

# KMIP_TAG_VALIDITY_DATE
KMIP_TAG_VALIDITY_DATE = 0x009A;

action validity_date_action {
	if (DEBUG)
		printf("validity_date\n");
}

action validity_date_init {
	if (DEBUG)
		printf("validity_date_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_validity_date_t)); */
}

validity_date_tt = KMIP_HEADER 0 KMIP_TAG_VALIDITY_DATE KMIP_ITEM_TYPE_DATE_TIME ;
validity_date = validity_date_tt len @validity_date_init long_data @validity_date_action;

# KMIP_TAG_VALIDITY_INDICATOR
KMIP_TAG_VALIDITY_INDICATOR = 0x009B;

action validity_indicator_action {
	if (DEBUG)
		printf("validity_indicator\n");
}

action validity_indicator_init {
	if (DEBUG)
		printf("validity_indicator_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_validity_indicator_t)); */
}

validity_indicator_tt = KMIP_HEADER 0 KMIP_TAG_VALIDITY_INDICATOR KMIP_ITEM_TYPE_ENUMERATION ;
validity_indicator = validity_indicator_tt len @validity_indicator_init get_int @validity_indicator_action;

# KMIP_TAG_VENDOR_EXTENSION
KMIP_TAG_VENDOR_EXTENSION = 0x009C;

action vendor_extension_action {
	if (DEBUG)
		printf("vendor_extension\n");
}

action vendor_extension_init {
	if (DEBUG)
		printf("vendor_extension_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_vendor_extension_t)); */
}

vendor_extension_tt = KMIP_HEADER 0 KMIP_TAG_VENDOR_EXTENSION KMIP_ITEM_TYPE_STRUCTURE ;
vendor_extension = vendor_extension_tt len @vendor_extension_init @vendor_extension_action;

# KMIP_TAG_VENDOR_IDENTIFICATION
KMIP_TAG_VENDOR_IDENTIFICATION = 0x009D;

action vendor_identification_action {
	if (DEBUG)
		printf("vendor_identification\n");
}

action vendor_identification_init {
	if (DEBUG)
		printf("vendor_identification_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_vendor_identification_t)); */
}

vendor_identification_tt = KMIP_HEADER 0 KMIP_TAG_VENDOR_IDENTIFICATION KMIP_ITEM_TYPE_TEXT_STRING ;
vendor_identification = vendor_identification_tt len @vendor_identification_init text_string @vendor_identification_action;

# KMIP_TAG_WRAPPING_METHOD
KMIP_TAG_WRAPPING_METHOD = 0x009E;

action wrapping_method_action {
	if (DEBUG)
		printf("wrapping_method\n");
}

action wrapping_method_init {
	if (DEBUG)
		printf("wrapping_method_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_wrapping_method_t)); */
}

wrapping_method_tt = KMIP_HEADER 0 KMIP_TAG_WRAPPING_METHOD KMIP_ITEM_TYPE_ENUMERATION ;
wrapping_method = wrapping_method_tt len @wrapping_method_init get_int @wrapping_method_action;

# KMIP_TAG_X
KMIP_TAG_X = 0x009F;

action x_action {
	if (DEBUG)
		printf("x\n");
}

action x_init {
	if (DEBUG)
		printf("x_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_x_t)); */
}

x_tt = KMIP_HEADER 0 KMIP_TAG_X KMIP_ITEM_TYPE_BIG_INTEGER ;
x = x_tt len @x_init @x_action;

# KMIP_TAG_Y
KMIP_TAG_Y = 0x00A0;

action y_action {
	if (DEBUG)
		printf("y\n");
}

action y_init {
	if (DEBUG)
		printf("y_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_y_t)); */
}

y_tt = KMIP_HEADER 0 KMIP_TAG_Y KMIP_ITEM_TYPE_BIG_INTEGER ;
y = y_tt len @y_init @y_action;

# KMIP_TAG_PASSWORD
KMIP_TAG_PASSWORD = 0x00A1;

action password_action {
	if (DEBUG)
		printf("password\n");
}

action password_init {
	if (DEBUG)
		printf("password_init\n");
	/* current_object = (void *)malloc(sizeof(kmip_password_t)); */
}

#password_tt = KMIP_HEADER 0 KMIP_TAG_PASSWORD KMIP_ITEM_TYPE_ ;
#password = password_tt len @password_init @password_action;

}%%