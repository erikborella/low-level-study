print-call : print-call.o
	ld -o print-call print-call.o
	chmod u+x print-call

print-call.o: print-call.asm
	nasm -felf64 -g print-call.asm -o print-call.o
