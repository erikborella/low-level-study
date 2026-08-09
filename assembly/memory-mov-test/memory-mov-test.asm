%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
test: dq -1

section .text
global _start

_start:

  ; test = 0xffffffffffffff01
  mov  byte[test], 1

  ; test = 0xffffffffffff0002
  mov  word[test], 2

  ; test = 0xffffffff00000004
  mov dword[test], 4
  
  ; test = 0x0000000000000008
  mov qword[test], 8

  mov rax, EXIT_SYSCALL
  xor rdi, rdi
  syscall
