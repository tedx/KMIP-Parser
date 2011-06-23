
kmip: kmip.c
	gcc -g -o kmip kmip.c

kmip.c: kmip.rl
	ragel -G2 -L -o kmip.c kmip.rl
