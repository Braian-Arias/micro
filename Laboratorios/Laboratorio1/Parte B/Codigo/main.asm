; AssemblerApplication12.asm
; Created: 15/9/2025 20:09:35
; Author : User
;11-uart matriz -B
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
     ; Mostrar menú6
  ldi ZL, LOW(menu_msg6<<1)
  ldi ZH, HIGH(menu_msg6<<1)
  rcall uart_print

  init_matriz:
    ; Columnas D2–D7 + B0–B1 salida
    ldi r16, 0b11111100  ; D2..D7 salida
    out DDRD,r16
    ; Filas B2–B5 + C0–C3 salida
    ldi r18, 0b00111111  ; B2..B5 salida + B1 y B2 columna
    out DDRB,r18
    ldi r19, 0b00001111  ; C0..C3 salida
    out DDRC,r19

	ldi r16, HIGH(0x03FF)
    out SPH, r16
    ldi r16, LOW(0x03FF)
    out SPL, r16
;_______________________________________________________________________________
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
  cpi r16,'p'
  breq cmd_palabra
  cpi r16,'+'
  breq cmd_rapido
  cpi r16,'-'
  breq cmd_lento
  rjmp main_loop

;_________________________________________________________________________________________________
; Comandos
cmd1:
  ldi ZL, LOW(opcion1_msg<<1)
  ldi ZH, HIGH(opcion1_msg<<1)
  rcall uart_print
  rcall cara_feliz1
  rjmp main_loop

cmd2:
  ldi ZL, LOW(opcion2_msg<<1)
  ldi ZH, HIGH(opcion2_msg<<1)
  rcall uart_print
  rcall cara_triste1
  rjmp main_loop

cmd3:
  ldi ZL, LOW(opcion3_msg<<1)
  ldi ZH, HIGH(opcion3_msg<<1)
  rcall uart_print
  rcall invacion_espacial1
  rjmp main_loop

cmd_palabra:
  ldi ZL, LOW(palabra_msg<<1)
  ldi ZH, HIGH(palabra_msg<<1)
  rcall uart_print
  rcall adelante
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

;_________________________________________________________________________________________________
; Mensajes
mensaje_inicio: .db "Bienvenido a la Matriz de LED",0x0D,0x0A,0
menu_msg: .db "Menu:",0x0D,0x0A,0
menu_msg1: .db "1=cara feliz",0x0D,0x0A,0,0
menu_msg2: .db "2=cara triste",0x0D,0x0A,0
menu_msg3: .db "3=invacion espacial",0x0D,0x0A,0
menu_msg4: .db "p=Palabra",0x0D,0x0A,0
menu_msg5: .db "+=Rapido",0x0D,0x0A,0,0
menu_msg6: .db "-=Lento",0x0D,0x0A,0
opcion1_msg: .db "Mostrando cara feliz",0x0D,0x0A,0,0
opcion2_msg: .db "Mostrando cara triste",0x0D,0x0A,0
opcion3_msg: .db "Mostrando invacion espacial",0x0D,0x0A,0
palabra_msg: .db "Mostrando Palabra",0x0D,0x0A,0
rapido_msg: .db "Velocidad aumentada",0x0D,0x0A,0
lento_msg: .db "Velocidad disminuida",0x0D,0x0A,0,0

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

;_________________________________________________________________________________________________
; llamado de funcion para que se vea
cara_feliz1:
loop_cara_feliz:
    call cara_feliz     ; refresca la imagen
    rcall delay         ; pequeño retardo
    rcall uart_rx_check ; revisar si hay nueva tecla
    cpi r16,0           ; si no hay nueva tecla, sigue
    breq loop_cara_feliz
    rjmp main_loop      ; si hay nueva tecla, volver al menú

cara_triste1:
loop_cara_triste:
    call cara_triste     ; refresca la imagen
    rcall delay         ; pequeño retardo
    rcall uart_rx_check ; revisar si hay nueva tecla
    cpi r16,0           ; si no hay nueva tecla, sigue
    breq loop_cara_triste
    rjmp main_loop      ; si hay nueva tecla, volver al menú

invacion_espacial1:
loop_invacion_espacial:
    call invacion_espacial   ; refresca la imagen
    rcall delay              ; pequeño retardo
    rcall uart_rx_check      ; revisar si hay nueva tecla
    cpi r16,0                ; si no hay nueva tecla, sigue
    breq loop_invacion_espacial
    rjmp main_loop           ; si hay nueva tecla, volver al menú

