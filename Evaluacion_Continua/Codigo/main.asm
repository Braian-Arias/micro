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

    rjmp LOOP
; Rutina principal
LOOP:
call cara_feliz
call cara_feliz
call cara_feliz
rcall delay
call cara_feliz
call cara_feliz
rcall delay
call cara_feliz
call cara_feliz
call cara_feliz
call cara_feliz
call cara_feliz
call cara_feliz
rcall delay
call cara_feliz
call cara_feliz
rcall delay
call cara_feliz
call cara_feliz
call cara_feliz
call Apagar
rcall delayy

call cara_triste
call cara_triste
rcall delay
call cara_triste
call cara_triste
rcall delay
call cara_triste
call cara_triste
call cara_triste
call cara_triste
call cara_triste
call cara_triste
rcall delay
call cara_triste
call cara_triste
rcall delay
call cara_triste
call cara_triste
call cara_triste
call cara_triste
call Apagar
rcall delayy

call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call rombo
call Apagar
rcall delayy

call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call corazon
call Apagar
rcall delayy

call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call invacion_espacial
call Apagar
rcall delayy

ret

Apagar:
; Apagar todas las columnas___________________________________________
ldi r16, 0b11111100        ; columnas D2–D7 en 1
out PORTD, r16         ; leer estado actual
; Apagar todas las filas______________________________________________
ldi r18, 0b00111111       ; limpiar bits B2..B5 (dejarlos en 0)
out PORTB, r18
ldi r19, 0b00001111        ; PORTC filas en 0
out PORTC, r19
ret

cara_feliz:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00001011          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111100          
out PORTB, r18
; Fila 
ldi r19, 0b00001101          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________
ret



cara_triste:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00001011          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111100          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00001101          
out PORTC, r19
call delay
; ________________________________________________________________________
ret

rombo:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
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
ldi r16, 0b00011000 
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
ldi r18, 0b00110010          
out PORTB, r18
; Fila 
ldi r19, 0b00000011          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b10000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111001          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________
ret


corazon:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
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
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00110000          
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
ldi r19, 0b00000011          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b10000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00110001          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________

ret

invacion_espacial:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00000010         
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000011          
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
ldi r19, 0b00000100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b10000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00011001          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________
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
