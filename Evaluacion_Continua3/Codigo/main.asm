;
; AssemblerApplication10.asm
;
; Created: 11/9/2025 10:29:17
; Author : User
;


; Replace with your application code
;
; AssemblerApplication3.asm
;
; Created: 9/3/2024 3:04:47 PM
; Author : Jebus
;

; Segmento de codigo

.org 0x0000
;boton

    ldi r22, 0x00             ; Puerto C como entrada
    out DDRC, r22
    ldi r22, (1<<PORTC0)|(1<<PORTC1) ;A0 y A1
    out PORTC, r22

	ldi r20, 0b11111111
	out DDRD, r20
	;luz
	 ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16

	guardar_codigos:
    ldi r28, 0x00
    ldi r29, 0x01
    ldi r20, 0b10111111 ; 0
    ST Y+, r20
    ldi r20, 0b10000110 ; 1
    ST Y+, r20
    ldi r20, 0b11011011 ; 2
    ST Y+, r20
    ldi r20, 0b11001111 ; 3
    ST Y+, r20
    ldi r20, 0b11100110 ; 4
    ST Y+, r20
    ldi r20, 0b11101101 ; 5
    ST Y+, r20
    ldi r20, 0b11111101 ; 6
    ST Y+, r20
    ldi r20, 0b10000111 ; 7
    ST Y+, r20
    ldi r20, 0b11111111 ; 8
    ST Y+, r20
    ldi r20, 0b11101111 ; 9
    ST Y+, r20

	clr r18          ; contador = 0
stop:
    ; Esperar botón inicio
    sbic PINC, PC1
    rjmp main_loop
	rjmp star

star:
    ; Esperar botón inicio
    sbis PINC, PC0
    rjmp main_loop
	rjmp star

main_loop:
	call get_u
	call set_7seg_u
	rcall Delay
    sbis PINC, PC1 ; Verificar botón de parada (PC1)
    rjmp stop 
	inc r18          ; r16 = r16 + 1
	cpi r18, 10       ; compara
    brlo main_loop        ; si r16 < 10 = seguir
	clr r18          ;en 10 reinicia
	rjmp main_loop

Delay:
    ldi  r19, 15      ; bucle externo
D1: ldi  r20, 255
D2: ldi  r21, 255
D3: dec  r21
    brne D3          ; loop interno
    dec  r20
    brne D2          ; loop medio
    dec  r19
    brne D1          ; loop externo
    ret

get_u:
	mov		r20, r18
	andi	r20, 0x0f
	mov		r1, r20
	ret

set_7seg_u:
	mov		r0, r1
	call	get_7seg_code
	mov		r17, r20
	out		PORTD, r17
	rcall Delay
	ret

get_7seg_code:
	ldi r28,0x00 ;LOW(0x0100)
	ldi r29,0x01 ;HIGH(0x0100)
	add r28,r0
	ld r20, Y
	ret
 