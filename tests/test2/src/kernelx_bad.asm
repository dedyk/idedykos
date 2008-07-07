org 0000h

;wybieramy tryb ekranu
xor ah, ah ;funkcja 0
mov al, 3 ;standardowy tryb tekstowy
int 10h ;jedziemy

lgdt [gdt_descr]
 
mov eax, cr0
or eax, 1
mov cr0, eax

mov ax, 0x10 ; deksryptor danych (8 * 2 = 16 = 0x10)
mov ss, ax
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax

jmp 0x08:start32 ; uzywamy segmentu kodu z GDT
 
[BITS 32]
start32:

reset:


;jmp 0x08:0x10000

gdt:
; NULL Descriptor
dd 0
dd 0
 
; kod, baza: 0, limit: 4GB, DPL: 0
dw 0xFFFF ; mlodsze slowo limitu
dw 0 ; mlodsze slowo bazy
db 0 ; wlodszy bajt starszego slowa bazy
db 10011010b ; kod / exec-read
db 11001111b ; flagi i 4 bity limitu
db 0 ; najstarszy bajt bazy
 
; dane (odczyt/zapis), baza: 0, limit: 4GB, DPL: 0
dw 0xFFFF
dw 0
db 0
db 10010010b
db 11001111b
db 0
gdt_end:
 
; naglowek
gdt_descr:
dw gdt_end - gdt - 1 ; rozmiar gdt
dd gdt ; adres pierwszego deskryptora
