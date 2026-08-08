%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
newline_char: db 10
codes: db '0123456789ABCDEF'

section .text
global _start

print_newline:
  mov rax, WRITE_SYSCALL
  mov rdi, STDOUT
  mov rsi, newline_char
  mov rdx, 1  ; bytes a serem escritos
  syscall
  ret

; rdi = valor a ser exibido
print_hex:
  mov rax, rdi

  ; Setup da syscall
  mov rdi, STDOUT
  ; Syscall WRITE vai mostrar apenas um digito por vez
  mov rdx, 1
  ; Deslocador
  mov rcx, 64

  ; cada 4 bits devem ser exibidos como um dígito hexadecimal
  ; Use o deslocalmento (shift) e a operação bit a bit AND para isolá-los
  ; o resultado é o offset no array 'codes'
.iterate:
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
  jnz .iterate

  ret

_start:
  mov rdi, 0x0123456789ABCDEF
  call print_hex
  call print_newline

  mov rax, EXIT_SYSCALL
  xor rdi, rdi
  syscall

