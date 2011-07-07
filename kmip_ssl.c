#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h>

#include <kmip.h>

#define SERVER  "127.0.0.1"
#define PORT 8443


int kmip_tcp_connect(void)
{
  int error, handle;
  struct hostent *host;
  struct sockaddr_in server;

  host = gethostbyname (SERVER);
  handle = socket (AF_INET, SOCK_STREAM, 0);
  if (handle == -1)
    {
      perror ("Socket");
      handle = 0;
    }
  else
    {
      server.sin_family = AF_INET;
      server.sin_port = htons (PORT);
      server.sin_addr = *((struct in_addr *) host->h_addr);
      bzero (&(server.sin_zero), 8);

      error = connect (handle, (struct sockaddr *) &server,
                       sizeof (struct sockaddr));
      if (error == -1)
        {
          perror ("Connect");
          handle = 0;
        }
    }

  return handle;
}

int kmip_ssl_connect(kmip_connection_t **c)
{

  *c = malloc (sizeof (kmip_connection_t));
  if (c == NULL)
    return -1;
  (*c)->sslHandle = NULL;
  (*c)->sslContext = NULL;

  (*c)->socket = kmip_tcp_connect ();
  if ((*c)->socket)
    {
      SSL_load_error_strings ();

      SSL_library_init ();

      (*c)->sslContext = SSL_CTX_new (TLSv1_client_method ());
      if ((*c)->sslContext == NULL) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (!SSL_CTX_load_verify_locations((*c)->sslContext, "ca/ca.crt", NULL)) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (!SSL_CTX_use_certificate_file((*c)->sslContext, "client/client-cert.pem", SSL_FILETYPE_PEM)) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (!SSL_CTX_use_PrivateKey_file((*c)->sslContext, "client/private/client.key", SSL_FILETYPE_PEM)) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (!SSL_CTX_check_private_key((*c)->sslContext)) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      (*c)->sslHandle = SSL_new ((*c)->sslContext);
      if ((*c)->sslHandle == NULL) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (!SSL_set_fd ((*c)->sslHandle, (*c)->socket)) {
        ERR_print_errors_fp (stderr);
	goto error;
      }

      if (SSL_connect ((*c)->sslHandle) != 1) {
        ERR_print_errors_fp (stderr);
	goto error;
      }
      return 0;
    }
 error:
  perror ("Connect failed");
  return -1;
}


void kmip_ssl_disconnect (kmip_connection_t *c)
{
  if (c->socket)
    close (c->socket);
  if (c->sslHandle)
    {
      SSL_shutdown (c->sslHandle);
      SSL_free (c->sslHandle);
    }
  if (c->sslContext)
    SSL_CTX_free (c->sslContext);

  free (c);
}


int kmip_ssl_read (kmip_connection_t *c, char **rc)
{
  const int readSize = 1024;
  int received, count = 0;
  char buffer[1024];

  if (c)
    {
      while (1)
        {
          if (!*rc)
            *rc = malloc (readSize * sizeof (char) + 1);
          else
            *rc = realloc (*rc, (count + 1) *
                          readSize * sizeof (char) + 1);

          received = SSL_read (c->sslHandle, buffer, readSize);
          buffer[received] = '\0';

          if (received > 0)
            strcat (*rc, buffer);

          if (received < readSize)
            break;
          count++;
        }
    }

  return 0;
}

int kmip_ssl_read_data(kmip_connection_t *c, uint8_t *data, int len)
{
  int received = 0;

  if (c) {
      received = SSL_read (c->sslHandle, data, len);
      if (received < len)
            return -1;
  }

  return received;
}

int kmip_ssl_write (kmip_connection_t *c, char *text)
{
  if (c)
    return SSL_write (c->sslHandle, text, strlen (text));
  return 0;
}

int kmip_ssl_write_data (kmip_connection_t *c, uint8_t *data, int len)
{
  return SSL_write (c->sslHandle, data, len);
}
