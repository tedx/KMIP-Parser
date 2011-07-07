#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>

#include <kmip.h>

int kmip_sizeof_bigint(kmip_bigint_t *bigint)
{
  return bigint->len + sizeof(kmip_tagtype_t) + sizeof(int);
}

int kmip_sizeof_string(kmip_string_t *string)
{
  return string->len + sizeof(kmip_tagtype_t) + sizeof(int);
}

int kmip_sizeof_link(kmip_link_t *link)
{
  return sizeof(kmip_enum_t) + kmip_sizeof_string(link->object_identifier);
}

int kmip_sizeof_name_value(kmip_name_value_t *name_value)
{
  return 0;
}

int kmip_sizeof_certificate_subject(kmip_string_t *certificate_subject)
{
  return 0;
}

int kmip_sizeof_digest(kmip_digest_t *digest)
{
  return 0;
}

int kmip_sizeof_issuer_sn(kmip_issuer_sn_t *issuer_sn)
{
  return 0;
}

int kmip_sizeof_certificate_issuer(kmip_string_t *certificate_issuer)
{
  return 0;
}

int kmip_sizeof_attribute_value(kmip_attribute_value_t *value)
{
  int size = 0;
  
  if (value->name_value != NULL) {
    size += kmip_sizeof_name_value(value->name_value);
  }
  if (value->issuer_sn != NULL) {
    size += kmip_sizeof_issuer_sn(value->issuer_sn);
  }
  if (value->link != NULL) {
    size += kmip_sizeof_link(value->link);
  }
  if (value->certificate_issuer != NULL) {
    size += kmip_sizeof_certificate_issuer(value->certificate_issuer);
  }
  if (value->certificate_subject != NULL) {
    size += kmip_sizeof_certificate_subject(value->certificate_subject);
  }
  if (value->digest != NULL) {
    size += kmip_sizeof_digest(value->digest);
  }
  if (size == 0)
    size = 4; /* defaults to size of int */

  return size;
}

