%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
message: db 'Hello, world!', 10

section .text
global _start

_start:
  mov rax, WRITE_SYSCALL
  mov rdi, STDOUT
  mov rsi, message
  mov rdx, 14
  syscall

  mov rax, EXIT_SYSCALL
  xor rdi, rdi
  syscall
