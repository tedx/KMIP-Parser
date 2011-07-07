LIBS = -lssl -lcrypto -lgmp -L/opt/local/lib -lmongoc -lbson
CFLAGS = -pedantic -Wall -Wpointer-arith -Wstrict-prototypes -O2 -ggdb -DMONGO_HAVE_STDINT -Iuthash -I. -I/usr/local/include/mongo-c-driver

kmip_client: kmip.o kmip_client.o kmip_common.o kmip_send.o kmip_read.o kmip_db.o kmip_ssl.o
	gcc $(CFLAGS) $(LIBS) -o $@ $^

kmip.c: kmip.rl kmip-common.rl kmip.h
	ragel -G2 -L -o $@ kmip.rl

kmip.o: kmip.c
	gcc $(CFLAGS) -c $?

kmip_client.o: kmip_client.c
	gcc $(CFLAGS) -c $?

kmip_ssl.o: kmip_ssl.c
	gcc $(CFLAGS) -c $?

kmip_common.o: kmip_common.c
	gcc $(CFLAGS) -c $?

kmip_db.o: kmip_db.c
	gcc $(CFLAGS) -c $?

kmip_send.o: kmip_send.c
	gcc $(CFLAGS) -c $?

kmip_read.o: kmip_read.c
	gcc $(CFLAGS) -c $?

clean:
	rm -f *.o
	rm -f kmip
	rm -f kmip.c