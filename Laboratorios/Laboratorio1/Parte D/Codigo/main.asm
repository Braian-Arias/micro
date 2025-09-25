;
; AssemblerApplication13.asm
;
; Created: 15/9/2025 20:12:35
; Author : User
;13-Plotter-D Dibujar-E
.include "m328pdef.inc"

.org 0x0000
RJMP Inicio

;_________________________________________
Inicio:
    ; Inicializar stack
    ldi r16,HIGH(RAMEND)
    out SPH,r16
    ldi r16,LOW(RAMEND)
    out SPL,r16

    ; Inicializar UART
    rcall uart_init

    ; Mostrar mensaje de bienvenida y men�
    ldi ZL, LOW(mensaje_inicio<<1)
    ldi ZH, HIGH(mensaje_inicio<<1)
    rcall uart_print
    rcall mostrar_menu

    ; Configurar salidas
    ldi r16, 0b11111100   ; PD7..PD2 como salida
    out DDRD, r16

main_loop:
    rcall uart_rx   ; Esperar comando desde UART

    ; Comandos del men�
    cpi r16,'1'
    breq dibujar_triangulo
    cpi r16,'2'
    breq dibujar_circulo
    cpi r16,'3'
    breq dibujar_cruz
    cpi r16,'T'
    breq dibujar_todo

    rjmp main_loop

;_________________________________________
dibujar_triangulo:
    rcall triangulo
    rcall mostrar_menu
    rjmp main_loop

dibujar_circulo:
    rcall circulo
    rcall mostrar_menu
    rjmp main_loop

dibujar_cruz:
    rcall cruz
    rcall mostrar_menu
    rjmp main_loop

dibujar_todo:
    rcall triangulo
    rcall circulo
    rcall cruz
    rcall mostrar_menu
    rjmp main_loop

;_________________________________________
; Men� UART
mostrar_menu:
    ldi ZL, LOW(menu_msg<<1)
    ldi ZH, HIGH(menu_msg<<1)
    rcall uart_print
    ldi ZL, LOW(menu_msg1<<1)
    ldi ZH, HIGH(menu_msg1<<1)
    rcall uart_print
    ldi ZL, LOW(menu_msg2<<1)
    ldi ZH, HIGH(menu_msg2<<1)
    rcall uart_print
    ldi ZL, LOW(menu_msg3<<1)
    ldi ZH, HIGH(menu_msg3<<1)
    rcall uart_print
    ldi ZL, LOW(menu_msg4<<1)
    ldi ZH, HIGH(menu_msg4<<1)
    rcall uart_print
    ret

;_________________________________________
; UART (inicializaci�n y env�o/recepci�n)
uart_init:
    ldi r16,HIGH(103)
    sts UBRR0H,r16
    ldi r16,LOW(103)
    sts UBRR0L,r16
    ldi r16,(1<<UCSZ01)|(1<<UCSZ00)
    sts UCSR0C,r16
    ldi r16,(1<<RXEN0)|(1<<TXEN0)
    sts UCSR0B,r16
    ret

uart_tx:
uart_tx_wait:
    lds r17,UCSR0A
    sbrs r17,UDRE0
    rjmp uart_tx_wait
    sts UDR0,r16
    ret

uart_rx:
uart_rx_wait:
    lds r17,UCSR0A
    sbrs r17,RXC0
    rjmp uart_rx_wait
    lds r16,UDR0
    ret

uart_print:
    lpm r16,Z+
    cpi r16,0
    breq uart_print_end
    rcall uart_tx
    rjmp uart_print
uart_print_end:
    ret

;_________________________________________
; Mensajes UART
mensaje_inicio: .db "Bienvenido al Plotter",0x0D,0x0A,0
menu_msg: .db "Menu:",0x0D,0x0A,0
menu_msg1: .db "1=Triangulo",0x0D,0x0A,0
menu_msg2: .db "2=Circulo",0x0D,0x0A,0
menu_msg3: .db "3=Cruz",0x0D,0x0A,0,0
menu_msg4: .db "T=Todo",0x0D,0x0A,0,0


;___________________________________________________________________________
;main_loop:;
;call Q;
;call Centro;
;CALL triangulo
;call delay
;call Q;Subir solenoide: ;  D3
;call delay;
;call Izquierda;
;CALL circulo;
;call delay;
;call Q;Subir solenoide: ;  D3
;call delay
;call Izquierda
;CALL cruz
;call delay

;rjmp main_loop;

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
;Conexi�n                           Pin Digital                 
;Bajar solen�ide X0                 D2
;Subir solen�ide X1                 D3
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