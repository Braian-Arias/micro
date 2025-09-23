#define F_CPU 16000000UL
#include<avr/io.h>
#include<util/delay.h>


void Adelante();
void Atras();
int pinboton1 = 18; 
int pinboton2 = 19; 

int fila[8] = {
  7, 6, 5, 4, 3, 2, 9, 8
};

int columna[8] = {
  13, 12, 11, 10, 17, 16, 15, 14
};

int botonS1 = HIGH;
int botonS2 = HIGH;
//PORTB = PORTB &~(0b0100000000);


int Rombo[][8]={{0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0}};

int Corazon[][8]={{0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 1, 1, 0, 0, 1, 1, 0},
                 {1, 1, 1, 1, 1, 1, 1, 1},
                 {1, 1, 1, 1, 1, 1, 1, 1},
                 {1, 1, 1, 1, 1, 1, 1, 1},
                 {0, 1, 1, 1, 1, 1, 1, 0},
                 {0, 0, 1, 1, 1, 1, 0, 0},
                 {0, 0, 0, 1, 1, 0, 0, 0}};

int Feliz[][8]={{0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 0, 1, 0, 0, 1, 0, 0},
                 {0, 0, 1, 0, 0, 1, 0, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 1, 0, 0, 0, 0, 1, 0},
                 {0, 0, 1, 1, 1, 1, 0, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0}};

int Triste[][8]={{0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 0, 1, 0, 0, 1, 0, 0},
                 {0, 0, 1, 0, 0, 1, 0, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0},
                 {0, 0, 1, 1, 1, 1, 0, 0},
                 {0, 1, 0, 0, 0, 0, 1, 0},
                 {0, 0, 0, 0, 0, 0, 0, 0}};

int Alien[][8]={{0, 0, 0, 1, 1, 0, 0, 0},
                 {0, 1, 1, 1, 1, 1, 1, 0},
                 {1, 1, 1, 1, 1, 1, 1, 1},
                 {1, 1, 0, 1, 1, 0, 1, 1},
                 {1, 1, 1, 1, 1, 1, 1, 1},
                 {0, 0, 1, 0, 0, 1, 0, 0},
                 {0, 1, 0, 1, 1, 0, 1, 0},
                 {1, 0, 0, 0, 0, 0, 0, 1}};

void setup() {
  
  // inicializa los pines como salidas 
  for (int i = 0; i < 8; i++) {
    
    pinMode(columna[i], OUTPUT);
    pinMode(fila[i], OUTPUT);
    
    pinMode(pinboton1, INPUT_PULLUP);
    pinMode(pinboton2, INPUT_PULLUP); 
   //catodo comun  
    digitalWrite(columna[i], HIGH);
    
  }}



void loop(){
 int T;

 for(int w = 0; w < 250; w++){
   if (digitalRead(pinboton1) == 0){
    T = 200;
    w = 0;
    break;
  }else if (digitalRead(pinboton2) == 0){
    T = 50;
    w = 0;
    break;
  }else {
    T = 100; 
    w = 0;
    break;
 }}


  
  for(int t = 0; t < T; t++){
   for (int i=0; i < 8 ; i++){
       digitalWrite(fila[i], HIGH);
      for (int j=0; j < 8 ; j++){
        if (Feliz[i][j] == 1){
          digitalWrite(columna[j], LOW);}
        
      }
    delay(1);
    digitalWrite(fila[i], LOW);
    for (int j=0; j < 8 ; j++){
      digitalWrite(columna[j], HIGH);
    
  }
  }    
  } 
 for(int w = 0; w < 250; w++){
   if (digitalRead(pinboton1) == 0){
    T = 200;
    w = 0;
    break;
  }else if (digitalRead(pinboton2) == 0){
    T = 50;
    w = 0;
    break;
  }else {
    T = 100; 
    w = 0;
    break;
 }}

for(int t = 0; t < T; t++){
   for (int i=0; i < 8 ; i++){
       digitalWrite(fila[i], HIGH);
      for (int j=0; j < 8 ; j++){
        if (Triste[i][j] == 1){
          digitalWrite(columna[j], LOW);}
        
      }
    delay(1);
    digitalWrite(fila[i], LOW);
    for (int j=0; j < 8 ; j++){
      digitalWrite(columna[j], HIGH);
  }
  }  
  }

 for(int w = 0; w < 250; w++){
   if (digitalRead(pinboton1) == 0){
    T = 200;
    w = 0;
    break;
  }else if (digitalRead(pinboton2) == 0){
    T = 50;
    w = 0;
    break;
  }else {
    T = 100; 
    w = 0;
    break;
 }}

for(int t = 0; t < T; t++){
   for (int i=0; i < 8 ; i++){
       digitalWrite(fila[i], HIGH);
      for (int j=0; j < 8 ; j++){
        if (Rombo[i][j] == 1){
          digitalWrite(columna[j], LOW);}
        
      }
    delay(1);
    digitalWrite(fila[i], LOW);
    for (int j=0; j < 8 ; j++){
      digitalWrite(columna[j], HIGH);
  }
  }  
  }

 for(int w = 0; w < 250; w++){
   if (digitalRead(pinboton1) == 0){
    T = 200;
    w = 0;
    break;
  }else if (digitalRead(pinboton2) == 0){
    T = 50;
    w = 0;
    break;
  }else {
    T = 100; 
    w = 0;
    break;
 }}


for(int t = 0; t < T; t++){
   for (int i=0; i < 8 ; i++){
       digitalWrite(fila[i], HIGH);
      for (int j=0; j < 8 ; j++){
        if (Corazon[i][j] == 1){
          digitalWrite(columna[j], LOW);}
        
      }
    delay(1);
    digitalWrite(fila[i], LOW);
    for (int j=0; j < 8 ; j++){
      digitalWrite(columna[j], HIGH);
  }
  }  
  }
 for(int w = 0; w < 250; w++){
   if (digitalRead(pinboton1) == 0){
    T = 200;
    w = 0;
    break;
  }else if (digitalRead(pinboton2) == 0){
    T = 50;
    w = 0;
    break;
  }else {
    T = 100; 
    w = 0;
    break;
 }}

for(int t = 0; t < T; t++){
   for (int i=0; i < 8 ; i++){
       digitalWrite(fila[i], HIGH);
      for (int j=0; j < 8 ; j++){
        if (Alien[i][j] == 1){
          digitalWrite(columna[j], LOW);}
        
      }
    delay(1);
    digitalWrite(fila[i], LOW);
    for (int j=0; j < 8 ; j++){
      digitalWrite(columna[j], HIGH);
  }
  }  
  }
}












