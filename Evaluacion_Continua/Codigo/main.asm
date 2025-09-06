.include "m328pdef.inc"
.org 0x0000
    rjmp INICIO

;===============================
; Inicialización
;===============================
INICIO:
    ; Configurar columnas (D2–D7 y B0–B1) como salida
    ldi r16, 0b11111100   ; D2..D7 salida
    out DDRD, r16
    ldi r16, 0b00000011   ; B0 y B1 salida
    out DDRB, r16

    ; Configurar filas (B2–B5 y C0–C3) como salida
    ldi r16, 0b00111100   ; B2..B5 salida
    out DDRB, r16
    ldi r16, 0b00001111   ; C0..C3 salida
    out DDRC, r16
	
    ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16

    rjmp LOOP

;===============================
; Rutina principal
;===============================
LOOP:
; Apagar todas las columnas
ldi r16, 0b11111100        ; columnas D2–D7 en 1
out PORTD, r16
in  r17, PORTB             ; leer estado actual
ori r17, 0b00000011        ; poner B0–B1 en 1 sin tocar filas
out PORTB, r17

; Apagar todas las filas
in  r17, PORTB             ; leer PORTB de nuevo
andi r17, 0b11000011       ; limpiar bits B2..B5 (dejarlos en 0)
out PORTB, r17
ldi r16, 0b00001111        ; PORTC filas en 0
out PORTC, r16


111111111111
; Columna 0 en bajo
in  r17, PORTD
andi r17, 0b00000000       ; poner D2 = 0
out PORTD, r17

; Fila 0 en alto
in  r17, PORTB
ori r17, 0b11111011          ; activar fila B2 10
out PORTB, r17
rcall delayy

2222222222222
; Columna 0 en bajo
in  r17, PORTD
andi r17, 0b1000100       ; poner D2 = 0
out PORTD, r17


; Fila 0 en alto
in  r17, PORTB
ori r17, 0b11110111          ; activar fila B2 10
out PORTB, r17
rcall delayy
rjmp loop
;___________________________________________________________________________
Delay:
    ldi  r19, 34
    ldi  r20, 200
    ldi  r21, 199
L1: dec  r21
    brne L1
    dec  r20
    brne L1
    dec  r19
    brne L1
    ret 
Delayy:
    ldi  r19, 4
    ldi  r20, 200
    ldi  r21, 199
L2: dec  r21
    brne L2
    dec  r20
    brne L2
    dec  r19
    brne L2
    ret 