;------------------------------------------
; Chequear si hay dato nuevo en UART
; Devuelve en r16: 0 = no hay dato, otro = carácter recibido
uart_rx_check:
    lds r17, UCSR0A
    sbrs r17, RXC0      ; si no hay dato
    rjmp no_data
    lds r16,UDR0        ; si hay dato, lo guarda en r16
    ret
no_data:
    ldi r16,0           ; devuelve 0 si no hay dato
    ret
;_____________________________________________________________________
Apagar:
; Apagar todas las columnas___________________________________________
ldi r16, 0b11111100        ; columnas D2–D7 en 1
out PORTD, r16         ; leer estado actual
; Apagar todas las filas______________________________________________
ldi r18, 0b00111111       ; limpiar bits B2..B5 (dejarlos en 0)
out PORTB, r18
ldi r19, 0b00001111        ; PORTC filas en 0
out PORTC, r19
ret

cara_feliz:
;___________________________________________________________
; Columna ________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00001011          
out PORTC, r19
call delay
; ________________________________
; Columna ________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111100          
out PORTB, r18
; Fila 
ldi r19, 0b00001101          
out PORTC, r19
call delay
; _________________________________
; Columna _________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
ret
; ________________________________________________________________________


cara_triste:
;___________________________________________________________
; Columna ______________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00001011          
out PORTC, r19
call delay
; ______________________________
; Columna ______________________
ldi r16, 0b00011000 
out PORTD, r16                          ; Columnas D2–D7 + B0–B1 salida
; Fila ultimos de columna               ;ldi r16, 0b11111100  ; D2-D7 salida
ldi r18, 0b00111100                     ;out DDRD,r16 
out PORTB, r18                          ; Filas B2–B5 + C0–C3 salida
; Fila                                  ;ldi r18, 0b00111111  ; B2-B5 salida + B1 y B2 columna
ldi r19, 0b00000111                     ;out DDRB,r18
out PORTC, r19                          ; ldi r19, 0b00001111  ; C0-C3 salida
call delay                              ;out DDRC,r19
; ______________________________
; Columna ______________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00001101          
out PORTC, r19
call delay
ret
; ________________________________________________________________________
invacion_espacial:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100100          
out PORTB, r18
; Fila 
ldi r19, 0b00000010         
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000011          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100010          
out PORTB, r18
; Fila 
ldi r19, 0b00000100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b10000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00011001          
out PORTB, r18
; Fila 
ldi r19, 0b00000111          
out PORTC, r19
call delay
; ________________________________________________________________________
ret
;_________________________________________________________________________________________________
;Palabra
adelante:
Letra_C1:
call Letra_C 
sbis PINC, PC4
call mas
sbis PINC, PC5
call menos
call Letra_C1

mas:
call Letra_espacio
call delayy
call Letra_O1
menos:
call Letra_espacio
call delayy
call Letra_esclamacion1
;________________________________________________________
Letra_O1:
call Letra_O
sbis PINC, PC4
call mas1
sbis PINC, PC5
call menos1
call Letra_O1

mas1:
call Letra_espacio
call delayy
call Letra_C2
menos1:
call Letra_espacio
call delayy
call Letra_C1
;________________________________________________________
Letra_C2:
call Letra_C
sbis PINC, PC4
call mas2
sbis PINC, PC5
call menos2
call Letra_C2

mas2:
call Letra_espacio
call delayy
call Letra_O2
menos2:
call Letra_espacio
call delayy
call Letra_O1
;________________________________________________________
Letra_O2:
call Letra_O
sbis PINC, PC4
call mas3
sbis PINC, PC5
call menos3
call Letra_O2

mas3:
call Letra_espacio
call delayy
call Letra_S1
menos3:
call Letra_espacio
call delayy
call Letra_C2
;________________________________________________________
Letra_S1:
call Letra_S
sbis PINC, PC4
call mas4
sbis PINC, PC5
call menos4
call Letra_S1

mas4:
call Letra_espacio
call delayy
call Letra_espacio1
menos4:
call Letra_espacio
call delayy
call Letra_O2
;________________________________________________________
Letra_espacio1:
call Letra_espacio
sbis PINC, PC4
call mas5
sbis PINC, PC5
call menos5
call Letra_espacio1

