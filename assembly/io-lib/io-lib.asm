%define WRITE_SYSCALL 1
%define EXIT_SYSCALL 60

%define STDOUT 1

section .data
message: db 'Hello, world!', 10, 0

section .text
global _start

; rdi = código de saida
exit:
  mov rax, EXIT_SYSCALL
  syscall

; ---

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

; ---

; rdi = string
print_string:
  ; obtemos o tamanho da string, resultado em rax
  call string_length

  ; rdx recebe o tamanho da string
  mov rdx, rax
  ; rax recebe o identificador da syscall WRITE
  mov rax, WRITE_SYSCALL
  ; rsi recebe o ponteiro para a string
  mov rsi, rdi
  ; rdi recebe o fd, nesse caso sempre STDOUT
  mov rdi, STDOUT

  syscall
  ret

; ---

print_char:
  ; alocamos 1 byte na stack
  sub rsp, 1
  mov byte[rsp], dil

  mov rax, WRITE_SYSCALL
  mov rdi, STDOUT
  ; Nosso caractere está em *rsp
  mov rsi, rsp
  ; Só vamos imprimir 1 caractere
  mov rdx, 1

  syscall

  ; Desalocamos 1 byte da stack
  add rsp, 1

  ret

; ---

print_newline:
  mov rdi, 10
  call print_char

  ret

; ---

_start:
  mov rdi, 'A'
  call print_char

  xor rdi, rdi
  call exit
