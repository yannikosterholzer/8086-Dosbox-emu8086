; Hello World als .com -file in 8086 Assembler
; mit 16-bit nasm in DOSBOX getestet

;   1. Lade Adresse eines Strings über BX
;   2. Hole Zeichen jenes Strings in AL
;   3. Falls AL == 0 -> Programmende
;   4. Gebe ein Zeichen aus
;   5. Inkrementiere BX und wiederhole ab Schritt 2


org 0x0100        ;Startpunkt eines COM Files

start:						
	mov bx, string  

repeat:						
	mov al, [bx]    
	test al, al     ;Pruefe ob EOF
	je end          
	push bx         
	mov ah, 0x0e    ;Lade AH mit Code für Terminal Output
	mov bx, 0x000f  ;BH is page zero, BL is color(graphic mode)
	int 0x10        ;BIOScall fuer Ausgabe eines Zeichens
	pop bx          
	inc bx          ;(naechster Buchstabe)
	jmp repeat      

end:
	int 0x20        ;Call Bios für Exit to command line
string: 
	db "Hello, world",0
