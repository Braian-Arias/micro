;.include "m328pdef.inc"
.org 0x0000
 rjmp INICIO

INICIO:
    ; Configurar columnas (D2–D7 y B0–B1) como salida
    ldi r16, 0b11111100   ; D2..D7 salida
    out DDRD, r16

    ; Configurar filas (B2–B5 y C0–C3) como salida
    ldi r18, 0b00111111   ; B2..B5 salida + B1 y B2 columna
    out DDRB, r18
    ldi r19, 0b00001111   ; C0..C3 salida
    out DDRC, r19
	ldi r19, (1<<PORTC4)|(1<<PORTC5)
    out PORTC, r19

    ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16

    rjmp adelante

adelante:
Letra_C1:
call Letra_C 
sbis PINC, PC4
call mas
sbis PINC, PC5
call menos
call Letra_C1

mas:
call Letra_espacio
call delayy
call Letra_O1
menos:
call Letra_espacio
call delayy
call Letra_esclamacion1
;________________________________________________________
Letra_O1:
call Letra_O
sbis PINC, PC4
call mas1
sbis PINC, PC5
call menos1
call Letra_O1

mas1:
call Letra_espacio
call delayy
call Letra_C2
menos1:
call Letra_espacio
call delayy
call Letra_C1
;________________________________________________________
Letra_C2:
call Letra_C
sbis PINC, PC4
call mas2
sbis PINC, PC5
call menos2
call Letra_C2

mas2:
call Letra_espacio
call delayy
call Letra_O2
menos2:
call Letra_espacio
call delayy
call Letra_O1
;________________________________________________________
Letra_O2:
call Letra_O
sbis PINC, PC4
call mas3
sbis PINC, PC5
call menos3
call Letra_O2

mas3:
call Letra_espacio
call delayy
call Letra_S1
menos3:
call Letra_espacio
call delayy
call Letra_C2
;________________________________________________________
Letra_S1:
call Letra_S
sbis PINC, PC4
call mas4
sbis PINC, PC5
call menos4
call Letra_S1

mas4:
call Letra_espacio
call delayy
call Letra_espacio1
menos4:
call Letra_espacio
call delayy
call Letra_O2
;________________________________________________________
Letra_espacio1:
call Letra_espacio
sbis PINC, PC4
call mas5
sbis PINC, PC5
call menos5
call Letra_espacio1

mas5:
call Letra_espacio
call delayy
call Letra_L1
menos5:
call Letra_espacio
call delayy
call Letra_S1
;________________________________________________________
Letra_L1:
call Letra_L
sbis PINC, PC4
call mas6
sbis PINC, PC5
call menos6
call Letra_L1

mas6:
call Letra_espacio
call delayy
call Letra_O3
menos6:
call Letra_espacio
call delayy
call Letra_espacio1
;________________________________________________________
Letra_O3:
call Letra_O
sbis PINC, PC4
call mas7
sbis PINC, PC5
call menos7
call Letra_O3

mas7:
call Letra_espacio
call delayy
call Letra_C3
menos7:
call Letra_espacio
call delayy
call Letra_L1
;________________________________________________________
Letra_C3:
call Letra_C
sbis PINC, PC4
call mas8
sbis PINC, PC5
call menos8
call Letra_C3

mas8:
call Letra_espacio
call delayy
call Letra_O4
menos8:
call Letra_espacio
call delayy
call Letra_O3
;________________________________________________________
Letra_O4:
call Letra_O
sbis PINC, PC4
call mas9
sbis PINC, PC5
call menos9
call Letra_O4

mas9:
call Letra_espacio
call delayy
call Letra_S2
menos9:
call Letra_espacio
call delayy
call Letra_C3
;________________________________________________________
Letra_S2:
call Letra_S
sbis PINC, PC4
call mas10
sbis PINC, PC5
call menos10
call Letra_S2

mas10:
call Letra_espacio
call delayy
call Letra_esclamacion1
menos10:
call Letra_espacio
call delayy
call Letra_O4
;________________________________________________________
Letra_esclamacion1:
call Letra_esclamacion
sbis PINC, PC4
call mas11
sbis PINC, PC5
call menos11
call Letra_esclamacion1

mas11:
call Letra_espacio
call delayy
call Letra_C1
menos11:
call Letra_espacio
call delayy
call Letra_S2
;________________________________________________________

;_______________________________________________________________________________________________
Letra_espacio:
; Letra_espacio todas las columnas___________________________________________
call delay
ldi r16, 0b11111100        ; columnas D2–D7 en 1
out PORTD, r16         ; leer estado actual
; Letra_espacio todas las filas______________________________________________
ldi r18, 0b00111111       ; limpiar bits B2..B5 (dejarlos en 0)
out PORTB, r18
ldi r19, 0b00001111        ; PORTC filas en 0
out PORTC, r19
ret

Letra_C:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001100          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100000          
out PORTB, r18
; Fila 
ldi r19, 0b00000001          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000100          
out PORTB, r18
; Fila 
ldi r19, 0b00001000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100110          
out PORTB, r18
; Fila 
ldi r19, 0b00001001          
out PORTC, r19
call delay
;__________________________________________________________
ret

Letra_O:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001100          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100010          
out PORTB, r18
; Fila 
ldi r19, 0b00000001          
out PORTC, r19
call delay
; ________________________________________________________________________
ret

Letra_S:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001000          
out PORTB, r18
; Fila 
ldi r19, 0b00000100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00001000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000100          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100110          
out PORTB, r18
; Fila 
ldi r19, 0b00001001          
out PORTC, r19
call delay
;__________________________________________________________
ret


Letra_L:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b01100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000         
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
ret

Letra_esclamacion:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000100         
out PORTC, r19
call delay
ret

;___________________________________________________________________________
delay:
    ldi  r20, 110
    ldi  r21, 199
L1: dec  r21
    brne L1
    dec  r20
    brne L1
    ret 
;___________________________________________________________________________
delayy:
    ldi  r19, 34
    ldi  r20, 200
    ldi  r21, 199
L2: dec  r21
    brne L2
    dec  r20
    brne L2
	dec  r19
    brne L2
    ret 
