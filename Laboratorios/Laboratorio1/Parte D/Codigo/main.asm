;
; AssemblerApplication13.asm
;
; Created: 15/9/2025 20:12:35
; Author : User
;


; Replace with your application code
.include "m328pdef.inc"

.org 0x0000
    rjmp Inicio
;___________________________________________________________________________
Inicio:
    ; Configurar salidas
    ldi r16, 0b11111100   ; PD7..PD2 como salida
    out DDRD, r16


;___________________________________________________________________________
main_loop:
call Q
call Centro
;CALL triangulo
;call delay
;call Q;Subir solenoide: ;  D3
call delay
call Izquierda
CALL circulo
call delay
;call Q;Subir solenoide: ;  D3
;call delay
;call Izquierda
;CALL cruz
;call delay

rjmp main_loop

;PRUEBA:
;call Q
;call Centro
;CALL S
;CALL A
;CALL W
;CALL D
;CALL SA
;CALL SD
;CALL WD
;CALL WA
;RJMP PRUEBA
;___________________________________________________________________________
;Pin Digital
;Conexión                           Pin Digital                 
;Bajar solenóide X0                 D2
;Subir solenóide X1                 D3
;Movimiento hacia abajo X5          D4
;Movimiento hacia arriba X6         D5
;Movimiento hacia la izquierda X7   D6
;Movimiento hacia la derecha X10    D7
;___________________________________________________________________________ 
;Comando del plotter
E:
;Bajar solenoide: ;  D2
    ldi r16, 0b00000100
    out PORTD, r16
	call delay
	ret
Q:
;Subir solenoide: ;  D3
    ldi r16, 0b00001000
    out PORTD, r16
	call delay
	ret

WA:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b10100100
    out PORTD, r16
	call delay
	ret
SA:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b10010100
    out PORTD, r16
	call delay
	ret
SD:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b01010100
    out PORTD, r16
	call delay
	ret
WD:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b01100100
    out PORTD, r16
	call delay
	ret
A:
;Movimiento hacia ARRIBA:           ;D4
    ldi r16, 0b10000100
    out PORTD, r16
	call delay
	ret

D:
;Movimiento hacia ABAJO:          ;D5
    ldi r16, 0b01000100
    out PORTD, r16
	call delay
	ret
W:
;Movimiento hacia la izquierda:    ;D6
    ldi r16, 0b00100100
    out PORTD, r16
	call delay
	ret
S:
;Movimiento hacia la derecha:      ;D7  
    ldi r16, 0b00010100
    out PORTD, r16
	call delay
	ret

Centro:
    ldi r16, 0b10011000
    out PORTD, r16
	call delay
    ldi r16, 0b10011000
    out PORTD, r16
	call delay
	ldi r16, 0b10011000
    out PORTD, r16
	call delay
	ret
;___________________________________________________________________________

Izquierda:
CALL Q
	ldi r16, 0b10001000
    out PORTD, r16
	call delay
    ldi r16, 0b10001000
    out PORTD, r16
	call delay
	ret
;___________________________________________________________________________
triangulo:	
    call E
	call SD

	call A
	call A

	call WD
	call Q
	ret
;___________________________________________________________________________	

circulo:
call E
	call A1
	call A1
	call A1
	call A1
	call A1

	call S1
	call A1
	call A1

	call S1
	call A1
	call A1

	call S1
	call A1
	call A1

	call S1
	call A1
	call S1
	call A1
	call S1
	call A1
	call S1
	call A1
	call S1
	call A1

	call S1
	call S1
	call A1

	call S1
	call S1
	call A1

	call S1
	call S1
	call A1
	
	
	;________________1/4
	call S1
	call S1
	call S1
	call S1
	call S1

	call D1
	call S1
	call S1

	call D1
	call S1
	call S1

	call D1
	call S1
	call S1

	call D1
	call S1
	call D1
	call S1
	call D1
	call S1
	call D1
	call S1
	call D1
	call S1

	call D1
	call D1
	call S1

	call D1
	call D1
	call S1

	call D1
	call D1
	call S1
	;________________2/4
	call D1
	call D1
	call D1
	call D1
	call D1

	call W1
	call D1
	call D1

	call W1
	call D1
	call D1

	call W1
	call D1
	call D1


	call W1
	call D1
	call W1
	call D1
	call W1
	call D1
	call W1
	call D1
	call W1
	call D1

	call W1
	call W1
	call D1

	call W1
	call W1
	call D1
	
	call W1
	call W1
	call D1


	;________________3/4
	call W1
	call W1
	call W1
	call W1
	call W1

	call A1
	call W1
	call W1

	call A1
	call W1
	call W1

	call A1
	call W1
	call W1

	call A1
	call W1
	call A1
	call W1
	call A1
	call W1
	call A1
	call W1
	call A1
	call W1

	call A1
	call A1
	call W1

	call A1
	call A1
    call W1

	call A1
	call A1
	call W1
	

call Q
	
	ret
;___________________________________________________________________________
WA1:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b10100100
    out PORTD, r16
	call delayy
	ret
SA1:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b10010100
    out PORTD, r16
	call delayy
	ret
SD1:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b01010100
    out PORTD, r16
	call delayy
	ret
WD1:
;Movimiento hacia abajo:           ;D4
    ldi r16, 0b01100100
    out PORTD, r16
	call delayy
	ret
A1:
;Movimiento hacia ARRIBA:           ;D4
    ldi r16, 0b10000100
    out PORTD, r16
	call delayy
	ret

D1:
;Movimiento hacia ABAJO:          ;D5
    ldi r16, 0b01000100
    out PORTD, r16
	call delayy
	ret
W1:
;Movimiento hacia la izquierda:    ;D6
    ldi r16, 0b00100100
    out PORTD, r16
	call delayy
	ret
S1:
;Movimiento hacia la derecha:      ;D7  
    ldi r16, 0b00010100
    out PORTD, r16
	call delayy
	ret
;___________________________________________________________________________	


	cruz:
	
	call E
	call SA

	call derecha

	call WA

	call E
	ret
;___________________________________________________________________________	
derecha:
CALL Q
    ldi r16, 0b01001000
    out PORTD, r16
	call delay
	CALL E
	ret

;___________________________________________________________________________	
Delay:
    ldi  r19, 134
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
    ldi  r19, 14
    ldi  r20, 200
    ldi  r21, 199
L2: dec  r21
    brne L2
    dec  r20
    brne L2
    dec  r19
    brne L2
    ret 