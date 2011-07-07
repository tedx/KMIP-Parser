#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>

#include <kmip.h>

int kmip_read(kmip_connection_t *connection, uint8_t **data)
{
  int received = 0;
  int len = 0;
  kmip_tagtype_t tagtype;

  received = SSL_read (connection->sslHandle, &tagtype, sizeof(kmip_tagtype_t));
  if (received < sizeof(kmip_tagtype_t))
    return -1;

  received = SSL_read (connection->sslHandle, &len, sizeof(int));
  if (received < sizeof(int))
    return -1;

  if (len > 100000) {
    fprintf(stderr, "bad length\n");
    return -1;
  }

  *data = (uint8_t *)malloc(len);
  if (*data == NULL) {
    fprintf(stderr, "malloc failed\n");
    return -1;
  }

  memcpy(*data, (const void *)&tagtype, sizeof(kmip_tagtype_t));
  memcpy(*data+sizeof(kmip_tagtype_t), (const void *)&len, sizeof(int));

  received = SSL_read (connection->sslHandle, *data+sizeof(kmip_tagtype_t)+sizeof(int), len);
  if (received < len) {
    fprintf(stderr, "read error\n");
    return -1;
  }
  return 0;
}
