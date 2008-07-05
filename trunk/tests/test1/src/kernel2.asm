org 0000h
 
;ustawiamy stos
mov ax, 07C0h
mov ss, ax ;segment stosu
mov sp, 03FEh ;wierzchołek stosu
 
;wybieramy tryb ekranu
xor ah, ah ;funkcja 0
mov al, 3 ;standardowy tryb tekstowy
int 10h ;jedziemy

;wyświetlamy komunikat
mov ax, welcome ;wskaźnik do tekstu
mov bl, 2 ;na zielono
call write ;wykonujemy procedurze

call newline ; nowa linia
call newline ; nowa linia

mov ax, name ;wskaźnik do tekstu
mov bl, 5 ;na fioletowo
call write ;wykonujemy procedurę

call newline ; nowa linia
call newline ; nowa linia
 
mov ax, last ;wskaźnik do tekstu
mov bl, 2 ;na zielono
call write ;wykonujemy procedurę

mov ax, empty ;wskaźnik do tekstu
mov bl, 00001111b ;na zielono
call write ;wykonujemy procedurę

call newline ; nowa linia

;główna petla
start:
xor ah, ah ;takie xorowanie jest szybsze od mov ah, 0
int 16h ;i w AH mamy scancode, w AL kod ASCII klawisza
cmp al, 1Bh ;porownaj al z 1Bh (kod ASCII klawisza ESC)
je reset ;jeśli równe, skocz do procedury resetowania (napiszemy później)
jmp start ;powracamy na początek

newline:
add dh, 1 ; przesun na nowa linie
xor dl, dl ; ustaw kolumne na 0
mov ah, 2 ; funkcja ustawiania pozycji kursora
int 10h ; wykonaj przerwanie (procedure)

char:
;procedura wyświetla znak i przesuwa kursor
;wejście: al: znak, bl: atrybut
 
push bx ;kładziemy BX na stos, aby na końcu procedury go przywrócić;kładziemy BX na stos, aby na końcu procedury go przywrócić
 
mov ah, 9 ;numer funkcji wyświetlającej znak w miejscu kursora
xor bh, bh ;numer strony ustawiamy na 0
mov cx, 1 ;znak wyświetlimy 1 raz
int 10h ;do dzieła!
 
;pobierz pozycje
mov ah, 3 ;funkcja pobierania pozycji kursora
xor bh, bh ;numer strony (0)
int 10h ;odczytaj pozycje

pop bx ;przywróć poprzedni stan BX
ret ;wyjdź z podprogramu

movecursor:
push bx ;kładziemy BX na stos, aby na końcu procedury go przywrócić;kładziemy BX na stos, aby na końcu procedury go przywrócić
 
;dodaj i zapisz pozycje
add dl, 1 ;dodajemy 1 kolumnie
mov ah, 2 ;funkcja zapisywania
int 10h ;zapisz pozycje

pop bx ;przywróć poprzedni stan BX
ret ;wyjdź z podprogramu
 
write:
;procedura wyświetla tekst na ekranie
;wejście: ax: wskaźnik do tekstu, bl: atrybut
 
mov si, ax ;musimy użyć rejestru segmentowego aby zaadresować wskaźnik
.next: ;początek pętli
mov al, [cs:si] ;zapisz do al wartość aktualnego znaku (patrz parametry dla procedury char)
cmp al, 0 ;porównaj aktualny znak z NULL
je end ;jeśli są rożne, skocz do wyjścia
call char ;jeśli nie, wyświetl znak
call movecursor
add si, 1 ;przesuń się w prawo do następnego znaku
jmp .next ;skocz do początku pętli
end: ;tutaj skoczymy, jeśli wystąpi NULL
ret ;wyjdź z podprogramu
 
reset:
mov bx, 40h ;używamy BX do zapisania wartości w rejestrze segmentowym
mov ds, bx ;BX ładuje w DS
mov word [ds:72h], 1234h ;ustawiamy gorący reset
jmp 0FFFFh:0000h ;skaczemy do FFFF:0000
 
;zmienne
empty: db "",0
welcome: db "Welcome to",0
name: db "*** iDedykOS - test 1 ***",0
last: db 'Press key ESC to restart computer :)',0
