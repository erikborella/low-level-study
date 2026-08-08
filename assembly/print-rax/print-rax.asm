%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
codes: db '0123456789ABCDEF'

section .text
global _start

_start:
  ; Número 1122... em formato hexadecimal
  mov rax, 0x1122334455667788

  mov rdi, STDOUT
  ; Syscall WRITE vai mostrar apenas um digito por vez
  mov rdx, 1
  ; Deslocador
  mov rcx, 64

  ; cada 4 bits devem ser exibidos como um dígito hexadecimal
  ; Use o deslocalmento (shift) e a operação bit a bit AND para isolá-los
  ; o resultado é o offset no array 'codes'
.loop:
  push rax
  sub rcx, 4

  ; cl é um registrador, a parte menor de rcx
  ; sar só aceita cl como reg, ou valores imediatos
  sar rax, cl
  and rax, 0xf

  lea rsi, [codes + rax]
  mov rax, WRITE_SYSCALL

  ; Syscall deixa rcx e r11 alterados
  push rcx
  syscall
  pop rcx

  pop rax
  ; test pode ser usado para uma verificação mais rápida do tipo 'é um zero?'
  test rcx, rcx
  jnz .loop

  mov rax, 60
  xor rdi, rdi
  syscall
