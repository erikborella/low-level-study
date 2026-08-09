memory-mov-test : memory-mov-test.o
	ld -o memory-mov-test memory-mov-test.o
	chmod u+x memory-mov-test

memory-mov-test.o: memory-mov-test.asm
	nasm -felf64 -g memory-mov-test.asm -o memory-mov-test.o
