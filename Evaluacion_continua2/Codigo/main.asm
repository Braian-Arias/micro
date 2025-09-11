.include "m328pdef.inc"

.org 0x0000
    rjmp Inicio
.org OC1Aaddr
    rjmp TIMER1_ISR 

Inicio:
    ; Configurar salidas
	
	.def dpflag = r23 
    ldi r16, 0b11111111   ; PD1..PD7 como salida
    out DDRD, r16
	; hace q funcione los led
	ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16
	;para los timers, interupciones
	ldi r16, high(15624)   ; 1 s @ 16MHz, prescaler 1024
    sts OCR1AH, r16
    ldi r16, low(15624)
    sts OCR1AL, r16
	; Configurar Timer1 en modo CTC con OCR1A
    ldi r16, (1<<WGM12)        ; Modo CTC
    sts TCCR1B, r16
    ; Habilitar interrupción por OCR1A
    ldi r16, (1<<OCIE1A)
    sts TIMSK1, r16
    ; Prescaler 1024
    ldi r16, (1<<CS12)|(1<<CS10)
    ori r16, (1<<WGM12)        ; aseguramos mantener CTC
    sts TCCR1B, r16

    ; Habilitar interrupciones globales
    sei

;boton

    ldi r22, 0x00             ; Puerto C como entrada
    out DDRC, r22
    ldi r22, (1<<PORTC0)|(1<<PORTC1)|(1<<PORTC2)
    out PORTC, r22
	ldi r16, 0
	
    ; Inicializar registros
    clr r16                ; número actual
    clr dpflag             ; DP apagado

main_loop:
    mov r19, r17
	sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
	out PORTD, r16
    sbis PINC, PC0    
    rjmp menu_1
    sbis PINC, PC1     
    rjmp menu_2
	rcall delay
	rcall delay
    rjmp main_loop
	
	menu_1:
	mov r18, r19
    ldi r16, 0 ;0
    cp r18, r16
	breq N1
    ldi r16, 1 ;1
	cp r18, r16
	breq N2
    ldi r16, 2;2
	cp r18, r16
	breq N3
	ldi r16, 3;3
    cp r18, r16
	breq N4
    ldi r16, 4;4
	cp r18, r16
	breq N5
    ldi r16, 5;5
	cp r18, r16
	breq A6
    ldi r16, 6;6
    cp r18, r16
	breq A7
    ldi r16, 7;7
	cp r18, r16
	breq A8
    ldi r16, 8;8
	cp r18, r16
	breq A9
    ldi r16, 9;9
	cp r18, r16
	breq N0
	rjmp menu_1
N0:ldi r16,0b00111111  ;0
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 0
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N0
N1:ldi r16,0b00000110 ;1
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 1
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N1
N2:ldi r16,0b01011011 ;2
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 2
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N2
N3:ldi r16,0b01001111 ;3
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 3
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N3
N4:ldi r16,0b01100110 ;4
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 4
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N4
A6:breq N6
A7:breq N7
A8:breq N8
A9:breq N9
N5:ldi r16,0b01101101;5
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  5
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N5
N6:ldi r16,0b01111101;6
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  6
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N6
N7:ldi r16,0b00000111;7
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  7
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N7
N8:ldi r16,0b01111111;8
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 8
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N8
N9:ldi r16,0b01101111;9
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  9
	sbis PINC, PC2
    rjmp main_loop 
	rjmp N9

	menu_2:
	mov r18, r19
    ldi r16, 1;1
	cp r18, r16
	breq F0
    ldi r16, 2;2
	cp r18, r16
	breq F1
	ldi r16, 3;3
    cp r18, r16
	breq F2
    ldi r16, 4 ;4
	cp r18, r16
	breq F3
    ldi r16, 5;5
	cp r18, r16
	breq F4
    ldi r16, 6;6
    cp r18, r16
	breq F5
    ldi r16, 7;7
	cp r18, r16
	breq F6
    ldi r16, 8;8
	cp r18, r16
	breq B7
    ldi r16, 9;9
	cp r18, r16
	breq B8
	ldi r16, 0 ;0
    cp r18, r16
	breq B9
	rjmp menu_2
F0:ldi r16,0b00111111  ;0
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 0
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F0
F1:ldi r16,0b00000110 ;1
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 1
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F1
F2:ldi r16,0b01011011 ;2
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 2
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F2
F3:ldi r16,0b01001111 ;3
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 3
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F3
F4:ldi r16,0b01100110 ;4
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 4
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F4
B7:breq F7
B8:breq F8
B9:breq F9
F5:ldi r16,0b01101101;5
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  5
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F5
F6:ldi r16,0b01111101;6
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  6
		sbis PINC, PC2
    rjmp main_loop 
	rjmp F6
F7:ldi r16,0b00000111;7
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  7
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F7
F8:ldi r16,0b01111111;8
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17, 8
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F8
F9:ldi r16,0b01101111;9
    sbrc dpflag, 0         ; si DP encendido
    ori  r16, 0b10000000   ; agregar DP al patrón
    out PORTD, r16
	ldi r17,  9
	sbis PINC, PC2
    rjmp main_loop 
	rjmp F9

	Delay:
    ldi  r19, 234
    ldi  r20, 200
    ldi  r21, 199
L1: dec  r21
    breq L1
    dec  r20
    breq L1
    dec  r19
    breq L1
    ret 

	TIMER1_ISR:
    ldi r16, 1
    eor dpflag, r16        ; alternar bit0 del flag
    reti
