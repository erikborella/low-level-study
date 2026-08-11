strlen : strlen.o
	ld -o strlen strlen.o
	chmod u+x strlen

strlen.o: strlen.asm
	nasm -felf64 -g strlen.asm -o strlen.o
