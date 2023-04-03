; Self replicating Code
; --------------------------
; Simple Selfreplicating Code als .com -file in 8086 Assembler
; in emu8086 getestet

; Achtung: Dieser Code funktioniert nur als .com File wie erwünscht, 
;          Anderenfalls (in einer .exe) zeigen die Segmentregister auf unterschiedliche Adressen
;          Wodurch der Code nicht mehr wie erwartet funktioniert wird!

org 100h              ;Startpunkt eines COM Files
    mov ax, [main-16]
    mov bx, [void-16]
  
main:
    add ax, 16     
    mov si, ax     
    add bx, 16     
    mov di, bx     
    mov cx, 8     
    nop            
    rep movsw      
void:
