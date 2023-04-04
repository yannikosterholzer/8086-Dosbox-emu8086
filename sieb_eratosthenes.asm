
		; Sieb des Eratosthenes 
    ; als .com-File in DOSbox getestet
    ; Der nachfolgende Assemblercode implementiert das Sieb des Eratosthenes und gibt alle Primzahlen bis 1000 als Dezimalzahlen aus. 
		; 
		; Dabei erstellt das Programm eine Tabelle von 1000 Einträgen und setzt alle Einträge auf 0. 
    ; Dann beginnt es bei der Zahl 2 und setzt alle Einträge in der Tabelle, die durch 2 teilbar sind, auf 1. 
    ; Dies wird für die nächsten Zahlen, die noch nicht markiert wurden wiederholt, bis alle Zahlen bis 1000 durchgegangen sind. 
    ; Wenn das Programm dabei auf eine unmarkierte Zahl ('0') stößt, gibt es diese Position als Dezimalzahl aus.
    
	org 0x0100  ;Startpunkt eines COM Files
	
 table:		  equ 0x8000
 table_size	  equ 1000
 
start:
	mov bx, table		; 8000 in BX
	mov cx, table_size	; 1000 in CX
	mov al, 0			; 
	
clear_table: 
	mov [bx],al			
	inc bx				
	loop clear_table				
																	
																			
	
	mov ax, 2			; AX = 0x0002
  
check_next_prime: 
        mov bx, table		; BX = 0x8000
	add bx, ax            
	cmp byte [bx], 0      ; Ist [BX] == 0 ?
	jne mark_multiples    ; Falls 0 dann Spring nicht, ansonsten springe mark_multiples: Dabei bedeutet 0, in Feld wurde noch nichts geschrieben
	push ax				
	call display_number 
	mov al, ','         ; Gib Komma aus
	call display_letter  
	pop ax				
	
	mov bx, table		
	add bx, ax			
	
mark_multiple_of_current_prime: 
        add bx, ax			 
	cmp bx, table+table_size 
	jnc mark_multiples              															
	mov byte [bx], 1
	jmp mark_multiple_of_current_prime
  
mark_multiples: 
        inc ax			    
	cmp ax, table_size  
	jne check_next_prime              
	
			 
; BIOS Call - Exit
	int 0x20		
;------------------------------------------------------------------------	
	
	
display_number:
	mov  dx, 0          ; Set up for (DX:AX)/ X Division
	mov  cx, 10	   
	div  cx             ; AX = ((DX:AX) / CX)
	push dx
	cmp  ax, 0
	je   display_number1
	call display_number
display_number1:
	pop  ax
	add  al, '0'
	call display_letter
	ret
		

	                    ; Gebe Zeichen in AL aus
display_letter:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	mov  ah, 0x0e
	mov  bx, 0x000f
	int  0x10
	pop  di
	pop  si
	pop  dx
	pop  cx
	pop  bx
	pop  ax
	ret                 
	
                      ; Lese Keyboard in das Register AL
	
read_keyboard:
	push bx
	push cx
	push dx
	push si
	push di
	mov  ah, 0x00       ; Lade AH mit code um Keyboard zu lesen
	int  0x16
	pop  di
	pop  si
	pop  dx
	pop  cx
	pop  bx
	ret                 
	
	
	
