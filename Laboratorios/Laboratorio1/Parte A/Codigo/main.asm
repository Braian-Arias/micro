; AssemblerApplication11.asm
; Created: 13/9/2025 15:12:36
; Author : User
;12-uart punzon -A

.include "m328pdef.inc"
.equ F_CPU = 16000000
.equ baud = 9600
.equ bps = (F_CPU/16/baud)-1 

.equ MOTOR_CINTA = PORTB0
.equ PUNZON      = PORTB1

.equ BTN_INICIO  = PIND2
.equ BTN_CARGA1  = PIND3
.equ BTN_CARGA2  = PIND4
.equ BTN_CARGA3  = PIND5
.equ SENSOR_POS  = PIND6

.equ LED_ESPERA  = PORTC0
.equ LED_FUNCIONA= PORTC1
.equ LED_FIN     = PORTC2
.equ LED_CARGA1  = PORTC3
.equ LED_CARGA2  = PORTC4
.equ LED_CARGA3  = PORTC5
.cseg
.org 0x00
rjmp Inicio

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
  ldi ZL, LOW(menu_msg1<<1)
  ldi ZH, HIGH(menu_msg1<<1)
  rcall uart_print
  ldi ZL, LOW(menu_msg2<<1)
  ldi ZH, HIGH(menu_msg2<<1)
  rcall uart_print
  ldi ZL, LOW(menu_msg3<<1)
  ldi ZH, HIGH(menu_msg3<<1)
  rcall uart_print


  ; Motor cinta en PB0, punzón en PB1 → salidas
  ldi r16, 0b00000011     
  out DDRB, r16           ; PB0 y PB1 como salida

  ; LEDs en PC0..PC5 → salidas
  ldi r16, 0b00111111     
  out DDRC, r16           ; PC0-PC5 como salida

  ; Botones y sensores en PD0..PD7 → entradas
  ldi r16, 0b00000000     
  out DDRD, r16           ; todo D como entrada   

  ; Estado inicial
  sbi PORTC, LED_ESPERA
;___________________________________________________________________________________________
; Principal
;___________________________________________________________________________________________
MAIN_LOOP:
  ; Esperar inicio
  sbis PIND, BTN_INICIO
  rjmp MAIN_LOOP

  main:
  ; Esperar y leer carácter
  rcall uart_rx

  ; Comparar comando recibido
  cpi r16,'1'
  breq cmd1
  cpi r16,'2'
  breq cmd2
  cpi r16,'3'
  breq cmd3

  ; Selección de carga
  sbis PIND, BTN_CARGA1
  rjmp CARGA1
  sbis PIND, BTN_CARGA2
  rjmp CARGA2
  sbis PIND, BTN_CARGA3
  rjmp CARGA3

  rjmp main


;_________________________________________________________________________________________________
; Comandos
cmd1:
  ldi ZL, LOW(opcion1_msg<<1)
  ldi ZH, HIGH(opcion1_msg<<1)
  rcall uart_print
  rjmp CARGA1        ; Ejecutar rutina carga ligera

cmd2:
  ldi ZL, LOW(opcion2_msg<<1)
  ldi ZH, HIGH(opcion2_msg<<1)
  rcall uart_print
  rjmp CARGA2        ; Ejecutar rutina carga media

cmd3:
  ldi ZL, LOW(opcion3_msg<<1)
  ldi ZH, HIGH(opcion3_msg<<1)
  rcall uart_print
  rjmp CARGA3        ; Ejecutar rutina carga pesada

;_________________________________________________________________________________________________
; Mensajes
mensaje_inicio: .db "Bienvenido a la Punzonadora",0x0D,0x0A,0
menu_msg:       .db "Menu:",0x0D,0x0A,0
menu_msg1:      .db "1 = Carga ligera",0x0D,0x0A,0,0
menu_msg2:      .db "2 = Carga media",0x0D,0x0A,0
menu_msg3:      .db "3 = Carga pesada",0x0D,0x0A,0,0
opcion1_msg:    .db "Opcion 1: Carga ligera seleccionada",0x0D,0x0A,0
opcion2_msg:    .db "Opcion 2: Carga media seleccionada",0x0D,0x0A,0,0
opcion3_msg:    .db "Opcion 3: Carga pesada seleccionada",0x0D,0x0A,0

;_________________________________________________________________________________________________
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

;_________________________________________________________________________________________________
; Transmitir carácter por UART
uart_tx:
  uart_tx_wait:
    lds r17,UCSR0A
    sbrs r17,UDRE0
    rjmp uart_tx_wait
  sts UDR0,r16
  ret

;_________________________________________________________________________________________________
; Recibir carácter por UART
uart_rx:
  uart_rx_wait:
    lds r17,UCSR0A
    sbrs r17,RXC0
    rjmp uart_rx_wait
  lds r16,UDR0
  ret

;_________________________________________________________________________________________________
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
;___________________________________________________________________________________________
;Carga ligera
;___________________________________________________________________________________________
CARGA1:
    cbi PORTC, LED_ESPERA
    sbi PORTC, LED_FUNCIONA
    sbi PORTC, LED_CARGA1

;Cinta___________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_3S
    cbi PORTB, MOTOR_CINTA
    rcall RETARDO_2S

    ; Esperar pieza posicionada
WAIT1:
    sbis PIND, SENSOR_POS
    rjmp WAIT1

;Punzon___________________________________
    sbi PORTB, PUNZON       ; bajar
    rcall RETARDO_1S
    rcall RETARDO_2S        ; presión
    cbi PORTB, PUNZON       ; subir
    rcall RETARDO_1S

;Descarga_________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_3S
    cbi PORTB, MOTOR_CINTA

    rcall FIN_CICLO
    rjmp MAIN_LOOP

;___________________________________________________________________________________________
;Carga media
;___________________________________________________________________________________________
CARGA2:
    cbi PORTC, LED_ESPERA
    sbi PORTC, LED_FUNCIONA
    sbi PORTC, LED_CARGA2

;Cinta___________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_4S
    cbi PORTB, MOTOR_CINTA
    rcall RETARDO_2S

WAIT2:
    sbis PIND, SENSOR_POS
    rjmp WAIT2

;Punzon___________________________________
    sbi PORTB, PUNZON
    rcall RETARDO_1S
    rcall RETARDO_3S
    cbi PORTB, PUNZON
    rcall RETARDO_1S

;Descarga_________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_4S
    cbi PORTB, MOTOR_CINTA

    rcall FIN_CICLO
    rjmp MAIN_LOOP

;___________________________________________________________________________________________
;Carga pesada
;___________________________________________________________________________________________
CARGA3:
    cbi PORTC, LED_ESPERA
    sbi PORTC, LED_FUNCIONA
    sbi PORTC, LED_CARGA3

;Cinta___________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_5S
    cbi PORTB, MOTOR_CINTA
    rcall RETARDO_3S

WAIT3:
    sbis PIND, SENSOR_POS
    rjmp WAIT3

;Punzon___________________________________
    sbi PORTB, PUNZON
    rcall RETARDO_1S
    rcall RETARDO_4S
    cbi PORTB, PUNZON
    rcall RETARDO_1S

;Descarga__________________________________
    sbi PORTB, MOTOR_CINTA
    rcall RETARDO_5S
    cbi PORTB, MOTOR_CINTA

    rcall FIN_CICLO
    rjmp MAIN_LOOP

;___________________________________________________________________________________________
FIN_CICLO:
    cbi PORTC, LED_FUNCIONA
    sbi PORTC, LED_FIN
    rcall RETARDO_2S
    cbi PORTC, LED_FIN
    sbi PORTC, LED_ESPERA
    ret

;___________________________________________________________________________________________
RETARDO_1S:
    ldi r20, 100
L1: dec r20
    brne L1
    ret

RETARDO_2S:
    rcall RETARDO_1S
    rcall RETARDO_1S
    ret
RETARDO_3S:
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    ret
RETARDO_4S:
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    ret
RETARDO_5S:
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    rcall RETARDO_1S
    ret
