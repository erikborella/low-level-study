print-rax : print-rax.o
	ld -o print-rax print-rax.o
	chmod u+x print-rax

print-rax.o: print-rax.asm
	nasm -felf64 -g print-rax.asm -o print-rax.o
