io-lib : io-lib.o
	ld -o io-lib io-lib.o
	chmod u+x io-lib

io-lib.o: io-lib.asm
	nasm -felf64 -g io-lib.asm -o io-lib.o
