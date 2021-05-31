//*****************************************//
// ARDUINO UNO control Highfiness current supply //
//Highfiness DAC output analog signal to control the current //

//*****************************************//

//Highfiness RJ45 line 8 grey/white
int latchPin = 8;
//Highfiness RJ45 line 5 bule/white
int clockPin = 12;
//Highfiness RJ45 line 2 orange
int dataPin = 11;
//const byte interruptPin = 2;   // pushbutton connected to digital pin 2
String request="";
long myData;
void bit16DAC( int current) {
digitalWrite(latchPin, HIGH);
// Do this for MSBFIRST serial
//输入电流，转换成可以给16bit DAC的二进制，mA为单位,范围 [-3000,3000]mA
int data=0;
//int current=200;
if (current<0)
{data=current*10*65536/60000+32768;}
else
{data=current*10*65536/60000+32768-1;}

//int data =0b1100000001111111;
int data_high=0b11111111;
int data_mid=data>>8;
int data_low=data;
// shift out highbyte
shiftOut(dataPin, clockPin, MSBFIRST, (data_high));
//shift out midbyte
shiftOut(dataPin, clockPin, MSBFIRST, (data_mid));
// shift out lowbyte
shiftOut(dataPin, clockPin, MSBFIRST, data_low );
digitalWrite(latchPin, LOW);

//// Or do this for LSBFIRST serial
//data = 500;
//// shift out lowbyte
//shiftOut(dataPin, clockPin, LSBFIRST, data);
//// shift out highbyte
//shiftOut(dataPin, clockPin, LSBFIRST, (data >> 8));
}

void setup() {
  //set pins to output because they are addressed in the main loop
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  digitalWrite(latchPin, LOW);
//  pinMode(interruptPin, INPUT_PULLUP);
//  attachInterrupt(digitalPinToInterrupt(interruptPin), setcurrent, CHANGE);
  Serial.begin(9600); // opens serial port, sets data rate to 9600 bps
}


//void setcurrent()
//{
//  if (digitalRead (interruptPin) == HIGH) 
//  {
//    //输入trigger is high电流，转换成可以给16bit DAC的二进制，mA为单位,范围 [-3000,3000]mA
//   int highcurrent=-200;
//    bit16DAC(highcurrent);
//  }
//  else
//  {
//    //输入trigger is low电流，转换成可以给16bit DAC的二进制，mA为单位,范围 [-3000,3000]mA
//    int lowcurrent=100;
//    bit16DAC(lowcurrent);
//  }
//}

void loop() 
{ 
//setcurrent;
  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    request = Serial.readStringUntil('\n');
    if(request.length()!=0){
      if (request.indexOf("SET mA") >= 0){
        myData = request.substring(6, request.indexOf('\n')).toInt();
        // say what you got:
        Serial.print("I received: ");
        Serial.println(myData);
        //输入电流，转换成可以给16bit DAC的二进制，mA为单位,范围 [-3000,3000]mA
        bit16DAC(myData);
        Serial.print("I load data");
        }
      }
      
  }
  delay(1000);
} 
