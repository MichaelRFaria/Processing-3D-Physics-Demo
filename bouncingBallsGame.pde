import processing.sound.*;
import queasycam.*;

SoundFile pop, bg_music, win_music, loss_music;
QueasyCam cam;

int ballNum, depth, ballsLeft, timeLeft;
float backgroundColour;
boolean winOrLoss;

Ball[] balls;

void setup() {
  size(900, 900, P3D);
  windowMove(displayWidth/4, 0);
  
  pop = new SoundFile(this,"pop.mp3");
  bg_music = new SoundFile(this,"bg_music.wav");
  win_music = new SoundFile(this,"win_music.wav");
  loss_music = new SoundFile(this,"loss_music.wav");
  bg_music.loop();

  ballNum = ballsLeft = 500;
  timeLeft = int(ballsLeft * 0.6);
  depth = int((width + height) / 2);
  winOrLoss = false;

  cam = new QueasyCam(this);
  cam.speed = 1;
  cam.sensitivity = 1;
  cam.position.add(width/2, height/2, depth/2);

  balls = new Ball[ballNum];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(0, backgroundColour, 0);
  noCursor();

  backgroundColour = map(ballsLeft, ballNum, 0, 0, 255);

  fill(255, 255, 255);
  textSize(64);
  textAlign(CENTER, TOP);

  checkWinCondition();
  checkWallCollision();
  updateTimer();

  pushMatrix();
  stroke(0, 255, 0, 100);
  strokeWeight(10);
  fill(0, 0, 0, 50);
  translate(width/2, height/2, depth/2);
  box(width, height, depth);
  popMatrix();

  for (Ball ball : balls) {
    ball.draw();
  }
}

void checkWallCollision() {
  if (cam.position.x > width) {
    cam.position.sub(cam.speed*5, 0, 0);
  }
  if (cam.position.y > height) {
    cam.position.sub(0, cam.speed*5, 0);
  }
  if (cam.position.z > depth) {
    cam.position.sub(0, 0, cam.speed*5);
  }
  if (cam.position.x < 0) {
    cam.position.add(cam.speed*5, 0, 0);
  }
  if (cam.position.y < 0) {
    cam.position.add(0, cam.speed*5, 0);
  }
  if (cam.position.z < 0) {
    cam.position.add(0, 0, cam.speed*5);
  }
}

void checkWinCondition() {
  if (winOrLoss == false) {
    if (ballsLeft > 0 && timeLeft > 0) {
      text("Balls left : " + ballsLeft, width/2, 0);
      text("Speed : " + int(cam.speed*100) + "%", width/2, 75);
      text("Time left: " + timeLeft + "s", width/2, 150);
    } else if (timeLeft <= 0) {
      text("You lost!", width/2, 0);
      text("Balls left : " + ballsLeft, width/2, 75);
      bg_music.stop();
      loss_music.play();
      winOrLoss = true;
    } else {
      text("You win!", width/2, 0);
      text("with " + timeLeft + "s left", width/2, 75);
      bg_music.stop();
      win_music.play();
      winOrLoss = true;
    }
  }
}

void updateTimer() {
  if (frameCount % 60 == 0) {
    timeLeft--;
  }
}

void popSound() {
  pop.play();
}
