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

; rdi -> uint
print_uint:
  ; rcx = indice da string que vamos construir
  mov rcx, rsp
  ; Alocalmos 21 bytes na stack
  ; O máximo de digitos que um u64 tem é 20
  ; + 1 para o caractere de fim de string (0)
  sub rsp, 21

  ; Construimos a string começando com o final, adicionando o fim da string (0)
  dec rcx
  mov byte[rcx], 0

  ; Vamos sempre dividir rax / rdi, o resultado fica salvo novamente em rax
  ; rax = rax / rdi
  ; O resto da divisão vai para rdx
  mov rax, rdi
  mov rdi, 10

.loop:
  ; div combina rdx:rax para dividir um numero grande de 16 bytes
  ; Como o rdx também é onde fica o resto da divisão, precisamos zerar ele antes de dividir novamente
  xor rdx, rdx
  div rdi

  ; rdx vai conter o numero que 'extraimos' de rax
  ; Podemos somar com o ASCII '0' e assim convertemos o numero em sua representação ASCII
  add dl, '0'

  ; Avançamos nosso indice para a proxima posição e movemos o valor ASCII obtido anteriomente para esse nova posição
  dec rcx
  mov byte[rcx], dl

  ; Enquanto rax não for 0, ainda temos numero para contruir a string
  cmp rax, 0
  jne .loop

.end:
  ; rcx agora aponta para a string que construimos e podemos imprimir ela com a syscall WRITE
  mov rdi, rcx
  call print_string

  ; Desalocamos os 21 bytes da stack
  add rsp, 21
  ret

_start:
  mov rdi, 0xabcdef
  call print_uint
  call print_newline

  xor rdi, rdi
  call exit
