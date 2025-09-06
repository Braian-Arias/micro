;
; AssemblerApplication6.asm
;se empezo el miercoles lo terminamos el sabado a las 17:07
; Created: 5/9/2025 18:04:48 
; Author : User
;
; Replace with your application code
.include "m328pdef.inc"

.org 0x0000
    rjmp Inicio

Inicio:
    ; Configurar salidas
    ldi r16, 0b11111100   ; PD2..PD7 como salida
    out DDRD, r16

    ldi r16, 0b00000011   ; PB0 y PB1 como salida
    out DDRB, r16

	ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16
	
;boton

    ldi r22, 0x00             ; Puerto C como entrada
    out DDRC, r22
    ldi r22, (1<<PORTC0)|(1<<PORTC1)|(1<<PORTC2)|(1<<PORTC3)
    out PORTC, r22
   

main_loop:
    ldi r16, 0b00000000
    out PORTD, r16
	ldi r16, 0b00000000
    out PORTB, r16
    sbis PINC, PC0     ; 2 delay si lo prendes; sin presiona y salta
    rjmp MAIN_1
    sbis PINC, PC1     ; 0 delay si lo prendes ;(sbic) con presiona y salta
    rjmp MAIN_2
    sbis PINC, PC2     ; 2 delay si lo prendes; sin presiona y salta
    rjmp MAIN_3

    rjmp main_loop




MAIN_1:
    ; Encender LED1 (PD2)
    ldi r16, 0b00000100
    out PORTD, r16
    rcall DELAY

    ; Encender LED2 (PD3)
    ldi r16, 0b00001000
    out PORTD, r16
    rcall DELAY

    ; Encender LED3 (PD4)
    ldi r16, 0b00010000
    out PORTD, r16
    rcall DELAY

    ; Encender LED4 (PD5)
    ldi r16, 0b00100000
    out PORTD, r16
    rcall DELAY

    ; Encender LED5 (PD6)
    ldi r16, 0b01000000
    out PORTD, r16
    rcall DELAY

    ; Encender LED6 (PD7)
    ldi r16, 0b10000000
    out PORTD, r16
    rcall DELAY
	ldi r16, 0b00000000
    out PORTD, r16

    ; Encender LED7 (PB0)
    ldi r16, 0b00000001
    out PORTB, r16
    rcall DELAY

    ; Encender LED8 (PB1)
    ldi r16, 0b00000010
    out PORTB, r16
    rcall DELAY
	ldi r16, 0b00000000
    out PORTB, r16
    sbis PINC, PC3 
    rjmp MAIN_loop
    rjmp MAIN_1

;___________________________________________________________________________________________
MAIN_2:
    ; Encender LED1 (PD2)
    ldi r16, 0b00000100
    out PORTD, r16
    rcall DELAY

    ; Encender LED2 (PD3)
    ldi r16, 0b00001100
    out PORTD, r16
    rcall DELAY

    ; Encender LED3 (PD4)
    ldi r16, 0b00011100
    out PORTD, r16
    rcall DELAY

    ; Encender LED4 (PD5)
    ldi r16, 0b00111100
    out PORTD, r16
    rcall DELAY

    ; Encender LED5 (PD6)
    ldi r16, 0b01111100
    out PORTD, r16
    rcall DELAY

    ; Encender LED6 (PD7)
    ldi r16, 0b11111100
    out PORTD, r16
    rcall DELAY

    ; Encender LED7 (PB0)
    ldi r16, 0b00000001
    out PORTB, r16
    rcall DELAY

    ; Encender LED8 (PB1)
    ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY
	ldi r16, 0b00000000
    out PORTB, r16
	ldi r16, 0b00000000
    out PORTD, r16
    rcall DELAY
    sbis PINC, PC3 
    rjmp MAIN_loop
    rjmp MAIN_2

;___________________________________________________________________________________________

MAIN_3:
    ; Encender LED1 (PD2)
    ldi r16, 0b00000100
    out PORTD, r16
	ldi r16, 0b00000010
    out PORTB, r16
    rcall DELAY

    ; Encender LED2 (PD3)
    ldi r16, 0b00001100
    out PORTD, r16
    ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY

    ; Encender LED3 (PD4)
    ldi r16, 0b10011100
    out PORTD, r16
	ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY

    ; Encender LED4 (PD5)
    ldi r16, 0b11111100
    out PORTD, r16
	ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY

    ; Encender LED3 (PD4)
    ldi r16, 0b10011100
    out PORTD, r16
	ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY

	; Encender LED2 (PD3)
    ldi r16, 0b00001100
    out PORTD, r16
    ldi r16, 0b00000011
    out PORTB, r16
    rcall DELAY

	; Encender LED1 (PD2)
    ldi r16, 0b00000100
    out PORTD, r16
	ldi r16, 0b00000010
    out PORTB, r16
    rcall DELAY

		; Encender LED1 (PD2)
    ldi r16, 0b00000000
    out PORTD, r16
	ldi r16, 0b00000000
    out PORTB, r16
    rcall DELAY
    sbis PINC, PC3 
    rjmp MAIN_loop
    rjmp MAIN_3


;-------------------
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
