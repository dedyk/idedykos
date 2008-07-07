;tak jak poprzednio BIOS nasz bootsektor zaladowal pod 0x7C00
[org 0x7C00]
 
; w tybie rzeczywistym uzywamy 16 bitowego kodu
[BITS 16]
start:
; ustawiamy stos dla trybu rzeczywistego
mov ax, 0x1000
mov ss, ax
xor esp, esp
 
; ladujemy jadro pod adres 0x1000
xor ah, ah
int 0x10
 
mov ah, 2
mov al, 10
xor ch, ch
mov cl, 2
mov dh, 0
mov bx, 0x1000
mov es, bx
mov bx, 0
int 0x13

jmp 1000h:0000h
 
times 510 - ($ - start) db 0
 
db 55h
db 0AAh
