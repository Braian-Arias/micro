.include "m328pdef.inc"
.ORG 0X000

;inicio

ldi r16, 0xFF 
out DDRB, r16 ; pines del puerto B como salidas

ldi r17, 0x01 ; posicion inicial LED

;boton

ldi r18, 0x00             ; Puerto D como entrada
out DDRD, r18

ldi r19, (1<<PORTD3)|(1<<PORTD5)|(1<<PORTD6)  ; boton en PD3 , PD5 y PD6
out PORTD, r19

;___________________________________________________________________________________________

main_loop:
	sbis PIND, PD3     ; 2 delay si lo prendes; sin presiona y salta
    rcall 1_1
	sbis PIND, PD5     ; 0 delay si lo prendes ;(sbic) con presiona y salta
    rcall 1_2
	sbis PIND, PD6     ; 2 delay si lo prendes; sin presiona y salta
    rcall 1_3

	sbis PIND, PD3
    rcall 1_1
	sbis PIND, PD5
    rcall 1_2
	sbis PIND, PD6     ; 2 delay si lo prendes; sin presiona y salta
    rcall 1_3

    rjmp main_loop
;___________________________________________________________________________________________



main1_1 :
	mov r16, r17 ; copiamos la posicion actual del led
	out PORTB, r16 ; encendemos el led en el pin correspondiente

	ldi r18, 0xFF ; valor para el segundo retardo
delayy_1:
	ldi r19, 0xFF ; valor para el primer retardo 
delay_1:
	dec r19 ; disminuir el contador del primer retardo
	brne delay_1 ; repetir hasta que sea 0
	dec r18 ; disminuir el contador del segundo retardo
	brne delayy_1 ; repetir hasta que sea 0

	ldi r16, 0x00 ; apagar todos los LEDs
	out PORTB, r16 ; apagar los pines del puerto B

	lsl r17 ; desplazamos el LED
	cpi r17, 0x00 ; comparamos si llegamos al final del puerto
	brne 1_1; repetimos si no hemos llegado

	ldi r17, 0x01 ; reiniciamos a la primera posicion
	rjmp main1_1 ; volver al bucle principal

;___________________________________________________________________________________________


	main1_2 :
	in r16, PORTB ; leer estado actual del puerto
	or r16, r17 ; encender el led en la pos actual sin apagar los anteriores
	out PORTB, r16 ; actualizar el puerto

	ldi r18, 0xFF ; valor para el segundo retardo
delayy_2:
	ldi r19, 0xFF ; valor para el primer retardo 
delay_2:
	dec r19 ; disminuir el contador del primer retardo
	brne delay_2 ; repetir hasta que sea 0
	dec r18 ; disminuir el contador del segundo retardo
	brne delayy_2 ; repetir hasta que sea 0

	lsl r17 ; desplazamos el LED
	cpi r17, 0x00 ; comparamos si llegamos al final del puerto
	brne 1_2; repetimos si no hemos llegado

	ldi r16, 0x00 ; cargamos el valor 0
	out PORTB, r16 ; apagamos todos los pines

	ldi r17, 0x01 ; reiniciamos a la primera posicion
	rjmp main1_2 ; volver al bucle principal

;___________________________________________________________________________________________

main1_3:
    ; Encender LEDs 1 y 8 (bajar los pines correspondientes)
    ldi r16, 0x7E   ; 0b01111110: LED 1 y LED 8 encendidos (el resto apagado)
    out PORTB, r16  ; Enviamos el valor a PORTD
    rcall delay_3   ; Llamamos a la subrutina delay
    ldi r16, 0xFF   ; Apagamos todos los LEDs (poner todos los pines en 1)
    out PORTB, r16
    rcall delay_3
    
    ; Encender LEDs 2 y 7
    ldi r16, 0xBD   ; 0b10111101: LED 2 y LED 7 encendidos
    out PORTB, r16
    rcall delay_3
    ldi r16, 0xFF   ; Apagamos todos los LEDs
    out PORTB, r16
    rcall delay_3
    
    ; Encender LEDs 3 y 6
    ldi r16, 0xDB   ; 0b11011011: LED 3 y LED 6 encendidos
    out PORTB, r16
    rcall delay_3
    ldi r16, 0xFF   ; Apagamos todos los LEDs
    out PORTB, r16
    rcall delay_3

    ; Encender LEDs 4 y 5
    ldi r16, 0xE7   ; 0b11100111: LED 4 y LED 5 encendidos
    out PORTB, r16
    rcall delay_3
    ldi r16, 0xFF   ; Apagamos todos los LEDs
    out PORTB, r16
    rcall delay_3

    ; Encender LEDs 3 y 6
    ldi r16, 0xDB   ; 0b11011011: LED 3 y LED 6 encendidos
    out PORTB, r16
    rcall delay_3
    ldi r16, 0xFF   ; Apagamos todos los LEDs
    out PORTB, r16
    rcall delay_3

    ; Encender LEDs 2 y 7
    ldi r16, 0xBD   ; 0b10111101: LED 2 y LED 7 encendidos
    out PORTB, r16
    rcall delay_3
    ldi r16, 0xFF   ; Apagamos todos los LEDs
    out PORTB, r16
    rcall delay_3

    ; Encender LEDs 1 y 8 (bajar los pines correspondientes)
    ldi r16, 0x7E   ; 0b01111110: LED 1 y LED 8 encendidos (el resto apagado)
    out PORTB, r16  ; Enviamos el valor a PORTD
    rcall delay_3   ; Llamamos a la subrutina delay
    ldi r16, 0xFF   ; Apagamos todos los LEDs (poner todos los pines en 1)
    out PORTB, r16
    rcall delay_3

    rjmp main1_3  ; Volvemos al bucle principal

delay_3:
	ldi r21, 0x08
	ldi r20, 0xFF
    ldi r19, 0xFF   ; Inicializamos r19 con 0xFF para el contador de retardo
delay_loop:
    dec r19         ; Disminuimos el contador de retardo
    brne delay_loop ; Repetimos hasta que r19 sea 0
    dec r20
	brne delay_loop
	dec r21
	brne delay_loop
	ret             ; Retornamos de la subrutina delay