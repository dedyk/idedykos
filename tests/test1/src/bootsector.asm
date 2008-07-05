org 7C00h
 
start:
mov ah, 2
mov al, 10
mov ch, 0
mov cl, 2
mov dh, 0
mov bx, 0800h
mov es, bx
xor bx, bx
int 13h
 
jmp 0800h:0000h
 
times 510 - ($ - start) db 0
 
db 55h
db 0AAh
