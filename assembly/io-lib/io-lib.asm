%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
message: db 'Hello, world!', 10, 0

section .text
global _start

; rdi = código de saida
exit:
  mov RAX, EXIT_SYSCALL
  syscall

; rdi = string
; ret -> rax = tamanho da string
string_length:
  ; rax armazenará o tamanho da string
  xor rax, rax

; Loop de contagem de caracteres não nulo (0)
.loop:

  ; Verifica se a posição atual da string sendo lida é o fim da string (0)
  cmp byte [rdi+rax], 0
  je .end

  ; Continuamos incrementando o indice até achar o fim da string
  inc rax

  jmp .loop

.end:
  ; No fim, a posição que encontramos o fim da string será o tamanho dela
  ret

_start:
  mov rdi, message
  call string_length

  mov rdi, rax
  call exit
