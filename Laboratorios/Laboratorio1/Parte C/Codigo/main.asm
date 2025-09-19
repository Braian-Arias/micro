;
; AssemblerApplication14.asm
;
; Created: 19/9/2025 15:28:23
; Author : User
;


; Replace with your application code
.include "m328pdef.inc"

.org 0x0000
    rjmp Inicio
.org OC1Aaddr
    rjmp TIMER1_ISR      ; vector de interrupción Timer1 Compare A

; Variables en SRAM
.dseg
Lutt: .byte 1        ; índice actual en la LUT

.cseg
Inicio:
    ; Inicialización Stack
    ldi r16, high(RAMEND)
    out SPH, r16
    ldi r16, low(RAMEND)
    out SPL, r16

    ; Configurar PORTD como salida
    ldi r16, 0xFF
    out DDRD, r16
    clr r16
    out PORTD, r16

    ; Timer1 en CTC
    ldi r16, high(249)        ; OCR1A = 249 || Fs = 8kHz =(16MHz)/8(249+1)
    sts OCR1AH, r16
    ldi r16, low(249)
    sts OCR1AL, r16

	; Configurar Timer1 en modo CTC con OCR1A
    ldi r16, (1<<WGM12)       ; Modo CTC
    sts TCCR1B, r16
    ; Habilitar interrupción por OCR1A
    ldi r16, (1<<OCIE1A)      ; habilitar interrupción OCR1A
    sts TIMSK1, r16

    ; prescaler = 8
    ldi r16, (1<<CS11)|(1<<WGM12)
    sts TCCR1B, r16

    sei                        ; habilitar interrupciones globales

; Interrupción Timer1 Compare A________________________________________
TIMER1_ISR:
    ; cargar índice actual
	lds r30, Lutt       ; índice
    ldi r31, high(lut<<1)
    ldi r17, low(lut<<1)
    add r30, r17
    adc r31, __zero_reg__
    lpm r16, Z         ; ahora sí lee de la tabla
	out PORTD, r16             ; enviar a DAC (PORTD)

    ; incrementar índice
    lds r30, Lutt
    inc r30
    cpi r30, LUT_SIZE          ; si llegamos al final
    brlo No_Inicio
    ldi r30, 0                 ; volver a inicio
No_Inicio:
    sts Lutt, r30

    reti

; LUT en memoria de programa_____________________________________
.equ LUT_SIZE = 32
lut:
    .db 0x00,0x01,0x02,0x03,0x05,0x07,0x0a,0x0e
    .db 0x13,0x19,0x21,0x2b,0x37,0x46,0x58,0x6d
    .db 0x85,0xa0,0xbf,0xe2,0xff,0xff,0xff,0xff
    .db 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff

