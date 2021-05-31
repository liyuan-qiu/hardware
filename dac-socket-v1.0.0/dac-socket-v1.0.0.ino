#include "WiFi.h"

#define SCLK 14
#define SYNC 12
#define SDI 27
#define LDAC 26
#define RESET 33
#define CLR 25
#define HALFCYCLE 20 // from 1 -> 16383

const char* ssid = "miaomiao";
const char* password =  "13501012312";
 
WiFiServer wifiServer(8888);
 
// Variable to store the socket request
String request="";
long myData;
 
void setup() {
 
  Serial.begin(115200);
 
  delay(1000);
 
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
 
  Serial.println("Connected to the WiFi network");
  Serial.println(WiFi.localIP());
 
  wifiServer.begin();
 
  pinMode(SCLK, OUTPUT);
  pinMode(SYNC, OUTPUT);
  pinMode(SDI, OUTPUT);
  pinMode(LDAC, OUTPUT);
  pinMode(RESET, OUTPUT);
  pinMode(CLR, OUTPUT);
  digitalWrite(RESET, HIGH);
  digitalWrite(SYNC, HIGH); // ready to write data
  digitalWrite(LDAC, HIGH); // ready to load data
  digitalWrite(CLR, HIGH);
  reset();
}
 
void loop() {
 
  WiFiClient client = wifiServer.available();
 
  if (client) {
 
    while (client.connected()) {
 
      while (client.available()>0) {
        char c = client.read();
        if (c == '\n') {
          break;
        }
        request += c;
      }
      if(request.length()!=0) {
        Serial.println(request);
        if (request.indexOf("SET ") >= 0) {
          myData = request.substring(4, request.indexOf('\n')).toInt();
          Serial.print("Set data: ");
          Serial.println(myData);
          if (myData > 0xFFFFFF) {
            reset();
            client.print("dac reset");
          }
          else {
            write_data();
            //load_pulse();
            client.print(request);
          }
        }
        else if (request.indexOf("LOAD ") >= 0) {
          myData = request.substring(5, request.indexOf('\n')).toInt();
          Serial.print("Load data: ");
          Serial.println(myData);
          if (myData == 0) {
            load_pulse();
            client.print("load data");
          }
          else {
            write_data();
            load_pulse();
            client.print(request);
          }
        }
        
        
      }
      request="";
      delay(10);
    }
 
    client.stop();
    Serial.println("Client disconnected");
 
  }
}

void write_data() {
  digitalWrite(SYNC, LOW);
  for(int i=0; i<24; i++) {
    digitalWrite(SCLK, HIGH);
    digitalWrite(SDI, (myData>>(23-i))&1);
    delayMicroseconds(HALFCYCLE);
    digitalWrite(SCLK, LOW);
    delayMicroseconds(HALFCYCLE);
  }
  digitalWrite(SYNC, HIGH);
}

void load_pulse() {
  delayMicroseconds(HALFCYCLE);
  digitalWrite(LDAC, LOW);
  delayMicroseconds(HALFCYCLE);
  digitalWrite(LDAC, HIGH);
}

void reset() {
  digitalWrite(RESET, LOW);
  delayMicroseconds(HALFCYCLE);
  digitalWrite(RESET, HIGH);
  delayMicroseconds(HALFCYCLE);
  myData = 0x00022000; //vref0 ->5V
  write_data();
  delayMicroseconds(HALFCYCLE);
  myData = 0x00032000; //vref1 ->5V
  write_data();
  delayMicroseconds(HALFCYCLE);
  myData=0x00C08000; //set all output to 0
  write_data();
  write_data();
  load_pulse();
}
