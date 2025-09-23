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

//PORTB = PORTB &~(0b0100000000);

int Fila0[]={0,0,0,0,0,0,0,0};
int Fila1[]={0,0,0,0,0,0,0,1};
int Fila2[]={0,0,0,0,0,0,1,1};
int Fila3[]={0,0,0,0,0,1,1,1};
int Fila4[]={0,0,0,0,1,1,1,1};
int Fila5[]={0,0,0,1,1,1,1,1};
int Fila6[]={0,0,1,1,1,1,1,1};
int Fila7[]={0,1,1,1,1,1,1,1};
int Fila8[]={1,1,1,1,1,1,1,1};

int Fila9[]={0,0,0,0,0,0,1,0};
int Fila10[]={0,0,0,0,0,1,0,0};
int Fila11[]={0,0,0,0,1,0,0,0};
int Fila12[]={0,0,0,1,0,0,0,0};
int Fila13[]={0,0,1,0,0,0,0,0};
int Fila14[]={0,1,0,0,0,0,0,0};
int Fila15[]={1,0,0,0,0,0,0,0};

int Fila16[]={1,0,0,0,0,0,0,1};
int Fila17[]={1,1,0,0,0,0,1,1};
int Fila18[]={1,1,1,0,0,1,1,1};
int Fila19[]={1,1,1,1,1,1,1,1};

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

    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila0[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila1[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila9[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila10[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila11[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila11[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila12[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila13[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }
 
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila14[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
  }
 }

  
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila15[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }else{
  digitalWrite(fila[i], LOW);
  delay(1);}
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
    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila0[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

    for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila1[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 //delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila1[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 //delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila2[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
// delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila3[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 // delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila4[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 // delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila5[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 // delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila6[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 // delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila7[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }
 // delay(20);
  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila8[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
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

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila0[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila16[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila17[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila18[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila19[i] == 1){
    digitalWrite(fila[i], HIGH);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila18[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila17[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila16[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }

  for (int t = 0; t < T; t++){
    digitalWrite(columna[7], LOW);
 for (int i = 0; i < 8; i++){
  if(Fila0[i] == 0){
    digitalWrite(fila[i], LOW);
    delay(1);
  }
  }
 }
}
/* 
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
*/
