#ifndef _KMIP_H
#define _KMIP_H

#include <openssl/rand.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

#ifdef __cplusplus
extern "C" {
#endif

#define hton64(x) ((uint64_t)((htonl(((uint32_t)((x)>>32)&0xFFFFFFFF))))|((uint64_t)(htonl((uint32_t)((x)&0xFFFFFFFF)))<<32))
#define ntoh64(x) ((uint64_t)((ntohl(((uint32_t)((x)>>32)&0xFFFFFFFF))))|((uint64_t)(ntohl((uint32_t)((x)&0xFFFFFFFF)))<<32))

#define KMIP_TAG_ACTIVATION_DATE 0x0001
#define KMIP_TAG_APPLICATION_DATA 0x0002
#define KMIP_TAG_APPLICATION_NAMESPACE 0x0003
#define KMIP_TAG_APPLICATION_SPECIFIC_INFORMATION 0x0004
#define KMIP_TAG_ARCHIVE_DATE 0x0005
#define KMIP_TAG_ASYNCHRONOUS_CORRELATION_VALUE 0x0006
#define KMIP_TAG_ASYNCHRONOUS_INDICATOR 0x0007
#define KMIP_TAG_ATTRIBUTE 0x0008
#define KMIP_TAG_ATTRIBUTE_INDEX 0x0009
#define KMIP_TAG_ATTRIBUTE_NAME 0x000A
#define KMIP_TAG_ATTRIBUTE_VALUE 0x000B
#define KMIP_TAG_AUTHENTICATION 0x000C
#define KMIP_TAG_BATCH_COUNT 0x000D
#define KMIP_TAG_BATCH_ERROR_CONTINUATION_OPTION 0x000E
#define KMIP_TAG_BATCH_ITEM 0x000F
#define KMIP_TAG_BATCH_ORDER_OPTION 0x0010
#define KMIP_TAG_BLOCK_CIPHER_MODE 0x0011
#define KMIP_TAG_CANCELLATION_RESULT 0x0012
#define KMIP_TAG_CERTIFICATE 0x0013
#define KMIP_TAG_CERTIFICATE_IDENTIFIER 0x0014
#define KMIP_TAG_CERTIFICATE_ISSUER 0x0015
#define KMIP_TAG_CERTIFICATE_ISSUER_ALTERNATIVE 0x0016
#define KMIP_TAG_CERTIFICATE_ISSUER_DISTINGUISHED 0x0017
#define KMIP_TAG_CERTIFICATE_REQUEST 0x0018
#define KMIP_TAG_CERTIFICATE_REQUEST_TYPE 0x0019
#define KMIP_TAG_CERTIFICATE_SUBJECT 0x001A
#define KMIP_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME 0x001B
#define KMIP_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME 0x001C
#define KMIP_TAG_CERTIFICATE_TYPE 0x001D
#define KMIP_TAG_CERTIFICATE_VALUE 0x001E
#define KMIP_TAG_COMMON_TEMPLATE_ATTRIBUTE 0x001F
#define KMIP_TAG_COMPROMISE_DATE 0x0020
#define KMIP_TAG_COMPROMISE_OCCURRENCE_DATE 0x0021
#define KMIP_TAG_CONTACT_INFORMATION 0x0022
#define KMIP_TAG_CREDENTIAL 0x0023
#define KMIP_TAG_CREDENTIAL_TYPE 0x0024
#define KMIP_TAG_CREDENTIAL_VALUE 0x0025
#define KMIP_TAG_CRITICALITY_INDICATOR 0x0026
#define KMIP_TAG_CRT_COEFFICIENT 0x0027
#define KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM 0x0028
#define KMIP_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS 0x0029
#define KMIP_TAG_CRYPTOGRAPHIC_LENGTH 0x002A
#define KMIP_TAG_CRYPTOGRAPHIC_PARAMETERS 0x002B
#define KMIP_TAG_CRYPTOGRAPHIC_USAGE_MASK 0x002C
#define KMIP_TAG_CUSTOM_ATTRIBUTE 0x002D
#define KMIP_TAG_D 0x002E
#define KMIP_TAG_DEACTIVATION_DATE 0x002F
#define KMIP_TAG_DERIVATION_DATA 0x0030
#define KMIP_TAG_DERIVATION_METHOD 0x0031
#define KMIP_TAG_DERIVATION_PARAMETERS 0x0032
#define KMIP_TAG_DESTROY_DATE 0x0033
#define KMIP_TAG_DIGEST 0x0034
#define KMIP_TAG_DIGEST_VALUE 0x0035
#define KMIP_TAG_ENCRYPTION_KEY_INFORMATION 0x0036
#define KMIP_TAG_G 0x0037
#define KMIP_TAG_HASHING_ALGORITHM 0x0038
#define KMIP_TAG_INITIAL_DATE 0x0039
#define KMIP_TAG_INITIALIZATION_VECTOR 0x003A
#define KMIP_TAG_ISSUER 0x003B
#define KMIP_TAG_ITERATION_COUNT 0x003C
#define KMIP_TAG_IV_COUNTER_NONCE 0x003D
#define KMIP_TAG_J 0x003E
#define KMIP_TAG_KEY 0x003F
#define KMIP_TAG_KEY_BLOCK 0x0040
#define KMIP_TAG_KEY_COMPRESSION_TYPE 0x0041
#define KMIP_TAG_KEY_FORMAT_TYPE 0x0042
#define KMIP_TAG_KEY_MATERIAL 0x0043
#define KMIP_TAG_KEY_PART_IDENTIFIER 0x0044
#define KMIP_TAG_KEY_VALUE 0x0045
#define KMIP_TAG_KEY_WRAPPING_DATA 0x0046
#define KMIP_TAG_KEY_WRAPPING_SPECIFICATION 0x0047
#define KMIP_TAG_LAST_CHANGE_DATE 0x0048
#define KMIP_TAG_LEASE_TIME 0x0049
#define KMIP_TAG_LINK 0x004A
#define KMIP_TAG_LINK_TYPE 0x004B
#define KMIP_TAG_LINKED_OBJECT_IDENTIFIER 0x004C
#define KMIP_TAG_MAC_SIGNATURE 0x004D
#define KMIP_TAG_MAC_SIGNATURE_KEY_INFORMATION 0x004E
#define KMIP_TAG_MAXIMUM_ITEMS 0x004F
#define KMIP_TAG_MAXIMUM_RESPONSE_SIZE 0x0050
#define KMIP_TAG_MESSAGE_EXTENSION 0x0051
#define KMIP_TAG_MODULUS 0x0052
#define KMIP_TAG_NAME 0x0053
#define KMIP_TAG_NAME_TYPE 0x0054
#define KMIP_TAG_NAME_VALUE 0x0055
#define KMIP_TAG_OBJECT_GROUP 0x0056
#define KMIP_TAG_OBJECT_TYPE 0x0057
#define KMIP_TAG_OFFSET 0x0058
#define KMIP_TAG_OPAQUE_DATA_TYPE 0x0059
#define KMIP_TAG_OPAQUE_DATA_VALUE 0x005A
#define KMIP_TAG_OPAQUE_OBJECT 0x005B
#define KMIP_TAG_OPERATION 0x005C
#define KMIP_TAG_OPERATION_POLICY_NAME 0x005D
#define KMIP_TAG_P 0x005E
#define KMIP_TAG_PADDING_METHOD 0x005F
#define KMIP_TAG_PRIME_EXPONENT_P 0x0060
#define KMIP_TAG_PRIME_EXPONENT_Q 0x0061
#define KMIP_TAG_PRIME_FIELD_SIZE 0x0062
#define KMIP_TAG_PRIVATE_EXPONENT 0x0063
#define KMIP_TAG_PRIVATE_KEY 0x0064
#define KMIP_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE 0x0065
#define KMIP_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER 0x0066
#define KMIP_TAG_PROCESS_START_DATE 0x0067
#define KMIP_TAG_PROTECT_STOP_DATE 0x0068
#define KMIP_TAG_PROTOCOL_VERSION 0x0069
#define KMIP_TAG_PROTOCOL_VERSION_MAJOR 0x006A
#define KMIP_TAG_PROTOCOL_VERSION_MINOR 0x006B
#define KMIP_TAG_PUBLIC_EXPONENT 0x006C
#define KMIP_TAG_PUBLIC_KEY 0x006D
#define KMIP_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE 0x006E
#define KMIP_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER 0x006F
#define KMIP_TAG_PUT_FUNCTION 0x0070
#define KMIP_TAG_Q 0x0071
#define KMIP_TAG_Q_STRING 0x0072
#define KMIP_TAG_QLENGTH 0x0073
#define KMIP_TAG_QUERY_FUNCTION 0x0074
#define KMIP_TAG_RECOMMENDED_CURVE 0x0075
#define KMIP_TAG_REPLACED_UNIQUE_IDENTIFIER 0x0076
#define KMIP_TAG_REQUEST_HEADER 0x0077
#define KMIP_TAG_REQUEST_MESSAGE 0x0078
#define KMIP_TAG_REQUEST_PAYLOAD 0x0079
#define KMIP_TAG_RESPONSE_HEADER 0x007A
#define KMIP_TAG_RESPONSE_MESSAGE 0x007B
#define KMIP_TAG_RESPONSE_PAYLOAD 0x007C
#define KMIP_TAG_RESULT_MESSAGE 0x007D
#define KMIP_TAG_RESULT_REASON 0x007E
#define KMIP_TAG_RESULT_STATUS 0x007F
#define KMIP_TAG_REVOCATION_MESSAGE 0x0080
#define KMIP_TAG_REVOCATION_REASON 0x0081
#define KMIP_TAG_REVOCATION_REASON_CODE 0x0082
#define KMIP_TAG_KEY_ROLE_TYPE 0x0083
#define KMIP_TAG_SALT 0x0084
#define KMIP_TAG_SECRET_DATA 0x0085
#define KMIP_TAG_SECRET_DATA_TYPE 0x0086
#define KMIP_TAG_SERIAL_NUMBER 0x0087
#define KMIP_TAG_SERVER_INFORMATION 0x0088
#define KMIP_TAG_SPLIT_KEY 0x0089
#define KMIP_TAG_SPLIT_KEY_METHOD 0x008A
#define KMIP_TAG_SPLIT_KEY_PARTS 0x008B
#define KMIP_TAG_SPLIT_KEY_THRESHOLD 0x008C
#define KMIP_TAG_STATE 0x008D
#define KMIP_TAG_STORAGE_STATUS_MASK 0x008E
#define KMIP_TAG_SYMMETRIC_KEY 0x008F
#define KMIP_TAG_TEMPLATE 0x0090
#define KMIP_TAG_TEMPLATE_ATTRIBUTE 0x0091
#define KMIP_TAG_TIME_STAMP 0x0092
#define KMIP_TAG_UNIQUE_BATCH_ITEM_ID 0x0093
#define KMIP_TAG_UNIQUE_IDENTIFIER 0x0094
#define KMIP_TAG_USAGE_LIMITS 0x0095
#define KMIP_TAG_USAGE_LIMITS_COUNT 0x0096
#define KMIP_TAG_USAGE_LIMITS_TOTAL 0x0097
#define KMIP_TAG_USAGE_LIMITS_UNIT 0x0098
#define KMIP_TAG_USERNAME 0x0099
#define KMIP_TAG_VALIDITY_DATE 0x009A
#define KMIP_TAG_VALIDITY_INDICATOR 0x009B
#define KMIP_TAG_VENDOR_EXTENSION 0x009C
#define KMIP_TAG_VENDOR_IDENTIFICATION 0x009D
#define KMIP_TAG_WRAPPING_METHOD 0x009E
#define KMIP_TAG_X 0x009F
#define KMIP_TAG_Y 0x00A0
#define KMIP_TAG_PASSWORD 0x00A1

#define KMIP_HEADER 0x42

#define KMIP_HEADER_TAG_ACTIVATION_DATE 0x420001
#define KMIP_HEADER_TAG_APPLICATION_DATA 0x420002
#define KMIP_HEADER_TAG_APPLICATION_NAMESPACE 0x420003
#define KMIP_HEADER_TAG_APPLICATION_SPECIFIC_INFORMATION 0x420004
#define KMIP_HEADER_TAG_ARCHIVE_DATE 0x420005
#define KMIP_HEADER_TAG_ASYNCHRONOUS_CORRELATION_VALUE 0x420006
#define KMIP_HEADER_TAG_ASYNCHRONOUS_INDICATOR 0x420007
#define KMIP_HEADER_TAG_ATTRIBUTE 0x420008
#define KMIP_HEADER_TAG_ATTRIBUTE_INDEX 0x420009
#define KMIP_HEADER_TAG_ATTRIBUTE_NAME 0x42000A
#define KMIP_HEADER_TAG_ATTRIBUTE_VALUE 0x42000B
#define KMIP_HEADER_TAG_AUTHENTICATION 0x42000C
#define KMIP_HEADER_TAG_BATCH_COUNT 0x42000D
#define KMIP_HEADER_TAG_BATCH_ERROR_CONTINUATION_OPTION 0x42000E
#define KMIP_HEADER_TAG_BATCH_ITEM 0x42000F
#define KMIP_HEADER_TAG_BATCH_ORDER_OPTION 0x420010
#define KMIP_HEADER_TAG_BLOCK_CIPHER_MODE 0x420011
#define KMIP_HEADER_TAG_CANCELLATION_RESULT 0x420012
#define KMIP_HEADER_TAG_CERTIFICATE 0x420013
#define KMIP_HEADER_TAG_CERTIFICATE_IDENTIFIER 0x420014
#define KMIP_HEADER_TAG_CERTIFICATE_ISSUER 0x420015
#define KMIP_HEADER_TAG_CERTIFICATE_ISSUER_ALTERNATIVE 0x420016
#define KMIP_HEADER_TAG_CERTIFICATE_ISSUER_DISTINGUISHED 0x420017
#define KMIP_HEADER_TAG_CERTIFICATE_REQUEST 0x420018
#define KMIP_HEADER_TAG_CERTIFICATE_REQUEST_TYPE 0x420019
#define KMIP_HEADER_TAG_CERTIFICATE_SUBJECT 0x42001A
#define KMIP_HEADER_TAG_CERTIFICATE_SUBJECT_ALTERNATIVE_NAME 0x42001B
#define KMIP_HEADER_TAG_CERTIFICATE_SUBJECT_DISTINGUISHED_NAME 0x42001C
#define KMIP_HEADER_TAG_CERTIFICATE_TYPE 0x42001D
#define KMIP_HEADER_TAG_CERTIFICATE_VALUE 0x42001E
#define KMIP_HEADER_TAG_COMMON_TEMPLATE_ATTRIBUTE 0x42001F
#define KMIP_HEADER_TAG_COMPROMISE_DATE 0x420020
#define KMIP_HEADER_TAG_COMPROMISE_OCCURRENCE_DATE 0x420021
#define KMIP_HEADER_TAG_CONTACT_INFORMATION 0x420022
#define KMIP_HEADER_TAG_CREDENTIAL 0x420023
#define KMIP_HEADER_TAG_CREDENTIAL_TYPE 0x420024
#define KMIP_HEADER_TAG_CREDENTIAL_VALUE 0x420025
#define KMIP_HEADER_TAG_CRITICALITY_INDICATOR 0x420026
#define KMIP_HEADER_TAG_CRT_COEFFICIENT 0x420027
#define KMIP_HEADER_TAG_CRYPTOGRAPHIC_ALGORITHM 0x420028
#define KMIP_HEADER_TAG_CRYPTOGRAPHIC_DOMAIN_PARAMETERS 0x420029
#define KMIP_HEADER_TAG_CRYPTOGRAPHIC_LENGTH 0x42002A
#define KMIP_HEADER_TAG_CRYPTOGRAPHIC_PARAMETERS 0x42002B
#define KMIP_HEADER_TAG_CRYPTOGRAPHIC_USAGE_MASK 0x42002C
#define KMIP_HEADER_TAG_CUSTOM_ATTRIBUTE 0x42002D
#define KMIP_HEADER_TAG_D 0x42002E
#define KMIP_HEADER_TAG_DEACTIVATION_DATE 0x42002F
#define KMIP_HEADER_TAG_DERIVATION_DATA 0x420030
#define KMIP_HEADER_TAG_DERIVATION_METHOD 0x420031
#define KMIP_HEADER_TAG_DERIVATION_PARAMETERS 0x420032
#define KMIP_HEADER_TAG_DESTROY_DATE 0x420033
#define KMIP_HEADER_TAG_DIGEST 0x420034
#define KMIP_HEADER_TAG_DIGEST_VALUE 0x420035
#define KMIP_HEADER_TAG_ENCRYPTION_KEY_INFORMATION 0x420036
#define KMIP_HEADER_TAG_G 0x420037
#define KMIP_HEADER_TAG_HASHING_ALGORITHM 0x420038
#define KMIP_HEADER_TAG_INITIAL_DATE 0x420039
#define KMIP_HEADER_TAG_INITIALIZATION_VECTOR 0x42003A
#define KMIP_HEADER_TAG_ISSUER 0x42003B
#define KMIP_HEADER_TAG_ITERATION_COUNT 0x42003C
#define KMIP_HEADER_TAG_IV_COUNTER_NONCE 0x42003D
#define KMIP_HEADER_TAG_J 0x42003E
#define KMIP_HEADER_TAG_KEY 0x42003F
#define KMIP_HEADER_TAG_KEY_BLOCK 0x420040
#define KMIP_HEADER_TAG_KEY_COMPRESSION_TYPE 0x420041
#define KMIP_HEADER_TAG_KEY_FORMAT_TYPE 0x420042
#define KMIP_HEADER_TAG_KEY_MATERIAL 0x420043
#define KMIP_HEADER_TAG_KEY_PART_IDENTIFIER 0x420044
#define KMIP_HEADER_TAG_KEY_VALUE 0x420045
#define KMIP_HEADER_TAG_KEY_WRAPPING_DATA 0x420046
#define KMIP_HEADER_TAG_KEY_WRAPPING_SPECIFICATION 0x420047
#define KMIP_HEADER_TAG_LAST_CHANGE_DATE 0x420048
#define KMIP_HEADER_TAG_LEASE_TIME 0x420049
#define KMIP_HEADER_TAG_LINK 0x42004A
#define KMIP_HEADER_TAG_LINK_TYPE 0x42004B
#define KMIP_HEADER_TAG_LINKED_OBJECT_IDENTIFIER 0x42004C
#define KMIP_HEADER_TAG_MAC_SIGNATURE 0x42004D
#define KMIP_HEADER_TAG_MAC_SIGNATURE_KEY_INFORMATION 0x42004E
#define KMIP_HEADER_TAG_MAXIMUM_ITEMS 0x42004F
#define KMIP_HEADER_TAG_MAXIMUM_RESPONSE_SIZE 0x420050
#define KMIP_HEADER_TAG_MESSAGE_EXTENSION 0x420051
#define KMIP_HEADER_TAG_MODULUS 0x420052
#define KMIP_HEADER_TAG_NAME 0x420053
#define KMIP_HEADER_TAG_NAME_TYPE 0x420054
#define KMIP_HEADER_TAG_NAME_VALUE 0x420055
#define KMIP_HEADER_TAG_OBJECT_GROUP 0x420056
#define KMIP_HEADER_TAG_OBJECT_TYPE 0x420057
#define KMIP_HEADER_TAG_OFFSET 0x420058
#define KMIP_HEADER_TAG_OPAQUE_DATA_TYPE 0x420059
#define KMIP_HEADER_TAG_OPAQUE_DATA_VALUE 0x42005A
#define KMIP_HEADER_TAG_OPAQUE_OBJECT 0x42005B
#define KMIP_HEADER_TAG_OPERATION 0x42005C
#define KMIP_HEADER_TAG_OPERATION_POLICY_NAME 0x42005D
#define KMIP_HEADER_TAG_P 0x42005E
#define KMIP_HEADER_TAG_PADDING_METHOD 0x42005F
#define KMIP_HEADER_TAG_PRIME_EXPONENT_P 0x420060
#define KMIP_HEADER_TAG_PRIME_EXPONENT_Q 0x420061
#define KMIP_HEADER_TAG_PRIME_FIELD_SIZE 0x420062
#define KMIP_HEADER_TAG_PRIVATE_EXPONENT 0x420063
#define KMIP_HEADER_TAG_PRIVATE_KEY 0x420064
#define KMIP_HEADER_TAG_PRIVATE_KEY_TEMPLATE_ATTRIBUTE 0x420065
#define KMIP_HEADER_TAG_PRIVATE_KEY_UNIQUE_IDENTIFIER 0x420066
#define KMIP_HEADER_TAG_PROCESS_START_DATE 0x420067
#define KMIP_HEADER_TAG_PROTECT_STOP_DATE 0x420068
#define KMIP_HEADER_TAG_PROTOCOL_VERSION 0x420069
#define KMIP_HEADER_TAG_PROTOCOL_VERSION_MAJOR 0x42006A
#define KMIP_HEADER_TAG_PROTOCOL_VERSION_MINOR 0x42006B
#define KMIP_HEADER_TAG_PUBLIC_EXPONENT 0x42006C
#define KMIP_HEADER_TAG_PUBLIC_KEY 0x42006D
#define KMIP_HEADER_TAG_PUBLIC_KEY_TEMPLATE_ATTRIBUTE 0x42006E
#define KMIP_HEADER_TAG_PUBLIC_KEY_UNIQUE_IDENTIFIER 0x42006F
#define KMIP_HEADER_TAG_PUT_FUNCTION 0x420070
#define KMIP_HEADER_TAG_Q 0x420071
#define KMIP_HEADER_TAG_Q_STRING 0x420072
#define KMIP_HEADER_TAG_QLENGTH 0x420073
#define KMIP_HEADER_TAG_QUERY_FUNCTION 0x420074
#define KMIP_HEADER_TAG_RECOMMENDED_CURVE 0x420075
#define KMIP_HEADER_TAG_REPLACED_UNIQUE_IDENTIFIER 0x420076
#define KMIP_HEADER_TAG_REQUEST_HEADER 0x420077
#define KMIP_HEADER_TAG_REQUEST_MESSAGE 0x420078
#define KMIP_HEADER_TAG_REQUEST_PAYLOAD 0x420079
#define KMIP_HEADER_TAG_RESPONSE_HEADER 0x42007A
#define KMIP_HEADER_TAG_RESPONSE_MESSAGE 0x42007B
#define KMIP_HEADER_TAG_RESPONSE_PAYLOAD 0x42007C
#define KMIP_HEADER_TAG_RESULT_MESSAGE 0x42007D
#define KMIP_HEADER_TAG_RESULT_REASON 0x42007E
#define KMIP_HEADER_TAG_RESULT_STATUS 0x42007F
#define KMIP_HEADER_TAG_REVOCATION_MESSAGE 0x420080
#define KMIP_HEADER_TAG_REVOCATION_REASON 0x420081
#define KMIP_HEADER_TAG_REVOCATION_REASON_CODE 0x420082
#define KMIP_HEADER_TAG_KEY_ROLE_TYPE 0x420083
#define KMIP_HEADER_TAG_SALT 0x420084
#define KMIP_HEADER_TAG_SECRET_DATA 0x420085
#define KMIP_HEADER_TAG_SECRET_DATA_TYPE 0x420086
#define KMIP_HEADER_TAG_SERIAL_NUMBER 0x420087
#define KMIP_HEADER_TAG_SERVER_INFORMATION 0x420088
#define KMIP_HEADER_TAG_SPLIT_KEY 0x420089
#define KMIP_HEADER_TAG_SPLIT_KEY_METHOD 0x42008A
#define KMIP_HEADER_TAG_SPLIT_KEY_PARTS 0x42008B
#define KMIP_HEADER_TAG_SPLIT_KEY_THRESHOLD 0x42008C
#define KMIP_HEADER_TAG_STATE 0x42008D
#define KMIP_HEADER_TAG_STORAGE_STATUS_MASK 0x42008E
#define KMIP_HEADER_TAG_SYMMETRIC_KEY 0x42008F
#define KMIP_HEADER_TAG_TEMPLATE 0x420090
#define KMIP_HEADER_TAG_TEMPLATE_ATTRIBUTE 0x420091
#define KMIP_HEADER_TAG_TIME_STAMP 0x420092
#define KMIP_HEADER_TAG_UNIQUE_BATCH_ITEM_ID 0x420093
#define KMIP_HEADER_TAG_UNIQUE_IDENTIFIER 0x420094
#define KMIP_HEADER_TAG_USAGE_LIMITS 0x420095
#define KMIP_HEADER_TAG_USAGE_LIMITS_COUNT 0x420096
#define KMIP_HEADER_TAG_USAGE_LIMITS_TOTAL 0x420097
#define KMIP_HEADER_TAG_USAGE_LIMITS_UNIT 0x420098
#define KMIP_HEADER_TAG_USERNAME 0x420099
#define KMIP_HEADER_TAG_VALIDITY_DATE 0x42009A
#define KMIP_HEADER_TAG_VALIDITY_INDICATOR 0x42009B
#define KMIP_HEADER_TAG_VENDOR_EXTENSION 0x42009C
#define KMIP_HEADER_TAG_VENDOR_IDENTIFICATION 0x42009D
#define KMIP_HEADER_TAG_WRAPPING_METHOD 0x42009E
#define KMIP_HEADER_TAG_X 0x42009F
#define KMIP_HEADER_TAG_Y 0x4200A0
#define KMIP_HEADER_TAG_PASSWORD 0x4200A1

/* Credential Type Enumeration */
#define KMIP_CREDRNTIAL_TYPE_USERNAME_PASSWORD 1

/* Key Compression Type Enumeration */
#define KMIP_KEY_COMPRESSION_EC_PUBLIC_KEY_TYPE_UNCOMPRESSED 1
#define KMIP_KEY_COMPRESSION_EC_PUBLIC_KEY_TYPE_X9_62_COMPRESSED_PRIME 2
#define KMIP_KEY_COMPRESSION_EC_PUBLIC_KEY_TYPE_X9_62_COMPRESSED_CHAR2 3
#define KMIP_KEY_COMPRESSION_EC_PUBLIC_KEY_TYPE_X9_62_HYBRID 4

/* Key Format Type Enumeration */
#define KMIP_KEY_FORMAT_TYPE_RAW 1
#define KMIP_KEY_FORMAT_TYPE_OPAQUE 2
#define KMIP_KEY_FORMAT_TYPE_PKCS1 3
#define KMIP_KEY_FORMAT_TYPE_PKCS8 4
#define KMIP_KEY_FORMAT_TYPE_X509 5
#define KMIP_KEY_FORMAT_TYPE_ECPRIVATEKEY 6
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_SYMMETRIC_KEY 7
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DSA_PRIVATE_KEY 8
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DSA_PUBLIC_KEY 9
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_RSA_PRIVATE_KEY 0xA
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_RSA_PUBLIC_KEY 0xB
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DH_PRIVATE_KEY 0xC
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_DH_PUBLIC_KEY 0xD
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDSA_PRIVATE_KEY 0xE
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDSA_PUBLIC_KEY 0xF
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDH_PRIVATE_KEY 0x10
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECDH_PUBLIC_KEY 0x11
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECMQV_PRIVATE_KEY 0x12
#define KMIP_KEY_FORMAT_TYPE_TRANSPARENT_ECMQV_PUBLIC_KEY 0x13

/* Wrapping Method Enumeration */
#define KMIP_WRAPPING_METHOD_ENCRYPT 1
#define KMIP_WRAPPING_METHOD_MAC_SIGN 2
#define KMIP_WRAPPING_METHOD_ENCRYPT_THEN_MAC_SIGN 3
#define KMIP_WRAPPING_METHOD_MAC_SIGN_THEN_ENCRYPT 4
#define KMIP_WRAPPING_METHOD_TR_31 5

/* Recommended Curve Enumeration for ECDSA, ECDH, and ECMQV */
#define KMIP_CURVE_ENUM_P_192 1
#define KMIP_CURVE_ENUM_K_163 2
#define KMIP_CURVE_ENUM_B_163 3
#define KMIP_CURVE_ENUM_P_224 4
#define KMIP_CURVE_ENUM_K_233 5
#define KMIP_CURVE_ENUM_B_233 6
#define KMIP_CURVE_ENUM_P_256 7
#define KMIP_CURVE_ENUM_K_283 8
#define KMIP_CURVE_ENUM_B_283 9
#define KMIP_CURVE_ENUM_P_384 0xA
#define KMIP_CURVE_ENUM_K_409 0xB
#define KMIP_CURVE_ENUM_B_409 0xC
#define KMIP_CURVE_ENUM_P_521 0xD
#define KMIP_CURVE_ENUM_K_571 0xE
#define KMIP_CURVE_ENUM_B_571 0xF

/* Certificate Type Enumeration */
#define KMIP_CERTIFICATE_TYPE_X509 1
#define KMIP_CERTIFICATE_TYPE_PGP 2

/* Split Key Method Enumeration */
#define KMIP_SPLIT_KEY_METHOD_XOR 1
#define KMIP_SPLIT_KEY_METHOD_POLYNOMIAL_SHARING_GF 2
#define KMIP_SPLIT_KEY_METHOD_POLYNOMIAL_SHARING_PRIME_FIELD 3

/* Object Type Enumeration */
#define KMIP_OBJECT_TYPE_CERTIFICATE 1
#define KMIP_OBJECT_TYPE_SYMMETRIC_KEY 2
#define KMIP_OBJECT_TYPE_PUBLIC_KEY 3
#define KMIP_OBJECT_TYPE_PRIVATE_KEY 4
#define KMIP_OBJECT_TYPE_SPLIT_KEY 5
#define KMIP_OBJECT_TYPE_TEMPLATE 6
#define KMIP_OBJECT_TYPE_SECRET_DATA 7
#define KMIP_OBJECT_TYPE_OPAQUE_OBJECT 8

/* Cryptographic Algorithm Enumeration */
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_DES 1
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_3DES 2
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_AES 3
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_RSA 4
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_DSA 5
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_ECDSA 6
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_SHA1 7
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_SHA224 8
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_SHA256 9
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_SHA384 0xA
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_SHA512 0xB
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_HMAC_MD5 0xC
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_DH 0xD
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_ECDH 0xE
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_ECMQV 0xF
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_BLOWFISH 0x10
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_CAMELLIA 0x11
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_CAST5 0x12
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_IDEA 0x13
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_MARS 0x14
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_RC2 0x15
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_RC4 0x16
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_RC5 0x17
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_SKIPJACK 0x18
#define KMIP_CRYPTOGRAPHIC_ALGORITHM_TWOFISH 0x19

  /* Link Type  */
#define KMIP_LINK_TYPE_CERTIFICATE_LINK 0x00000101 
#define KMIP_LINK_TYPE_PUBLIC_KEY_LINK 0x00000102 
#define KMIP_LINK_TYPE_PRIVATE_KEY_LINK 0x00000103 
#define KMIP_LINK_TYPE_DERIVATION_BASE_OBJECT_LINK 0x00000104 
#define KMIP_LINK_TYPE_DERIVED_KEY_LINK 0x00000105 
#define KMIP_LINK_TYPE_REPLACEMENT_OBJECT_LINK 0x00000106 
#define KMIP_LINK_TYPE_REPLACED_OBJECT_LINK 0x00000107 

  /* Cryptographic Usage Mask */
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_SIGN 0x00000001 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_VERIFY 0x00000002 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_ENCRYPT 0x00000004 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_DECRYPT 0x00000008 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_WRAP_KEY 0x00000010 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_UNWRAP_KEY 0x00000020 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_EXPORT 0x00000040 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_MAC_GENERATE 0x00000080 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_MAC_VERIFY 0x00000100 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_DERIVE_KEY 0x00000200 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_CONTENT_COMMITMENT 0x00000400 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_KEY_AGREEMENT 0x00000800 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_CERTIFICATE_SIGN 0x00001000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_CRL_SIGN 0x00002000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_GENERATE_CRYPTOGRAM 0x00004000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_VALIDATE_CRYPTOGRAM 0x00008000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_TRANSLATE_ENCRYPT 0x00010000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_TRANSLATE_DECRYPT 0x00020000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_TRANSLATE_WRAP 0x00040000 
#define KMIP_CRYPTOGRAPHIC_USAGE_MASK_TRANSLATE_UNWRAP 0x00080000 

/* Certificate Request Type Enumeration */
#define KMIP_CERTIFICATE_REQUEST_TYPE_CRMF 1
#define KMIP_CERTIFICATE_REQUEST_TYPE_PKCS10 2
#define KMIP_CERTIFICATE_REQUEST_TYPE_PEM 3
#define KMIP_CERTIFICATE_REQUEST_TYPE_PGP 4

/* Query Function Enumeration */
#define KMIP_QUERY_FUNCTION_QUERY_OPERATIONS 1
#define KMIP_QUERY_FUNCTION_QUERY_OBJECTS 2
#define KMIP_QUERY_FUNCTION_QUERY_SERVER_INFORMATION 3
#define KMIP_QUERY_FUNCTION_QUERY_APPLICATION_NAMESPACES 4

/* Cancellation Result Enumeration */
#define KMIP_CANCELLATION_RESULT_CANCELED 1
#define KMIP_CANCELLATION_RESULT_UNABLE_TO_CANCEL 2
#define KMIP_CANCELLATION_RESULT_COMPLETED 3
#define KMIP_CANCELLATION_RESULT_FAILED 4
#define KMIP_CANCELLATION_RESULT_UNAVAILABLE 5

/* Put Function Enumeration */
#define KMIP_PUT_FUNCTION_NEW 1
#define KMIP_PUT_FUNCTION_REPLACE 2

/* Operation Enumeration */
#define KMIP_OPERATION_CREATE 1
#define KMIP_OPERATION_CREATE_KEY_PAIR 2
#define KMIP_OPERATION_REGISTER 3
#define KMIP_OPERATION_REKEY 4
#define KMIP_OPERATION_DERIVE_KEY 5
#define KMIP_OPERATION_CERTIFY 6
#define KMIP_OPERATION_RECERTIFY 7
#define KMIP_OPERATION_LOCATE 8
#define KMIP_OPERATION_CHECK 9
#define KMIP_OPERATION_GET 0xA
#define KMIP_OPERATION_GET_ATTRIBUTES 0xB
#define KMIP_OPERATION_GET_ATTRIBUTE_LIST 0xC
#define KMIP_OPERATION_ADD_ATTRIBUTE 0xD
#define KMIP_OPERATION_MODIFY_ATTRIBUTE 0xE
#define KMIP_OPERATION_DELETE_ATTRIBUTE 0xF
#define KMIP_OPERATION_OBTAIN_LEASE 0x10
#define KMIP_OPERATION_GET_USAGE_ALLOCATION 0x11
#define KMIP_OPERATION_ACTIVATE 0x12
#define KMIP_OPERATION_REVOKE 0x13
#define KMIP_OPERATION_DESTROY 0x14
#define KMIP_OPERATION_ARCHIVE 0x15
#define KMIP_OPERATION_RECOVER 0x16
#define KMIP_OPERATION_VALIDATE 0x17
#define KMIP_OPERATION_QUERY 0x18
#define KMIP_OPERATION_CANCEL 0x19
#define KMIP_OPERATION_POLL 0x1A
#define KMIP_OPERATION_NOTIFY 0x1B
#define KMIP_OPERATION_PUT 0x1C

/* Result Status Enumeration */
#define KMIP_RESULT_STATUS_SUCCESS 1
#define KMIP_RESULT_STATUS_OPERATION_FAILED 2
#define KMIP_RESULT_STATUS_OPERATION_PENDING 3
#define KMIP_RESULT_STATUS_OPERATION_UNDONE 4

/* Result Reason Enumeration */
#define KMIP_RESULT_REASON_ITEM_NOT_FOUND 1 
#define KMIP_RESULT_REASON_RESPONSE_TOO_LARGE 2 
#define KMIP_RESULT_REASON_AUTHENTICATION_NOT_SUCCESSFUL 3
#define KMIP_RESULT_REASON_INVALID_MESSAGE 4
#define KMIP_RESULT_REASON_OPERATION_NOT_SUPPORTED 5 
#define KMIP_RESULT_REASON_MISSING_DATA 6 
#define KMIP_RESULT_REASON_INVALID_FIELD 7 
#define KMIP_RESULT_REASON_FEATURE_NOT_SUPPORTED 8
#define KMIP_RESULT_REASON_OPERATION_CANCELED_BY_REQUESTER 9 
#define KMIP_RESULT_REASON_CRYPTOGRAPHIC_FAILURE 0xA 
#define KMIP_RESULT_REASON_ILLEGAL_OPERATION 0xB 
#define KMIP_RESULT_REASON_PERMISSION_DENIED 0xC 
#define KMIP_RESULT_REASON_OBJECT_ARCHIVED 0xD 
#define KMIP_RESULT_REASON_INDEX_OUT_OF_BOUNDS 0xE 
#define KMIP_RESULT_REASON_APPLICATION_NAMESPACE_NOT_SUPPORTED 0xF 
#define KMIP_RESULT_REASON_KEY_FORMAT_TYPE_NOT_SUPPORTED 0x10 
#define KMIP_RESULT_REASON_KEY_COMPRESSION_TYPE_NOT_SUPPORTED 0x11 
#define KMIP_RESULT_REASON_GENERAL_FAILURE 0x100 

#define KMIP_ITEM_TYPE_STRUCTURE 1
#define KMIP_ITEM_TYPE_INTEGER 2  
#define KMIP_ITEM_TYPE_LONG_INTEGER 3 
#define KMIP_ITEM_TYPE_BIG_INTEGER 4 
#define KMIP_ITEM_TYPE_ENUMERATION 5 
#define KMIP_ITEM_TYPE_BOOLEAN  6  
#define KMIP_ITEM_TYPE_TEXT_STRING 7  
#define KMIP_ITEM_TYPE_BYTE_STRING 8 
#define KMIP_ITEM_TYPE_DATE_TIME 9 
#define KMIP_ITEM_TYPE_INTERVAL 0xA 

#define KMIP_MAJOR_VERSION 0
#define KMIP_MINOR_VERSION 1
  /*
typedef struct _tagtype {
  uint8_t header;
  uint16_t tag;
  uint8_t type;
} kmip_tagtype_t;
  */
  /*
union {
  uint64_t u64;
  uint8_t arr[8];
} uint64;

union {
  uint32_t u32;
  uint8_t arr[4];
} uint32;
  */
typedef struct _tagtype {
  unsigned header : 8;
  unsigned tag : 16;
  unsigned type : 8;
} kmip_tagtype_t;

typedef struct _enum {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  uint32_t value;
} kmip_enum_t;

typedef struct _int {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  uint32_t value;
} kmip_int_t;

typedef struct _bigint {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  struct ttlv_bigint_t *next; /* Support list of BigIntegers for 'Key Material' responses */
  uint8_t value[];
} kmip_bigint_t;

typedef struct _string {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  unsigned char *value;
  struct kmip_string_t *next;
} kmip_string_t;

typedef struct _link {
  kmip_enum_t *type;
  kmip_string_t *object_identifier;
} kmip_link_t;

typedef struct _digest {
  kmip_enum_t *hashing_algorithm;
  kmip_string_t *value;
} kmip_digest_t;

typedef struct _name_value {
  kmip_string_t *value;
  kmip_enum_t *type;
} kmip_name_value_t;

typedef struct _issuer_sn {
  kmip_string_t *issuer;
  kmip_string_t *serial_number;
} kmip_issuer_sn_t;

typedef struct _attribute_value {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  uint32_t value;
  kmip_name_value_t *name_value;
  kmip_issuer_sn_t *issuer_sn;
  kmip_link_t *link;
  kmip_string_t *certificate_issuer;  
  kmip_string_t *certificate_subject;  
  kmip_digest_t *digest;
} kmip_attribute_value_t;

typedef struct _attribute {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_string_t *name;
  kmip_int_t *index;
  kmip_attribute_value_t *value;
  struct kmip_attribute_t *next;
} kmip_attribute_t;

typedef struct _template_attribute {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_attribute_t *attribute;
} kmip_template_attribute_t;

typedef struct _response_key_material {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_bigint_t *key_material;
} kmip_response_key_material_t;

enum KmipKeyMaterialType { Request, Response };

typedef struct _key_value {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  enum KmipKeyMaterialType key_material_type;
  kmip_string_t *request_key_material;
  kmip_response_key_material_t *response_key_material;
} kmip_key_value_t;

typedef struct _timestamp {
  kmip_tagtype_t *tagtype;
  uint32_t len;
} kmip_timestamp_t;

typedef struct _key_block {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_enum_t *key_format_type;
  kmip_key_value_t *key_value;
  kmip_enum_t *cryptographic_algorithm;
  kmip_int_t *cryptographic_length;
} kmip_key_block_t;

typedef struct _private_key {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_key_block_t *key_block;
} kmip_private_key_t;

typedef struct _public_key {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_key_block_t *key_block;
} kmip_public_key_t;

typedef struct _certificate {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_enum_t *type;
  kmip_string_t *value;
} kmip_certificate_t;

typedef struct _register_private_key {
  kmip_template_attribute_t *template_attribute;
  kmip_private_key_t *private_key;
} kmip_register_private_key_t;

typedef struct _register_certificate {
  kmip_template_attribute_t *template_attribute;
  kmip_certificate_t *certificate;
} kmip_register_certificate_t;

typedef struct _register_public_key {
  kmip_template_attribute_t *template_attribute;
  kmip_public_key_t *public_key;
} kmip_register_public_key_t;

enum KmipObjectType { Public, Private, Certificate };

typedef struct _register_payload {
  kmip_enum_t *object_type;
  kmip_register_public_key_t *register_public_key;
  kmip_register_private_key_t *register_private_key;
  kmip_register_certificate_t *register_certificate;
} kmip_register_payload_t;

typedef struct _response_private_key {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_key_block_t *key_block;
} kmip_response_private_key_t;

enum KmipOperationType { Get, Locate, Register, Destroy, AddAttribute, GetAttribute, GetAttributeList };

typedef struct _response_payload {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_enum_t *object_type;
  kmip_string_t *unique_identifier;
  kmip_attribute_t *attribute;
  kmip_string_t *attribute_name;
  kmip_public_key_t *public_key;
  kmip_private_key_t *private_key;
  kmip_certificate_t *certificate;
} kmip_response_payload_t;

typedef struct _locate_payload {
  kmip_int_t *maximum_items; /* can be null */
  kmip_attribute_t *attribute;
} kmip_locate_payload_t;

typedef struct _get_payload {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  /* need more stuff here */
} kmip_get_payload_t;

typedef struct _request_payload {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  enum KmipOperationType type;
  kmip_register_payload_t *register_payload;
  kmip_locate_payload_t *locate_payload;
  kmip_get_payload_t *get_payload;
} kmip_request_payload_t;

typedef struct _batch_item {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_enum_t *operation;
  kmip_string_t *unique_batch_item_id; /* can be null */
  kmip_request_payload_t *payload;
  struct kmip_batch_item_t *next;
} kmip_batch_item_t;
  
typedef struct _protocol_version {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_int_t *major;
  kmip_int_t *minor;
} kmip_protocol_version_t;

typedef struct _header {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_protocol_version_t *version;
  kmip_timestamp_t *timestamp;
  kmip_int_t *batch_count;
} kmip_request_header_t, kmip_response_header_t;

typedef struct _message {
  kmip_tagtype_t *tagtype;
  uint32_t len;
  kmip_request_header_t *header;
  kmip_batch_item_t *batch_item;
} kmip_request_message_t, kmip_response_message_t;

typedef struct {
  int socket;
  SSL *sslHandle;
  SSL_CTX *sslContext;
} kmip_connection_t;

  int kmip_create_string(char *, uint16_t, uint8_t, kmip_string_t **);
  int kmip_create_register_payload(enum KmipObjectType, void *, kmip_register_payload_t **);
  int kmip_create_register_public_key(kmip_template_attribute_t*, kmip_public_key_t*, kmip_register_public_key_t**);
  int kmip_create_key_material(unsigned char *, kmip_string_t **); 
  int kmip_create_key_value(enum KmipKeyMaterialType, void *, kmip_key_value_t **);
  int kmip_create_key_block(uint32_t, uint32_t, uint32_t, kmip_key_value_t *, kmip_key_block_t **);
  int kmip_create_public_key(kmip_key_block_t *, kmip_public_key_t **);
  int kmip_create_attribute(char *, enum KmipAttributeType, uint32_t, void *, kmip_attribute_t **);
  int kmip_create_link_attribute(char *, uint16_t, uint32_t, kmip_attribute_t **);
  int kmip_create_link(uint32_t, char *, kmip_link_t **);
  int kmip_create_template_attribute(kmip_attribute_t *, kmip_template_attribute_t **);
  int kmip_create_request_payload(enum KmipOperationType, void *, kmip_request_payload_t **);
  int kmip_create_batch_item(kmip_request_payload_t *, char *, uint32_t, kmip_batch_item_t **);
  int kmip_create_request_header(uint32_t, kmip_request_header_t **);
  int kmip_create_request_message(kmip_request_header_t*, kmip_batch_item_t*, kmip_request_message_t**);
  int kmip_template_attribute_add_attribute(kmip_template_attribute_t *, kmip_attribute_t *);

  int kmip_recv_tagtype(kmip_tagtype_t*, kmip_connection_t*);

  int kmip_send_string(kmip_string_t*, kmip_connection_t*);
  int kmip_send_register_payload(kmip_register_payload_t*, kmip_connection_t*);
  int kmip_send_register_public_key(kmip_register_public_key_t*, kmip_connection_t*);
  int kmip_send_register_private_key(kmip_register_private_key_t*, kmip_connection_t*);
  int kmip_send_register_certificate(kmip_register_certificate_t*, kmip_connection_t*);
  int kmip_send_key_material(kmip_string_t*, kmip_connection_t*); 
  int kmip_send_key_value(kmip_key_value_t*, kmip_connection_t*);
  int kmip_send_key_block(kmip_key_block_t*, kmip_connection_t*);
  int kmip_send_public_key(kmip_public_key_t*, kmip_connection_t*);
  int kmip_send_attribute(kmip_attribute_t*, kmip_connection_t*);
  int kmip_send_template_attribute(kmip_template_attribute_t*, kmip_connection_t*);
  int kmip_send_request_payload(kmip_request_payload_t*, kmip_connection_t*);
  int kmip_send_request_header(kmip_request_header_t*, kmip_connection_t*);
  int kmip_send_protocol_version(kmip_protocol_version_t*, kmip_connection_t*);
  int kmip_send_batch_item(kmip_batch_item_t*, kmip_connection_t*);
  int kmip_send_request_message(kmip_request_message_t*, kmip_connection_t*);
  int kmip_send_locate_payload(kmip_locate_payload_t*, kmip_connection_t*);
  int kmip_send_get_payload(kmip_get_payload_t*, kmip_connection_t*);

int kmip_sizeof_register_payload(kmip_register_payload_t *);
int kmip_sizeof_register_private_key(kmip_register_private_key_t *);
int kmip_sizeof_register_public_key(kmip_register_public_key_t *);
int kmip_sizeof_register_certificate(kmip_register_certificate_t *);
int kmip_sizeof_bigint(kmip_bigint_t *);
int kmip_sizeof_string(kmip_string_t *);
int kmip_sizeof_attribute_value(enum KmipAttributeType, void *);
int kmip_sizeof_attribute(kmip_attribute_t *);
int kmip_sizeof_template_attribute(kmip_template_attribute_t *);
int kmip_sizeof_key_value(kmip_key_value_t *);
int kmip_sizeof_key_block(kmip_key_block_t *);
int kmip_sizeof_private_key(kmip_private_key_t *);
int kmip_sizeof_register_private_key(kmip_register_private_key_t *);

void kmip_free_register_payload(kmip_register_payload_t *);
void kmip_free_register_private_key(kmip_register_private_key_t *);
void kmip_free_register_public_key(kmip_register_public_key_t *);
void kmip_free_register_certificate(kmip_register_certificate_t *);
void kmip_free_bigint(kmip_bigint_t *);
void kmip_free_string(kmip_string_t *);
void kmip_free_attribute_value(enum KmipAttributeType, void *);
void kmip_free_attribute(kmip_attribute_t *);
void kmip_free_template_attribute(kmip_template_attribute_t *);
void kmip_free_key_value(kmip_key_value_t *);
void kmip_free_key_block(kmip_key_block_t *);
void kmip_free_private_key(kmip_private_key_t *);
void kmip_free_register_private_key(kmip_register_private_key_t *);
void kmip_free_key_material(kmip_string_t*); 

#ifdef __cplusplus
}
#endif
#endif

