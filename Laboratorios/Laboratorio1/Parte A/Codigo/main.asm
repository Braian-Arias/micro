; AssemblerApplication11.asm
; Created: 13/9/2025 15:12:36
; Author : User
;11-uart matriz -B
.include "m328pdef.inc"
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
; Configurar salidas

   ; motor y punzón salida
    ldi r16, 0x03
    out DDRB, r16          

   ; LEDs salida
    ldi r16, 0x3F
    out DDRC, r16          

   ; botones/sensor entrada
    ldi r16, 0x00
    out DDRD, r16          

    ; Estado inicial
    sbi PORTC, LED_ESPERA
;___________________________________________________________________________________________
; Principal
;___________________________________________________________________________________________
MAIN_LOOP:
    ; Esperar inicio
    sbis PIND, BTN_INICIO
    rjmp MAIN_LOOP

    ; Selección de carga
    sbis PIND, BTN_CARGA1
    rjmp CARGA1
    sbis PIND, BTN_CARGA2
    rjmp CARGA2
    sbis PIND, BTN_CARGA3
    rjmp CARGA3

    rjmp MAIN_LOOP

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