int kmip_sizeof_attribute(kmip_attribute_t *attribute)
{
  return attribute->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_template_attribute(kmip_template_attribute_t *template_attribute)
{
  return template_attribute->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_key_value(kmip_key_value_t *key_value)
{
  return key_value->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_key_block(kmip_key_block_t *key_block)
{
  return key_block->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_private_key(kmip_private_key_t *private_key)
{
  return private_key->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_public_key(kmip_public_key_t *public_key)
{
  return public_key->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_certificate(kmip_certificate_t *certificate)
{
  return sizeof(kmip_enum_t) + kmip_sizeof_string(certificate->value) + certificate->len + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
}

int kmip_sizeof_register_private_key(kmip_register_private_key_t *register_private_key)
{
  int size = 0;
  size += kmip_sizeof_template_attribute(register_private_key->template_attribute);
  size += kmip_sizeof_private_key(register_private_key->private_key);
  return size;
}

int kmip_sizeof_register_public_key(kmip_register_public_key_t *register_public_key)
{
  int size = 0;
  size += kmip_sizeof_template_attribute(register_public_key->template_attribute);
  size += kmip_sizeof_public_key(register_public_key->public_key);
  return size;
}

int kmip_sizeof_register_certificate(kmip_register_certificate_t *register_certificate)
{
  int size = 0;
  size += kmip_sizeof_template_attribute(register_certificate->template_attribute);
  size += kmip_sizeof_certificate(register_certificate->certificate);
  return size;
}

int kmip_sizeof_register_payload(kmip_register_payload_t *payload) 
{
  int size = 0;
  size += sizeof(kmip_enum_t);
  switch (payload->object_type->value) {
  case KMIP_OBJECT_TYPE_PUBLIC_KEY:
    size += kmip_sizeof_register_public_key(payload->register_public_key);
    break;
  case KMIP_OBJECT_TYPE_PRIVATE_KEY:
    size += kmip_sizeof_register_private_key(payload->register_private_key);
    break;
  case KMIP_OBJECT_TYPE_CERTIFICATE:
    size += kmip_sizeof_register_certificate(payload->register_certificate);
    break;
  }
  size += sizeof(kmip_tagtype_t);
  size += sizeof(uint32_t);
  return size;
}

int kmip_sizeof_protocol_version(kmip_protocol_version_t *protocol_version)
{
  int size = 0;
  size = sizeof(kmip_int_t) * 2 + sizeof(kmip_tagtype_t) + sizeof(uint32_t);
  return size;
}

int kmip_sizeof_batch_item(kmip_batch_item_t *batch_item)
{
  int size = 0;
  size += sizeof(kmip_tagtype_t);
  size += sizeof(uint32_t);
  return size;
}

int kmip_sizeof_request_header(kmip_request_header_t *request_header)
{
  int size = 0;

  size += kmip_sizeof_protocol_version(request_header->version);
  size += sizeof(kmip_int_t);
  size += sizeof(kmip_tagtype_t);
  size += sizeof(uint32_t);
  return size;
}

int kmip_sizeof_request_message(kmip_request_message_t *request_message)
{
  int size = 0;
  size += kmip_sizeof_request_header(request_message->header);
  size += kmip_sizeof_batch_item(request_message->batch_item);
  size += sizeof(kmip_tagtype_t);
  size += sizeof(uint32_t);
  return 0;
}

void kmip_free_string(kmip_string_t *string)
{
  free(string->value);
  free(string);
}

void kmip_free_name_value(kmip_name_value_t *name_value)
{
}

void kmip_free_int(kmip_int_t *_int)
{
  free(_int);
}

void kmip_free_bigint(kmip_bigint_t *bigint)
{
  free(bigint->value);
  free(bigint);
}

void kmip_free_link(kmip_link_t *link)
{
  kmip_free_string(link->object_identifier);
  free(link);
}

void kmip_free_attribute(kmip_attribute_t *attribute)
{
  if (attribute->next != NULL)
    kmip_free_attribute((kmip_attribute_t *)attribute->next);
  if (attribute->index != NULL)
    kmip_free_int(attribute->index);
  kmip_free_string(attribute->name);
  if (attribute->index != NULL)
    kmip_free_int(attribute->index);
  kmip_free_attribute_value(attribute->value);
  free(attribute);
}

void kmip_free_attribute_value(kmip_attribute_value_t *attribute_value)
{
  free(attribute_value->tagtype);
  if (attribute_value->name_value != NULL)
    kmip_free_name_value(attribute_value->name_value);
  if (attribute_value->link != NULL)
    kmip_free_link(attribute_value->link);
  /* more pointers to clean up */
  free(attribute_value);
}

void kmip_free_get_payload(kmip_get_payload_t *get_payload)
{
  free(get_payload);
}

void kmip_free_locate_payload(kmip_locate_payload_t *locate_payload)
{
  if (locate_payload->maximum_items != NULL)
    free(locate_payload->maximum_items);
  kmip_free_attribute(locate_payload->attribute);
  free(locate_payload);
}

void kmip_free_template_attribute(kmip_template_attribute_t *template_attribute)
{
  kmip_free_attribute(template_attribute->attribute);
  free(template_attribute);
}

void kmip_free_key_value(kmip_key_value_t *key_value)
{
  switch (key_value->key_material_type) {
  case Request:
    kmip_free_string(key_value->request_key_material);
    break;
  case Response:
    /*    kmip_free_response_key_material(key_value->key_material.response_key_material);*/
    break;
  }
  free(key_value);
}

void kmip_free_key_block(kmip_key_block_t *key_block)
{
  kmip_free_key_value(key_block->key_value);
  free(key_block);
}

void kmip_free_private_key(kmip_private_key_t *private_key)
{
  kmip_free_key_block(private_key->key_block);
  free(private_key);
}

void kmip_free_public_key(kmip_public_key_t *public_key)
{
  kmip_free_key_block(public_key->key_block);
  free(public_key);
}

void kmip_free_register_public_key(kmip_register_public_key_t *register_public_key)
{
  kmip_free_template_attribute(register_public_key->template_attribute);
  kmip_free_public_key(register_public_key->public_key);
  free(register_public_key);
}

void kmip_free_register_private_key(kmip_register_private_key_t *register_private_key)
{
  kmip_free_template_attribute(register_private_key->template_attribute);
  kmip_free_private_key(register_private_key->private_key);
  free(register_private_key);
}

void kmip_free_certificate(kmip_certificate_t *certificate)
{
  kmip_free_string(certificate->value);
  free(certificate);
}

void kmip_free_register_certificate(kmip_register_certificate_t *register_certificate)
{
  kmip_free_template_attribute(register_certificate->template_attribute);
  kmip_free_certificate(register_certificate->certificate);
  free(register_certificate);
}

void kmip_free_register_payload(kmip_register_payload_t *register_payload)
{
  switch(register_payload->object_type->value) {
  case KMIP_OBJECT_TYPE_PUBLIC_KEY:
    kmip_free_register_public_key(register_payload->register_public_key);
    break;
  case KMIP_OBJECT_TYPE_PRIVATE_KEY:
    kmip_free_register_private_key(register_payload->register_private_key);
    break;
  case KMIP_OBJECT_TYPE_CERTIFICATE:
    kmip_free_register_certificate(register_payload->register_certificate);
    break;
  }
  free(register_payload);
}

void kmip_free_request_payload(kmip_request_payload_t *request_payload)
{
  switch (request_payload->type) {
  case Register:
    kmip_free_register_payload(request_payload->register_payload);
    break;
  case Locate:
    kmip_free_locate_payload(request_payload->locate_payload);
    break;
  case Get:
    kmip_free_get_payload(request_payload->get_payload);
    break;
  case Destroy:
  case AddAttribute:
  case GetAttribute:
  case GetAttributeList:
    break;
  }
  free(request_payload);
}

void kmip_free_batch_item(kmip_batch_item_t *batch_item)
{
  if (batch_item->next != NULL)
    kmip_free_batch_item((kmip_batch_item_t *)batch_item->next);

  if (batch_item->unique_batch_item_id != NULL)
    kmip_free_string(batch_item->unique_batch_item_id);
  kmip_free_request_payload(batch_item->payload);    
}

void kmip_free_protocol_version(kmip_protocol_version_t *protocol_version)
{
  free(protocol_version);
}

void kmip_free_request_header(kmip_request_header_t *request_header)
{
  kmip_free_protocol_version(request_header->version);
  free(request_header);
}

void kmip_free_request_message(kmip_request_message_t *request_message)
{
  kmip_free_request_header(request_message->header);
  kmip_free_batch_item(request_message->batch_item);
  free(request_message);
}

int kmip_create_tagtype(uint16_t tag, uint8_t type, kmip_tagtype_t **tagtype)
{
  *tagtype = (kmip_tagtype_t *)malloc(sizeof(kmip_tagtype_t));
  if (*tagtype == NULL)
    return -1;
  (*tagtype)->header = 0x42;
  (*tagtype)->tag = tag;
  (*tagtype)->type = type;
  return 0;
}

int kmip_create_int(uint32_t value, uint16_t tag, uint8_t type, kmip_int_t **ttlv_int)
{
  *ttlv_int = (kmip_int_t *)malloc(sizeof(kmip_int_t));
  if (*ttlv_int == NULL)
    return -1;
  if (kmip_create_tagtype(tag, type, &((*ttlv_int)->tagtype)) != 0)
    return -1;
  (*ttlv_int)->value = value;
  return 0;
}

int kmip_create_enum(uint32_t value, uint16_t tag, uint8_t type, kmip_enum_t **ttlv_enum)
{
  *ttlv_enum = (kmip_enum_t *)malloc(sizeof(kmip_enum_t));
  if (*ttlv_enum == NULL)
    return -1;
  if (kmip_create_tagtype(tag, type, &((*ttlv_enum)->tagtype)) != 0)
    return -1;
  (*ttlv_enum)->value = value;
  return 0;
}

int kmip_create_string(char *s, uint16_t tag, uint8_t type, kmip_string_t **ttlv_string)
{
  *ttlv_string = (kmip_string_t *)malloc(sizeof(kmip_string_t) + strlen(s));
  if (*ttlv_string == NULL)
    return -1;
  if (kmip_create_tagtype(tag, type, &((*ttlv_string)->tagtype)) != 0)
    return -1;
  (*ttlv_string)->len = strlen(s);
  (*ttlv_string)->value = (unsigned char *)malloc((*ttlv_string)->len);
  if ((*ttlv_string)->value == NULL)
    return -1;
  strncpy((char *)&((*ttlv_string)->value), s, (*ttlv_string)->len);
  return 0;
}

int kmip_create_key_material(unsigned char *keydata, kmip_string_t **key_material) 
{
  *key_material = (kmip_string_t *)malloc(sizeof(kmip_string_t) + strlen((char *)keydata));
  if (*key_material == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_KEY_MATERIAL, (uint8_t)KMIP_ITEM_TYPE_BYTE_STRING, &((*key_material)->tagtype)) != 0)
    return -1;
  (*key_material)->len = strlen((char *)keydata);
  strncpy((char *)&((*key_material)->value), (char *)keydata, strlen((char *)keydata));
  return 0;
}

int kmip_create_key_value(enum KmipKeyMaterialType key_material_type, void *key_material, kmip_key_value_t **key_value) 
{
  /* create the key value structure */
  *key_value = (kmip_key_value_t *)malloc(sizeof(key_value));
  if (*key_value == NULL) 
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_KEY_VALUE, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*key_value)->tagtype)) != 0)
    return -1;
  (*key_value)->key_material_type = key_material_type;
  switch (key_material_type) {
  case Request:
    (*key_value)->request_key_material = (kmip_string_t *)key_material;
    (*key_value)->len = kmip_sizeof_string((kmip_string_t*)key_material);
    break;
  case Response:
    (*key_value)->len = 0; /* Need to fix */
    break;
  default:
    return -1;
  }
  return 0;
}

int kmip_create_key_block(uint32_t key_format_type, uint32_t algorithm, uint32_t key_size, kmip_key_value_t *key_value, kmip_key_block_t **key_block) 
{
  /* create the key block structure */
  *key_block = (kmip_key_block_t *)malloc(sizeof(kmip_key_block_t));
  if (*key_block == NULL) 
    return -1;

  if (kmip_create_tagtype((uint16_t)KMIP_TAG_KEY_BLOCK, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*key_block)->tagtype)) != 0)
    return -1;

  if (kmip_create_enum(key_format_type, (uint16_t)KMIP_TAG_KEY_FORMAT_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*key_block)->key_format_type)) != 0)
    return -1;

  if (kmip_create_enum(algorithm, (uint16_t)KMIP_TAG_CRYPTOGRAPHIC_ALGORITHM, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*key_block)->cryptographic_algorithm)) != 0)
    return -1;

  if (kmip_create_int(key_size, (uint16_t)KMIP_TAG_CRYPTOGRAPHIC_LENGTH, (uint8_t)KMIP_ITEM_TYPE_INTEGER, &((*key_block)->cryptographic_length)) != 0)
    return -1;
      
  (*key_block)->key_value = key_value;
  (*key_block)->len = (sizeof(kmip_enum_t) * 3) + kmip_sizeof_key_value(key_value);
  return 0;
}

