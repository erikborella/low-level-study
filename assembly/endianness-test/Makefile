endianness-test : endianness-test.o
	ld -o endianness-test endianness-test.o
	chmod u+x endianness-test

endianness-test.o: endianness-test.asm
	nasm -felf64 -g endianness-test.asm -o endianness-test.o
