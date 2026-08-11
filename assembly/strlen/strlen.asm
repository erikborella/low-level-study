%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
test_string: db 'abcdef', 0

section .text
global _start

; rdi = string
; ret -> rax = tamanho da string
strlen:
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
  mov rdi, test_string
  call strlen
  mov rdi, rax

  ; Resultado exibido em $? do shell
  mov rax, EXIT_SYSCALL
  syscall
