#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>

#include <kmip.h>

int kmip_send(kmip_connection_t *connection, uint8_t *buf, int len)
{
  return kmip_ssl_write_data(connection, buf, len);
}

int kmip_append_tagtype(kmip_tagtype_t *tagtype, int length, uint8_t **buf, uint8_t *eob)
{
  int len = 0;
  if ((*buf + sizeof(kmip_tagtype_t)) > eob)
    return -1;
  memcpy(*buf, (const void *)tagtype, sizeof(kmip_tagtype_t));
  *buf += sizeof(kmip_tagtype_t);
  len = htonl(length);
  if ((*buf + sizeof(int)) > eob)
    return -1;
  memcpy(*buf, (const void *)&len, sizeof(int));
  *buf += sizeof(int);
  return 0;
}

int kmip_append_string(kmip_string_t *string, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(string->tagtype, string->len, buf, eob) != 0)  
    return -1;
  if ((*buf + string->len) > eob)
    return -1;
  memcpy(*buf, (const void *)string->value, string->len);
  *buf += string->len;
  return 0;
}

int kmip_append_enum(kmip_enum_t *_enum, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(_enum->tagtype, _enum->len, buf, eob) != 0)  
    return -1;
  if ((*buf + sizeof(uint32_t)) > eob)
    return -1;
  memcpy(*buf, (const void *)&_enum->value, sizeof(uint32_t));
  *buf += sizeof(uint32_t);
  return 0;
}

int kmip_append_int(kmip_int_t *_int, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(_int->tagtype, _int->len, buf, eob) != 0)  
    return -1;
  if ((*buf + sizeof(int)) > eob)
    return -1;
  memcpy(*buf, (const void *)&_int->value, sizeof(int));
  *buf += sizeof(int);
  return 0;
}

int kmip_append_bigint(kmip_bigint_t *bigint, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(bigint->tagtype, bigint->len, buf, eob) != 0)  
    return -1;
  if ((*buf + bigint->len) > eob)
    return -1;
  memcpy(*buf, (const void *)&bigint->value, bigint->len);
  *buf += bigint->len;
  return 0;
}

