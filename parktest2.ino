const int trigPin1 = 0;    // Ultrasonic sensor 1 trigger pin
const int echoPin1 = 14;
const int trigPin2 = 5;    // Ultrasonic sensor 2 trigger pin
const int echoPin2 = 4;    // Ultrasonic sensor 2 echo pin
const int trigPin3 = 16;    // Ultrasonic sensor 3 trigger pin
const int echoPin3 = 12;    // Ultrasonic sensor 3 echo pin  // Ultrasonic sensor 3 echo pin
const int trigPin4 = 13;   // Ultrasonic sensor 4 trigger pin
const int echoPin4 = 15;   // Ultrasonic sensor 4 echo pin
#include <Arduino.h>
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#define BUTTON_PIN 4 // Digital pin connected to the pushbutton
int distance1 = 0;

//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert your network credentials
// #define WIFI_SSID "PPC-b2f0"
// #define WIFI_PASSWORD "manikandhan5592"
const char* ssid = "PPC-b2f0";
const char* password = "manikandhan5592";
// Insert Firebase project API Key
#define API_KEY "AIzaSyDCDc81LQDe0hW_HEVxDpVlYdoI8xsIZpE"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "parking-f490f-default-rtdb.firebaseio.com/" 

//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;


void setup() { 
    pinMode(trigPin1, OUTPUT);
  pinMode(echoPin1, INPUT);
  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);
  pinMode(trigPin3, OUTPUT);
  pinMode(echoPin3, INPUT);
  pinMode(trigPin4, OUTPUT);
  pinMode(echoPin4, INPUT);
  Serial.begin(115200);
  pinMode(BUTTON_PIN, INPUT);   // Set the button pin as input7
    Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
    // Trigger the ultrasonic sensor 1
  digitalWrite(trigPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);

  // Measure the duration of the echo pulse
  long duration1 = pulseIn(echoPin1, HIGH);

  // Convert duration to distance in centimeters
  float distance1 = duration1 * 0.034 / 2;
        Serial.println(distance1);
        digitalWrite(trigPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin2, LOW);

  // Measure the duration of the echo pulse
  long duration2 = pulseIn(echoPin2, HIGH);

  // Convert duration to distance in centimeters
  float distance2 = duration2 * 0.034 / 2;
        Serial.println(distance2);

  // Trigger the ultrasonic sensor 3
  digitalWrite(trigPin3, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin3, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin3, LOW);

  // Measure the duration of the echo pulse
  long duration3 = pulseIn(echoPin3, HIGH);

  // Convert duration to distance in centimeters
  float distance3 = duration3 * 0.034 / 2;
        Serial.println(distance3);

  // Trigger the ultrasonic sensor 4
  digitalWrite(trigPin4, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin4, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin4, LOW);

  // Measure the duration of the echo pulse
  long duration4 = pulseIn(echoPin4, HIGH);

  // Convert duration to distance in centimeters
  float distance4 = duration4 * 0.034 / 2;
        Serial.println(distance4);


  // put your main code here, to run repeatedly: if (buttonState == LOW) {     // If button is pressed
  // Small delay to debounce the button
   if(distance1<35){
    
    // Write an Float number on the database path test/float
   
    if (Firebase.RTDB.setString(&fbdo, "/demo/s1","one")){
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
   }
else{
Firebase.RTDB.setString(&fbdo, "/demo/s1","two");

}
 if(distance2<35){
    
    // Write an Float number on the database path test/float
   
    if (Firebase.RTDB.setString(&fbdo, "/demo/s2","one")){
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
   }
else{
Firebase.RTDB.setString(&fbdo, "/demo/s2","two");

}
 if(distance3<35){
    
    // Write an Float number on the database path test/float
   
    if (Firebase.RTDB.setString(&fbdo, "/demo/s3","one")){
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
   }
else{
Firebase.RTDB.setString(&fbdo, "/demo/s3","two");

}
 if(distance4<35){
    
    // Write an Float number on the database path test/float
   
    if (Firebase.RTDB.setString(&fbdo, "/demo/s4","one")){
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
   }
else{
Firebase.RTDB.setString(&fbdo, "/demo/s4","two");

}
}
