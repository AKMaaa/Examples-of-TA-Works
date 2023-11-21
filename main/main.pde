Ball[] balls;
int numBalls = 70;

void setup() {
    colorMode(HSB,360,100,100,100);
    size(displayWidth, displayHeight);
    // fullScreen(); 最終的にこの表示に変更する
    background(0);

    balls = new Ball[numBalls];
    for (int i = 0; i < numBalls; i++) {
        float x = 0;
        float y = 0;
        float radius = 10;
        balls[i] = new Ball(x,y,radius,i * PI/12,0);
    }
}

void draw() {
    background(0);
    setBall();
    // moveBall();
    // ball.update();
    // ball.display();
    // ball2.update();
    // ball2.display();
    for (int i = 0; i < numBalls; i++) {
        balls[i].update();
        balls[i].display();
    }
}

//ボールが入り、定位置に行く
void setBall() {
    push();
    translate(width / 2,height / 2);
    float startX = 0;
    float startY = 0;
    float r = 50;
    fill(#ffffff);
    ellipse(startX - 350,startY,r,r);
    ellipse(startX + 350,startY,r,r);
    pop();
}

float i1 = 0;
float i2 = 0;
float px = 0;
float py = 0;
float px2 = 0;
float py2 = 0;
float radius = 400;
float addTcount = 0;
void moveBall() {
    noStroke();
    fill(#ff4500);
    push();
    translate(width / 2,height / 2);
    // for (float i = 0;i < 14 * PI;i += PI / 180) {
    //     px = radius * sin(8 * i / 7) * cos(i);
    //     py = radius * sin(8 * i / 7) * sin(i);
    //     ellipse(px,py,2,2);
// }
    //PI = 右
    //4 * PI = 左
    i1 = PI;
    i2 = 4 * PI;
    px = radius * sin(8 * (i1 + addTcount) / 6) * cos(i1 + addTcount);
    py = radius * sin(8 * (i1 + addTcount) / 6) * sin(i1 + addTcount);
    px2 = radius * sin(8 * (i2 + addTcount) / 6) * cos(i2 + addTcount);
    py2 = radius * sin(8 * (i2 + addTcount) / 6) * sin(i2 + addTcount);
    ellipse(px,py,10,10);
    ellipse(px2,py2,10,10);
    addTcount += 0.01;
    pop();
}

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
    }
    
    void updatePosition() {
        this.x = 400 * sin(8 * (this.i + this.addI) / 6) * cos(this.i + this.addI);
        this.y = 400 * sin(8 * (this.i + this.addI) / 6) * sin(this.i + this.addI);
    }
    
    void display() {
        fill(195,100,100,20);
        noStroke();
        push();
        translate(width / 2,height / 2);
        ellipse(x, y, radius * 2, radius * 2);
        pop();
    }
}
