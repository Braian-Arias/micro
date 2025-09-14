.include "m328pdef.inc"
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
	
    ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16
;boton

    ldi r22, 0x00             ; Puerto C como entrada
    out DDRC, r22
    ldi r22, (1<<PORTC4)|(1<<PORTC5) ;A0 y A1
    out PORTC, r22

	ldi r20, 0b11111111
	out DDRD, r20

    rjmp adelante

adelante:
Letra_C
Letra_O
Letra_C
Letra_O
Letra_S
Letra_espacio
Letra_L
Letra_O
Letra_C
Letra_O
Letra_S
Letra_esclamacion

atras:
Letra_esclamacion
Letra_S
Letra_O
Letra_C
Letra_O
Letra_L
Letra_espacio
Letra_S
Letra_O
Letra_C
Letra_O
Letra_C

Letra_espacio:
; Letra_espacio todas las columnas___________________________________________
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
sbic PINC, PC4
call Letra_O
sbic PINC, PC5
call Letra_esclamacion
call Letra_C


Letra_O:
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
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000100          
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