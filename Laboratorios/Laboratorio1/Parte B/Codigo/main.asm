;
; AssemblerApplication11.asm
;
; Created: 13/9/2025 15:12:36
; Author : User
;


; Replace with your application code
.include "m328pdef.inc"   ; Define device
.ORG     0x0000
.equ     F_CPU = 16000000
.equ     baud = 9600 ; baud rate setting
.equ     bps = (F_CPU/16/baud)-1  

Inicio:
; Se inicia el stack pointer
ldi      r16, HIGH(RAMEND)
out      SPH, r16
ldi      r16, LOW(RAMEND)
out      SPL, r16

;configuracion UART
ldi      r16,LOW(bps)
ldi      r17,HIGH(bps)
rcall    initUART

wait:

call     getc
cpi      r16, 0
breq     wait
ldi      r18,1
add      r16,r18  
rcall    putc
ldi      r16,0
rjmp     wait

initUART:
sts      UBRR0L,r16
sts      UBRR0H,r17
ldi      r16,(1<<RXEN0)|(1<<TXEN0)
sts      UCSR0B,r16
ret

putc:
lds      r17,UCSR0A
sbrs     r17,UDRE0
rjmp     putc
sts      UDR0,r16
ldi      r16,0
ret

getc:
lds      r17,UCSR0A
sbrs     r17,UDRE0
rjmp     getc
lds      r16,UDR0
ret

;timer 0
ldi r16, (1<<CS02) | (1<<CS00)
out TCCR0B, r16
ldi r16, 0
out TCNT0, r16