int kmip_append_protocol_version(kmip_protocol_version_t *protocol_version, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(protocol_version->tagtype, protocol_version->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_int(protocol_version->major, buf, eob) != 0)  
    return -1;
  if (kmip_append_int(protocol_version->minor, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_request_header(kmip_request_header_t *request_header, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(request_header->tagtype, request_header->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_protocol_version(request_header->version, buf, eob) != 0)  
    return -1;
  if (kmip_append_int(request_header->batch_count, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_link(kmip_link_t *link, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_enum(link->type, buf, eob) != 0)  
    return -1;
  if (kmip_append_string(link->object_identifier, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_attribute_value(kmip_attribute_value_t *value, uint8_t**buf, uint8_t *eob)
{
  fprintf(stderr, "kmip_append_attribute_value: not implemented yet\n");
  return -1;
}

int kmip_append_attribute(kmip_attribute_t *attribute, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(attribute->tagtype, attribute->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_string(attribute->name, buf, eob) != 0)  
    return -1;
  if (attribute->index != NULL) {
    if (kmip_append_int(attribute->index, buf, eob) != 0)  
      return -1;
  }
  if (kmip_append_attribute_value(attribute->value, buf, eob) != 0)  
    return -1;

  /*
    switch (attribute->tagtype->type) {
    case KMIP_ITEM_TYPE_ENUMERATION:
    if (kmip_append_enum(attribute->enumeration, buf, eob) != 0)  
    return -1;
    break;
    case KMIP_ITEM_TYPE_INTEGER:
    if (kmip_append_int(attribute->integer, buf, eob) != 0)  
    return -1;
    break;
    case KMIP_ITEM_TYPE_TEXT_STRING:
    if (kmip_append_string(attribute->string, buf, eob) != 0)  
    return -1;
    break;
    case KMIP_ITEM_TYPE_BIG_INTEGER:
    if (kmip_append_bigint(attribute->big_integer, buf, eob) != 0)  
    return -1;
    break;
    case Link:
    if (kmip_append_link(attribute->link, buf, eob) != 0)  
    return -1;
    break;
    }
  */
  if (attribute->next != NULL) {
    kmip_append_attribute((kmip_attribute_t *)attribute->next, buf, eob);
  }
  return 0;
}

int kmip_append_template_attribute(kmip_template_attribute_t *template_attribute, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(template_attribute->tagtype, template_attribute->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_attribute(template_attribute->attribute, buf, eob) != 0)
    return -1;
  return 0;
}

int kmip_append_key_value(kmip_key_value_t *key_value, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(key_value->tagtype, key_value->len, buf, eob) != 0)  
    return -1;
  switch (key_value->key_material_type) {
  case Request:
    if (kmip_append_string(key_value->request_key_material, buf, eob) != 0)  
      return -1;
    break;
  case Response:
    return -1;
    break;
  }
  return 0;
}

int kmip_append_key_block(kmip_key_block_t *key_block, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(key_block->tagtype, key_block->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_enum(key_block->key_format_type, buf, eob) != 0)  
    return -1;
  if (kmip_append_key_value(key_block->key_value, buf, eob) != 0)
    return -1;
  if (kmip_append_enum(key_block->cryptographic_algorithm, buf, eob) != 0)  
    return -1;
  if (kmip_append_int(key_block->cryptographic_length, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_private_key(kmip_private_key_t *private_key, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(private_key->tagtype, private_key->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_key_block(private_key->key_block, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_public_key(kmip_public_key_t *public_key, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(public_key->tagtype, public_key->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_key_block(public_key->key_block, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_certificate(kmip_certificate_t *certificate, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(certificate->tagtype, certificate->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_enum(certificate->type, buf, eob) != 0)  
    return -1;
  if (kmip_append_string(certificate->value, buf, eob) != 0)  
    return -1;
  return 0;
}

int kmip_append_register_public_key(kmip_register_public_key_t *register_public_key, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_template_attribute(register_public_key->template_attribute, buf, eob) != 0)
    return -1;
  if (kmip_append_public_key(register_public_key->public_key, buf, eob) != 0)
    return -1;
  return 0;
}

int kmip_append_register_private_key(kmip_register_private_key_t *register_private_key, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_template_attribute(register_private_key->template_attribute, buf, eob) != 0)
    return -1;
  if (kmip_append_private_key(register_private_key->private_key, buf, eob) != 0)
    return -1;
  return 0;
}

int kmip_append_register_certificate(kmip_register_certificate_t *register_certificate, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_template_attribute(register_certificate->template_attribute, buf, eob) != 0)
    return -1;
  if (kmip_append_certificate(register_certificate->certificate, buf, eob) != 0)
    return -1;
  return 0;
}

int kmip_append_register_payload(kmip_register_payload_t *payload, uint8_t **buf, uint8_t *eob)
{
  switch (payload->object_type->value) {
  case KMIP_OBJECT_TYPE_PUBLIC_KEY:
    if (kmip_append_register_public_key(payload->register_public_key, buf, eob) != 0)  
      return -1;
    break;
  case KMIP_OBJECT_TYPE_PRIVATE_KEY:
    if (kmip_append_register_private_key(payload->register_private_key, buf, eob) != 0)  
      return -1;
    break;
  case KMIP_OBJECT_TYPE_CERTIFICATE:
    if (kmip_append_register_certificate(payload->register_certificate, buf, eob) != 0)  
      return -1;
    break;
  }  
  return 0;
}

int kmip_append_locate_payload(kmip_locate_payload_t *locate_payload, uint8_t **buf, uint8_t *eob)
{
  fprintf(stderr, "kmip_append_locate_payload: not implemented yet\n");
  return -1;
}

int kmip_append_get_payload(kmip_get_payload_t *get_payload, uint8_t **buf, uint8_t *eob) 
{
  fprintf(stderr, "kmip_append_get_payload: not implemented yet\n");
  return -1;
}

int kmip_append_request_payload(kmip_request_payload_t *request_payload, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(request_payload->tagtype, request_payload->len, buf, eob) != 0)  
    return -1;
  switch (request_payload->type) {
  case Register:
    if (kmip_append_register_payload(request_payload->register_payload, buf, eob) != 0)  
      return -1;
    break;
  case Locate:
    if (kmip_append_locate_payload(request_payload->locate_payload, buf, eob) != 0)  
      return -1;
    break;
  case Get:
    if (kmip_append_get_payload(request_payload->get_payload, buf, eob) != 0)  
      return -1;
    break;
  case Destroy:
  case AddAttribute:
  case GetAttribute:
  case GetAttributeList:
    fprintf(stderr, "kmip_append_request_payload: Destroy/AddAttribute/GetAttribute/GetAttributeList not implemented yet\n");
    return -1;
    break;
  }
  return 0;
}

int kmip_append_batch_item(kmip_batch_item_t *batch_item, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(batch_item->tagtype, batch_item->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_enum(batch_item->operation, buf, eob) != 0)  
    return -1;
  if (batch_item->unique_batch_item_id != NULL) {
    if (kmip_append_string(batch_item->unique_batch_item_id, buf, eob) != 0)  
      return -1;
  }
  if (kmip_append_request_payload(batch_item->payload, buf, eob) != 0)  
    return -1;

  if (batch_item->next != NULL) {
    if (kmip_append_batch_item((kmip_batch_item_t *)batch_item->next, buf, eob) != 0)
      return -1;
  }
  return 0;
}

int kmip_append_request_message(kmip_request_message_t *request_message, uint8_t **buf, uint8_t *eob)
{
  if (kmip_append_tagtype(request_message->tagtype, request_message->len, buf, eob) != 0)  
    return -1;
  if (kmip_append_request_header(request_message->header, buf, eob) != 0)
    return -1;
  if (kmip_append_batch_item(request_message->batch_item, buf, eob) != 0)
    return -1;
  return 0;
}

