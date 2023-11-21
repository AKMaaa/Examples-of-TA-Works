#include <Servo.h>
Servo servo;

void setup() {
  servo.attach(10); // あなたのサーボモーターのピン番号
  Serial.begin(9600); // シリアル通信の開始
  Serial.println("Serial Test");
  servo.write(90);
}

void loop() {
   if (Serial.available() > 0) {
    char received = Serial.read(); // データの読み込み
    Serial.println(received);
    if (received == '1') {
      // サーボモーターを動かす処理
      servo.write(0); // 例：90度に動かす
    }
   }
}
