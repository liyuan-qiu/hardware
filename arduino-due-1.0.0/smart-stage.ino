int PUL_pin_h=30;
int DIR_pin_h=31;
int PUL_pin_v=32;
int DIR_pin_v=2;
int x;
int dist;
String number;
char dir;
bool read_number = false;

void setup() {
  // put your setup code here, to run once:
    Serial.begin(115200); //设置串口波特率9600
     pinMode(PUL_pin_h,OUTPUT);
     pinMode(DIR_pin_h,OUTPUT);
     pinMode(PUL_pin_v,OUTPUT);
     pinMode(DIR_pin_v,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0)//串口接收到数据
  {
    char c = Serial.read();//获取串口接收到的数据
    if (c == 'v')
    {
      Serial.println("1.0.0");
    }

    if (read_number) {
      if (c == '\n') {
        read_number = false;
        dist = number.toInt();
        start_motor();
      }
      else {
        number += c;
      }
    }

    if (c=='r' || c=='l' || c=='u' || c=='d') {
      dir = c;
      number = "";
      read_number = true;
    }
    
  }
}

void start_motor()
{
  if (dir == 'r')
    {
      digitalWrite(DIR_pin_h,HIGH);
     for(x=0;x<dist;x++)
     {
     digitalWrite(PUL_pin_h,HIGH);
     delay(5);
     digitalWrite(PUL_pin_h,LOW);
     delay(5); 
      }
      Serial.print("turn ");
      Serial.print(dist);
      Serial.println(" steps in right direction");
    }

    if (dir == 'l')
    {
      digitalWrite(DIR_pin_h,LOW);
     for(x=0;x<dist;x++)
     {
     digitalWrite(PUL_pin_h,HIGH);
     delay(5);
     digitalWrite(PUL_pin_h,LOW);
     delay(5); 
      }
      Serial.print("turn ");
      Serial.print(dist);
      Serial.println(" steps in left direction");
    }

    if (dir == 'u')
    {
      digitalWrite(DIR_pin_v,HIGH);
     for(x=0;x<dist;x++)
     {
     digitalWrite(PUL_pin_v,HIGH);
     delay(5);
     digitalWrite(PUL_pin_v,LOW);
     delay(5); 
      }
      Serial.print("turn ");
      Serial.print(dist);
      Serial.println(" steps in up direction");
    }

    if (dir == 'd')
    {
      digitalWrite(DIR_pin_v,LOW);
     for(x=0;x<dist;x++)
     {
     digitalWrite(PUL_pin_v,HIGH);
     delay(5);
     digitalWrite(PUL_pin_v,LOW);
     delay(5); 
      }
      Serial.print("turn ");
      Serial.print(dist);
      Serial.println(" steps in down direction");
    }
}
