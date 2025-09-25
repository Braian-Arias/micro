; AssemblerApplication12.asm
; Created: 15/9/2025 20:09:35
; Author : User
;12-uart punzon -A
.include "m328pdef.inc"   
.ORG 0x0000
.equ F_CPU = 16000000
.equ baud = 9600
.equ bps = (F_CPU/16/baud)-1  
RJMP Inicio

Inicio:
  ; Inicializar stack
  ldi r16,HIGH(RAMEND)
  out SPH,r16
  ldi r16,LOW(RAMEND)
  out SPL,r16

  ; Inicializar UART
  rcall uart_init

  ; Mostrar mensaje de bienvenida
  ldi ZL, LOW(mensaje_inicio<<1)
  ldi ZH, HIGH(mensaje_inicio<<1)
  rcall uart_print

  ; Mostrar menú
  ldi ZL, LOW(menu_msg<<1)
  ldi ZH, HIGH(menu_msg<<1)
  rcall uart_print
    ; Mostrar menú1
  ldi ZL, LOW(menu_msg1<<1)
  ldi ZH, HIGH(menu_msg1<<1)
  rcall uart_print
    ; Mostrar menú2
  ldi ZL, LOW(menu_msg2<<1)
  ldi ZH, HIGH(menu_msg2<<1)
  rcall uart_print
    ; Mostrar menú3
  ldi ZL, LOW(menu_msg3<<1)
  ldi ZH, HIGH(menu_msg3<<1)
  rcall uart_print
    ; Mostrar menú4
  ldi ZL, LOW(menu_msg4<<1)
  ldi ZH, HIGH(menu_msg4<<1)
  rcall uart_print
    ; Mostrar menú5
  ldi ZL, LOW(menu_msg5<<1)
  ldi ZH, HIGH(menu_msg5<<1)
  rcall uart_print
main_loop:
  ; Esperar y leer carácter
  rcall uart_rx

  ; Comparar comando recibido
  cpi r16,'1'
  breq cmd1
  cpi r16,'2'
  breq cmd2
  cpi r16,'3'
  breq cmd3
  cpi r16,'+'
  breq cmd_rapido
  cpi r16,'-'
  breq cmd_lento
  rjmp main_loop

;==============================
; Comandos
cmd1:
  ldi ZL, LOW(opcion1_msg<<1)
  ldi ZH, HIGH(opcion1_msg<<1)
  rcall uart_print
  rjmp main_loop

cmd2:
  ldi ZL, LOW(opcion2_msg<<1)
  ldi ZH, HIGH(opcion2_msg<<1)
  rcall uart_print
  rjmp main_loop

cmd3:
  ldi ZL, LOW(opcion3_msg<<1)
  ldi ZH, HIGH(opcion3_msg<<1)
  rcall uart_print
  rjmp main_loop

cmd_rapido:
  ldi ZL, LOW(rapido_msg<<1)
  ldi ZH, HIGH(rapido_msg<<1)
  rcall uart_print
  rjmp main_loop

cmd_lento:
  ldi ZL, LOW(lento_msg<<1)
  ldi ZH, HIGH(lento_msg<<1)
  rcall uart_print
  rjmp main_loop

;==============================
; Mensajes
mensaje_inicio: .db "Bienvenido a la Matriz de LED",0x0D,0x0A,0
menu_msg: .db "Menu:",0x0D,0x0A,0
menu_msg1: .db "1=Msg",0x0D,0x0A,0
menu_msg2: .db "2=Img1",0x0D,0x0A,0,0
menu_msg3: .db "3=Img2",0x0D,0x0A,0,0
menu_msg4: .db "+=Rapido",0x0D,0x0A,0,0
menu_msg5: .db "-=Lento",0x0D,0x0A,0
opcion1_msg: .db "Opcion 1 seleccionada",0x0D,0x0A,0
opcion2_msg: .db "Opcion 2 seleccionada",0x0D,0x0A,0
opcion3_msg: .db "Opcion 3 seleccionada",0x0D,0x0A,0
rapido_msg: .db "Velocidad aumentada",0x0D,0x0A,0
lento_msg: .db "Velocidad disminuida",0x0D,0x0A,0,0

;==============================
; Inicializar UART 9600 8N1
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

;==============================
; Transmitir carácter por UART
uart_tx:
  uart_tx_wait:
    lds r17,UCSR0A
    sbrs r17,UDRE0
    rjmp uart_tx_wait
  sts UDR0,r16
  ret

;==============================
; Recibir carácter por UART
uart_rx:
  uart_rx_wait:
    lds r17,UCSR0A
    sbrs r17,RXC0
    rjmp uart_rx_wait
  lds r16,UDR0
  ret

;==============================
; Transmitir string desde memoria de programa (terminado en 0)
; Z = puntero
uart_print:
  lpm r16,Z+
  cpi r16,0
  breq uart_print_end
  rcall uart_tx
  rjmp uart_print
uart_print_end:
  ret
