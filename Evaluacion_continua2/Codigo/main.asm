.include "m328pdef.inc"

.org 0x0000
    rjmp Inicio

Inicio:
    ; Configurar salidas
    ldi r16, 0b11111110   ; PD1..PD7 como salida
    out DDRD, r16

    ldi r17, 0b00000010   ; PB0 y PB1 como salida
    out DDRB, r17

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
    mov r19, r16
    out PORTD, r19

    sbis PINC, PC0    
    rjmp menu_1
    sbis PINC, PC1     
    rjmp menu_2
	RJMP delay
    rjmp main_loop
	
	menu_1:
	mov r18, r19
 
    ldi r16,0b11111100 ;0
    cpi r18, r16
	brne F1
    ldi r16,0b01100000 ;1
	cpi r18, r16
	brne F2
    ldi r16,0b11011010 ;2
	cpi r18, r16
	brne F3
	ldi r16,0b11110010 ;3
    cpi r18, r16
	brne F4
    ldi r16,0b01100110 ;4
	cpi r18, r16
	brne F5
    ldi r16,0b10110110 ;5
	cpi r18, r16
	brne F6
    ldi r16,0b10111110 ;6
    cpi r18, r16
	brne F7
    ldi r16,0b11100000 ;7
	cpi r18, r16
	brne F8
    ldi r16,0b11111110 ;8
	cpi r18, r16
	brne F9
    ldi r16,0b11110110 ;9
	cpi r18, r16
	brne F0
	sbis PINC, PC1
    rjmp main_loop 
	sbis PINC, PC2 
    rjmp main_loop
	rjmp menu_1

    
	menu_2:
	mov r18, r19
 
    ldi r16,0b11111100 ;0
    cpi r18, r16
	brne F9
    ldi r16,0b01100000 ;1
	cpi r18, r16
	brne F0
    ldi r16,0b11011010 ;2
	cpi r18, r16
	brne F1
	ldi r16,0b11110010 ;3
    cpi r18, r16
	brne F2
    ldi r16,0b01100110 ;4
	cpi r18, r16
	brne F3
    ldi r16,0b10110110 ;5
	cpi r18, r16
	brne F4
    ldi r16,0b10111110 ;6
    cpi r18, r16
	brne F5
    ldi r16,0b11100000 ;7
	cpi r18, r16
	brne F6
    ldi r16,0b11111110 ;8
	cpi r18, r16
	brne F7
    ldi r16,0b11110110 ;9
	cpi r18, r16
	brne F8
	sbis PINC, PC1
    rjmp main_loop 
	sbis PINC, PC2 
    rjmp main_loop
	rjmp menu_2


		F0:
ldi r16,0b11111100  ;0
    out PORTD, r16
	rjmp main_loop

	F1:
ldi r16,0b01100000 ;1
    out PORTD, r16
	rjmp main_loop

	F2:
ldi r16,0b11011010 ;2
    out PORTD, r16
	rjmp main_loop
	F3:
ldi r16,0b11110010 ;3
    out PORTD, r16
	rjmp main_loop
	F4:
ldi r16,0b01100110 ;4
    out PORTD, r16
	rjmp main_loop
	F5:
ldi r16,0b10110110 ;5
    out PORTD, r16
	rjmp main_loop
	F6:
ldi r16,0b10111110 ;6
    out PORTD, r16
	rjmp main_loop
	F7:
ldi r16,0b11100000 ;7
    out PORTD, r16
	rjmp main_loop
	F8:
ldi r16,0b11111110 ;8
    out PORTD, r16
	rjmp main_loop
	F9:
ldi r16,0b11110110 ;9
    out PORTD, r16
	rjmp main_loop

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