mas5:
call Letra_espacio
call delayy
call Letra_L1
menos5:
call Letra_espacio
call delayy
call Letra_S1
;________________________________________________________
Letra_L1:
call Letra_L
sbis PINC, PC4
call mas6
sbis PINC, PC5
call menos6
call Letra_L1

mas6:
call Letra_espacio
call delayy
call Letra_O3
menos6:
call Letra_espacio
call delayy
call Letra_espacio1
;________________________________________________________
Letra_O3:
call Letra_O
sbis PINC, PC4
call mas7
sbis PINC, PC5
call menos7
call Letra_O3

mas7:
call Letra_espacio
call delayy
call Letra_C3
menos7:
call Letra_espacio
call delayy
call Letra_L1
;________________________________________________________
Letra_C3:
call Letra_C
sbis PINC, PC4
call mas8
sbis PINC, PC5
call menos8
call Letra_C3

mas8:
call Letra_espacio
call delayy
call Letra_O4
menos8:
call Letra_espacio
call delayy
call Letra_O3
;________________________________________________________
Letra_O4:
call Letra_O
sbis PINC, PC4
call mas9
sbis PINC, PC5
call menos9
call Letra_O4

mas9:
call Letra_espacio
call delayy
call Letra_S2
menos9:
call Letra_espacio
call delayy
call Letra_C3
;________________________________________________________
Letra_S2:
call Letra_S
sbis PINC, PC4
call mas10
sbis PINC, PC5
call menos10
call Letra_S2

mas10:
call Letra_espacio
call delayy
call Letra_esclamacion1
menos10:
call Letra_espacio
call delayy
call Letra_O4
;________________________________________________________
Letra_esclamacion1:
call Letra_esclamacion
sbis PINC, PC4
call mas11
sbis PINC, PC5
call menos11
call Letra_esclamacion1

mas11:
call Letra_espacio
call delayy
call Letra_C1
menos11:
call Letra_espacio
call delayy
call Letra_S2
;________________________________________________________

;_______________________________________________________________________________________________
Letra_espacio:
; Letra_espacio todas las columnas___________________________________________
call delay
ldi r16, 0b11111100        ; columnas D2–D7 en 1
out PORTD, r16         ; leer estado actual
; Letra_espacio todas las filas______________________________________________
ldi r18, 0b00111111       ; limpiar bits B2..B5 (dejarlos en 0)
out PORTB, r18
ldi r19, 0b00001111        ; PORTC filas en 0
out PORTC, r19
ret

Letra_C:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001100          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100000          
out PORTB, r18
; Fila 
ldi r19, 0b00000001          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000100          
out PORTB, r18
; Fila 
ldi r19, 0b00001000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100110          
out PORTB, r18
; Fila 
ldi r19, 0b00001001          
out PORTC, r19
call delay
;__________________________________________________________
ret

Letra_O:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001100          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100010          
out PORTB, r18
; Fila 
ldi r19, 0b00000001          
out PORTC, r19
call delay
; ________________________________________________________________________
ret

Letra_S:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00001000          
out PORTB, r18
; Fila 
ldi r19, 0b00000100          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00001000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00000100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000100          
out PORTB, r18
; Fila 
ldi r19, 0b00000000          
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b01000000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00100110          
out PORTB, r18
; Fila 
ldi r19, 0b00001001          
out PORTC, r19
call delay
;__________________________________________________________
ret


Letra_L:
;___________________________________________________________
; Columna _____________________________________
call delay
ldi r16, 0b01100000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000000         
out PORTC, r19
call delay
; ________________________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011100 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00111110          
out PORTB, r18
; Fila 
ldi r19, 0b00001100          
out PORTC, r19
call delay
ret

Letra_esclamacion:
;___________________________________________________________
; Columna _____________________________________
ldi r16, 0b00011000 
out PORTD, r16         
; Fila ultimos de columna
ldi r18, 0b00000000          
out PORTB, r18
; Fila 
ldi r19, 0b00000100         
out PORTC, r19
call delay
ret

;___________________________________________________________________________
delay:
    ldi  r20, 110
    ldi  r21, 199
L1: dec  r21
    brne L1
    dec  r20
    brne L1
    ret 
;___________________________________________________________________________
delayy:
    ldi  r19, 34
    ldi  r20, 200
    ldi  r21, 199
L2: dec  r21
    brne L2
    dec  r20
    brne L2
	dec  r19
    brne L2
    ret 