int kmip_create_public_key(kmip_key_block_t *key_block, kmip_public_key_t **public_key)
{
  *public_key = (kmip_public_key_t *)malloc(sizeof(kmip_public_key_t));
  if (*public_key == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_PUBLIC_KEY, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*public_key)->tagtype)) != 0)
    return -1;
  (*public_key)->len = sizeof(kmip_tagtype_t) + sizeof(uint32_t) + key_block->len;
  return 0;
}

int kmip_create_certificate(uint32_t type, char *value,  kmip_certificate_t **certificate)
{
  *certificate = (kmip_certificate_t *)malloc(sizeof(kmip_certificate_t));
  if (*certificate == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_CERTIFICATE, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*certificate)->tagtype)) != 0)
    return -1;

  if (kmip_create_enum(type, (uint16_t)KMIP_TAG_CERTIFICATE_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*certificate)->type)) != 0)
    return -1;

  if (kmip_create_string(value, (uint16_t)KMIP_TAG_CERTIFICATE_VALUE, (uint8_t)KMIP_ITEM_TYPE_BYTE_STRING, &((*certificate)->value)) != 0)
    return -1;

  (*certificate)->len = sizeof(kmip_tagtype_t) + sizeof(uint32_t) + kmip_sizeof_string((*certificate)->value) + sizeof(kmip_enum_t) ;
  return 0;
}

int kmip_create_attribute(char *name, 
			  uint32_t index, 
			  kmip_attribute_t **attribute)
{
  *attribute = (kmip_attribute_t *)malloc(sizeof(kmip_attribute_t));
  if (*attribute == NULL)
    return -1;

  if (kmip_create_tagtype((uint16_t)KMIP_TAG_ATTRIBUTE, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*attribute)->tagtype)) != 0)
    return -1;

  if (kmip_create_string(name,  (uint16_t)KMIP_TAG_ATTRIBUTE_NAME, (uint8_t)KMIP_ITEM_TYPE_TEXT_STRING, &(*attribute)->name) != 0)
    return -1;

  (*attribute)->next = NULL;
  if (index > 0) {
    kmip_create_int(index,  (uint16_t)KMIP_TAG_ATTRIBUTE_INDEX, (uint8_t)KMIP_ITEM_TYPE_INTEGER, &(*attribute)->index);
    if ((*attribute)->index == NULL) {
      kmip_free_attribute(*attribute);
      return -1;
    }
  }
  else {
    (*attribute)->index = NULL;
  }
  return 0;
}

int kmip_create_link(uint32_t link_type, char *data, kmip_link_t **link)
{
  *link = (kmip_link_t *)malloc(sizeof(kmip_link_t));
  if (*link == NULL)
    return -1;
  if (kmip_create_enum(link_type, (uint16_t)KMIP_TAG_LINK_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*link)->type)) != 0) {
    free(*link);
    return -1;
  }
  if (kmip_create_string(data, (uint16_t)KMIP_TAG_LINKED_OBJECT_IDENTIFIER, (uint8_t)KMIP_ITEM_TYPE_TEXT_STRING, &((*link)->object_identifier)) != 0) {
    /*    kmip_free_enum((*link)->type)); */
    free(*link);
    return -1;
  }
  return 0;
}

