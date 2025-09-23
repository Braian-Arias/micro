/* GccApplication1.c
 * Created: 20/9/2025 10:08:38
 * Author : User  */
 
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <stdint.h>

#define LED_PORTD PORTD
#define LED_DDRD  DDRD
#define LED_DELAY 100  

//_________________________________________________________
void pwm_forzado(uint8_t brillo) {
	uint8_t i;
	LED_PORTD = 0xFF;
	for (i = 0; i < 255; i++) {
		if (i >= brillo) LED_PORTD = 0;
		_delay_us(LED_DELAY);
	}
}

//_________________________________________________________
void pwm_fast_init(void) {
	DDRB |= (1 << PB1); // PB1 = OC1A como salida
	TCCR1A = (1 << COM1A1) | (1 << WGM11);
	TCCR1B = (1 << WGM13) | (1 << WGM12) | (1 << CS11); // prescaler = 8
	ICR1 = 1999; // TOP ? 1 kHz
	OCR1A = 0;   // duty inicial
}

//_________________________________________________________
int main(void) {
	LED_DDRD = 0xFF;  // PD como salida (PWM forzado)
	pwm_fast_init();   //  FAST PWM

	uint16_t duty_fast;
	uint8_t brillo_forzado;

	while (1) {
//________________________________________________________________
		for (uint16_t step = 0; step <= 1999; step += 50) {
			duty_fast = 1999 - step;               // FAST PWM baja
			brillo_forzado = step * 255 / 1999;    // Forzado sube

			OCR1A = duty_fast;          //  FAST PWM
			pwm_forzado(brillo_forzado); //  PWM forzado
		}
//________________________________________________________________
		for (uint16_t step = 0; step <= 1999; step += 50) {
			duty_fast = step;                     // FAST PWM sube
			brillo_forzado = 255 - (step * 255 / 1999); // Forzado baja

			OCR1A = duty_fast;
			pwm_forzado(brillo_forzado);
		}
	}
}
