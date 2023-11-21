import processing.serial.*;

Serial myPort;

ArrayList<Ball> balls_right;
ArrayList<Ball> balls_left;
int numBalls = 35;

void setup() {
    colorMode(HSB,360,100,100,100);
    //size(displayWidth, displayHeight);
     fullScreen(); 
    background(0);

    balls_right = new ArrayList<Ball>();
    balls_left = new ArrayList<Ball>();
    
    String portName = Serial.list()[0]; // 適切なポートを選択
    myPort = new Serial(this,portName, 9600);
}

void draw() {
    println(frameCount);
    if(setBall_done_flag==false){
    setBall();
    }
    if(setBall_done_flag==true&&moveBall_done_flag==false){
    moveBall();
    }
    if(moveBall_done_flag==true&&docBall_done_flag==false){
      docBall();
    }
    
    fill(0,5);
    noStroke();
    rect(0,0,width,height);
}

float startX1 = 710;
float startY1 = -560;
float startX2 = 630;
float startY2 = -460;
float r = 50;
float addR = 0;
boolean setBall_flag=false;
boolean setBall_done_flag=false;

void setBall() {
    push();
    translate(width / 2,height / 2);
    fill(#ffffff);
    ellipse(startX1 - 350,startY1,r,r);
    fill(#ffffff);
    ellipse(startX2 + 350,startY2,r,r);
    pop();
    if(startX1>=0){
    startX1-=3.8;
    startY1+=3;
    startX2-=3.37;
    startY2+=2.45;
    }
    if(startX1<=0&&setBall_flag==false){
    r=r+cos(addR)-0.75;
    addR+=PI/45;
    if(addR>=PI){
      setBall_flag=true;
      setBall_done_flag=true;
    }
    }
}


boolean moveBall_done_flag=false;

void moveBall() {
    if (frameCount % 30 == 0) {
        float radius = 10;
        balls_right.add(new Ball(0, 0, radius, PI, 0));
        balls_left.add(new Ball(0, 0, radius, 4*PI, 0));
        if (balls_right.size() > numBalls) {
            balls_right.remove(0);
            balls_left.remove(0);
        }
    }

    for (Ball ball : balls_right) {
        ball.update();
        ball.display();
    }
    
        for (Ball ball : balls_left) {
        ball.update();
        ball.display();
    }
    if(frameCount>=1400){
       moveBall_done_flag=true;
    }
}

boolean docBall_done_flag=false;
float doc_r=0;
float doc_x=0;
float doc_y=0;

void docBall(){
    fill(#ffffff);
    push();
    translate(width/2,height/2);
    ellipse(doc_x,doc_y,920+doc_r,920+doc_r);
    pop();
    if(frameCount>=1500&&doc_r>=-870)  {
      doc_r-=3;
    }
    if(frameCount>=1920&&doc_y<=height/2-25){
       doc_y+=4;
    }
    if(frameCount>=2100){
       doc_x-=4;
    }
    if (doc_x<=(-width/2+50)) {
      myPort.write('1'); 
    }
}

//ボールのクラス
class Ball {
    float x,y;    // ボールの位置
    float i;// 角度
    float addI;    // 角度の加算
    float radius;  // ボールの半径
    //コンストラクタ
    Ball(float x, float y, float radius,float i,float addI) {
        this.i = i;
        this.addI = addI;
        this.radius = radius;
        updatePosition();
        //this.x = 400 * sin(8 * (this.i + this.addI) / 6) * cos(this.i + this.addI);
        //this.y = 400 * sin(8 * (this.i + this.addI) / 6) * sin(this.i + this.addI);
    }
    
    void update() {
        addI += 0.01;
        updatePosition();
        if(frameCount>=1300&&frameCount<=1400){
          radius=radius+1;
        }else{
          radius=map(20*sin(frameCount*0.01+addI),0,20,10,18);
        }
    }
    
    void updatePosition() {
        this.x = 400 * sin(8 * (this.i + this.addI) / 6) * cos(this.i + this.addI);
        this.y = 400 * sin(8 * (this.i + this.addI) / 6) * sin(this.i + this.addI);
    }
    
    void display() {
        fill(100,0,100,30);
        noStroke();
        push();
        translate(width / 2,height / 2);
        ellipse(x, y, radius * 2, radius * 2);
        pop();
    }
}