int kmip_create_link_attribute(char *uuid, uint16_t tag, int index, kmip_attribute_t **attribute)
{
  kmip_link_t *link = NULL;
  kmip_attribute_value_t *value = NULL;
  
  if (kmip_create_link(tag, uuid, &link) != 0)
    return -1;

  if (kmip_create_attribute("Link", index, attribute) != 0) {
    kmip_free_link(link);
    return -1;
  }
  /* Need to add
  if (kmip_create_attribute_value(&value) != 0) {
    kmip_free_link(link);
    return -1;
  }
  */
  value->link = link;
  (*attribute)->value = value;

  return 0;
}

int kmip_create_template_attribute(kmip_attribute_t *attribute, kmip_template_attribute_t **template_attribute)
{
  *template_attribute = (kmip_template_attribute_t *)malloc(sizeof(kmip_template_attribute_t));
  if (*template_attribute == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_TEMPLATE_ATTRIBUTE, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*template_attribute)->tagtype)) != 0)
    return -1;

  kmip_template_attribute_add_attribute(*template_attribute, attribute);
  return 0;
}

int kmip_create_register_public_key(kmip_template_attribute_t *template_attribute, kmip_public_key_t *public_key, kmip_register_public_key_t **register_public_key)
{
  *register_public_key = (kmip_register_public_key_t *)malloc(sizeof(kmip_register_public_key_t));
  if (*register_public_key == NULL)
    return -1;
  (*register_public_key)->template_attribute = template_attribute;
  (*register_public_key)->public_key = public_key;
  return 0;
}

