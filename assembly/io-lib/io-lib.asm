%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
message: db 'Hello, world!', 10

section .text
global _start

; rdi = código de saida
exit:
  mov RAX, EXIT_SYSCALL
  syscall

_start:

  mov rdi, 7
  call exit
