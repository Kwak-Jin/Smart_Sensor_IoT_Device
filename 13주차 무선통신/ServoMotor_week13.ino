#include <Servo.h>
#include <ESP8266WiFi.h>

#define left 0
#define right 180
#define center 90
#define attch D0
const char* ssid= "Mschool" ;
const char* password = "Mschool123";
Servo servo;

WiFiServer server(80); 

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);
  delay(10);
  while (WiFi.status() != WL_CONNECTED) { //Wifi 접속까지
      delay(500); 
      Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connecting to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
  Serial.println("Server started");
  servo.attach(attch); //Pin Number
  servo.write(0);  //Set the motor angle to 0
}

void loop() {
  WiFiClient client = server.available();
  // 웹사이트에 접속했을 때
  if(!client) return;
  Serial.println("새로운 클라이언트");
  client.setTimeout(5000);
  // 클라이언트 전송 후 5초 초과 시 타임 아웃
  String request = client.readStringUntil('\r');
  // 전송받은 데이터 즉,URL을 알기 위해 사용
  Serial.println("request: ");
  Serial.println(request);

  client.print("<title>Servo Control Webpage</title>");
  client.print("</head>");
  client.print("<body>");
  client.print("<h2>Servo Control Webpage</h2>");//제목   
  client.print("Servo Status : ");
  if(request.indexOf("/left") != -1) {
    servo.write(left);
    delay(100);
    client.print("Left"); 
  }
  else if(request.indexOf("/right") != -1) {
    servo.write(right);          
    delay(100);
    client.print("Right");
  }
  else if(request.indexOf("\center") != -1){
    servo.write(center);
    delay(100);
    client.print("Center");
  }
  else{
    Serial.println("invalid request");  
    //servo.write(0);
    delay(100);
    // 현재 상태 유지
  }
  while(client.available()) {
    client.read(); // 버퍼 비움 효과
  }
  client.print("HTTP/1.1 200 OK");
  client.print("Content-Type: text/html\r\n\r\n");  // 해더& 구분
  client.print("<!DOCTYPE HTML>");                  //HTML5로 만들어진 문서 선언
  client.print("<html>");
  client.print("<head>"); //
  client.print("<meta&nbsp;charset=\"UTF-8\">");
  client.println("<br>");
  client.println("<br>");
  client.println("<a href='/Left'><button>left </button></a>");
  client.println("<br>"); 
  client.println("<a href='/Center'><button>center </button></a><br />");
  client.print("<br>"); // 줄 바꿈
  client.println("<a href='/Right'><button>right </button></a>");
  client.println("<br>"); 
  client.print("</body>");
  client.print("</html>");
  Serial.println("클라이언트 연결 해제");
}