int kmip_create_register_payload(uint32_t object_type, void *payload, kmip_register_payload_t **register_payload)
{
  *register_payload = (kmip_register_payload_t *)malloc(sizeof(kmip_register_payload_t));
  if (*register_payload == NULL)
    return -1;

  switch (object_type) {
  case KMIP_OBJECT_TYPE_PUBLIC_KEY:
    if (kmip_create_enum(KMIP_OBJECT_TYPE_PUBLIC_KEY, (uint16_t)KMIP_TAG_OBJECT_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*register_payload)->object_type)) != 0)
      return -1;
    (*register_payload)->register_public_key = (kmip_register_public_key_t *)payload;
    break;
  case KMIP_OBJECT_TYPE_PRIVATE_KEY:
    (*register_payload)->register_private_key = (kmip_register_private_key_t *)payload;
    if (kmip_create_enum(KMIP_OBJECT_TYPE_PRIVATE_KEY, (uint16_t)KMIP_TAG_OBJECT_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*register_payload)->object_type)) != 0)
      return -1;
    break;
  case KMIP_OBJECT_TYPE_CERTIFICATE:
    (*register_payload)->register_certificate = (kmip_register_certificate_t *)payload;
    if (kmip_create_enum(KMIP_OBJECT_TYPE_CERTIFICATE, (uint16_t)KMIP_TAG_OBJECT_TYPE, (uint8_t)KMIP_ITEM_TYPE_ENUMERATION, &((*register_payload)->object_type)) != 0)
      return -1;
    break;
  default:
    free(*register_payload);
    return -1;
  }
  return 0;
}

int kmip_create_request_payload(enum KmipOperationType request_type, void *payload, kmip_request_payload_t **request_payload)
{
  *request_payload = (kmip_request_payload_t *)malloc(sizeof(kmip_request_payload_t));
  if (*request_payload == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_REQUEST_PAYLOAD, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*request_payload)->tagtype)) != 0)
    return -1;

  (*request_payload)->type = request_type;
  switch (request_type) {
  case Register:
    (*request_payload)->register_payload = (kmip_register_payload_t *)payload;
    /*  (*request_payload)->len = kmip_sizeof_register_payload((register_payload_t *)payload);*/
    break;
  case Locate:
    (*request_payload)->locate_payload = (kmip_locate_payload_t *)payload;
    /*  (*request_payload)->len = ;*/
    break;
  case Get:
    (*request_payload)->get_payload = (kmip_get_payload_t *)payload;
    /*  (*request_payload)->len = ;*/
    break;
  default:
    free(*request_payload);
    return -1;
  }
  return 0;
}

int kmip_create_batch_item(kmip_request_payload_t *payload, char *uuid, uint32_t operation, kmip_batch_item_t **batch_item)
{
  *batch_item = (kmip_batch_item_t *)malloc(sizeof(kmip_batch_item_t));
  if (*batch_item == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_BATCH_ITEM, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*batch_item)->tagtype)) != 0)
    return -1;
  /*  (*batch_item)->len = ; */

  if (kmip_create_enum(operation, (uint16_t)KMIP_TAG_OPERATION, (uint8_t) KMIP_ITEM_TYPE_ENUMERATION, &((*batch_item)->operation)) != 0)
      return -1;

  if (uuid != NULL) {
    kmip_create_string(uuid, (uint16_t)KMIP_TAG_UNIQUE_BATCH_ITEM_ID, (uint8_t) KMIP_ITEM_TYPE_TEXT_STRING, &((*batch_item)->unique_batch_item_id));
    if ((*batch_item)->unique_batch_item_id == NULL)
      return -1;
  }
  (*batch_item)->payload = payload;
  (*batch_item)->next = NULL;
  return 0;
}

void init_int(uint32_t value, uint16_t tag, kmip_int_t *ttlv_int)
{
  ttlv_int->tagtype->header = 0x42;
  ttlv_int->tagtype->tag = tag;
  ttlv_int->tagtype->type = (uint8_t)KMIP_ITEM_TYPE_INTEGER;
  ttlv_int->len = 4;
  ttlv_int->value = value;
}

int kmip_create_protocol_version(kmip_protocol_version_t **protocol_version)
{
  *protocol_version = (kmip_protocol_version_t *)malloc(sizeof(kmip_protocol_version_t));
  if (*protocol_version == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_PROTOCOL_VERSION, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*protocol_version)->tagtype)) != 0)
    return -1;

  kmip_create_int((uint32_t)KMIP_MAJOR_VERSION, (uint16_t)KMIP_TAG_PROTOCOL_VERSION_MAJOR, (uint8_t)KMIP_ITEM_TYPE_INTEGER, &((*protocol_version)->major));
  kmip_create_int((uint32_t)KMIP_MINOR_VERSION, (uint16_t)KMIP_TAG_PROTOCOL_VERSION_MINOR, (uint8_t)KMIP_ITEM_TYPE_INTEGER, &((*protocol_version)->minor));
  (*protocol_version)->len = sizeof(kmip_int_t) * 2;
  return 0;
}

int kmip_create_request_header(uint32_t batch_count, kmip_request_header_t **request_header)
{
  *request_header = (kmip_request_header_t *)malloc(sizeof(kmip_request_header_t));
  if (*request_header == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_REQUEST_HEADER, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*request_header)->tagtype)) != 0)
    return -1;
  kmip_create_protocol_version(&(*request_header)->version);

  if (kmip_create_int(batch_count, (uint16_t)KMIP_TAG_BATCH_COUNT, (uint8_t)KMIP_ITEM_TYPE_INTEGER, &((*request_header)->batch_count)) != 0)
    return -1;
  (*request_header)->len = sizeof(kmip_int_t) + kmip_sizeof_protocol_version((*request_header)->version);
  return 0;
}

int kmip_create_request_message(kmip_request_header_t *request_header, kmip_batch_item_t *batch_item, kmip_request_message_t **request_message)
{
  *request_message = (kmip_request_message_t *)malloc(sizeof(kmip_request_message_t));
  if (*request_message == NULL)
    return -1;
  if (kmip_create_tagtype((uint16_t)KMIP_TAG_REQUEST_MESSAGE, (uint8_t)KMIP_ITEM_TYPE_STRUCTURE, &((*request_message)->tagtype)) != 0)
    return -1;
  (*request_message)->header = request_header;
  (*request_message)->batch_item = batch_item;
  (*request_message)->len = kmip_sizeof_request_header(request_header) + kmip_sizeof_batch_item(batch_item);
  return 0;
}

int kmip_response_message_add_batch_item(kmip_batch_item_t *new_batch_item, kmip_response_message_t *response_message)
{
  kmip_batch_item_t *batch_item = NULL;
  if (new_batch_item == NULL || response_message == NULL)
    return -1;
  batch_item = response_message->batch_item;
  if (batch_item != NULL) {
    while (batch_item->next != NULL)
      batch_item = (kmip_batch_item_t *)batch_item->next;
    batch_item->next = (struct kmip_batch_item_t *)new_batch_item;
  }
  else
    response_message->batch_item = new_batch_item;
  return 0;
}

int kmip_template_attribute_add_attribute(kmip_template_attribute_t *template_attribute, kmip_attribute_t *new_attribute)
{
  kmip_attribute_t *attribute = NULL;
  if (template_attribute == NULL || new_attribute == NULL)
    return -1;
  attribute = template_attribute->attribute;
  if (attribute == NULL)
    template_attribute->attribute = new_attribute;
  else {
    while (attribute->next != NULL)
      attribute = (kmip_attribute_t *)attribute->next;
    attribute->next = (struct kmip_attribute_t *)new_attribute;
  }
  template_attribute->len += kmip_sizeof_attribute(new_attribute);
  return 0;
}
