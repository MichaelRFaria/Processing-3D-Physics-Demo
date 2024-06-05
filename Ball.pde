class Ball
{
  float x, y, z, dx, dy, dz, size;
  color colour;
  boolean drawBall;
  PVector ballVector;

  Ball() {
    dx = random(-1, 1);
    dy = random(-1, 1);
    dz = random(-1, 1);
    size = random(5, 15);
    x = random(15, width-15);
    y = random(15, height-15);
    z = random(15, depth-15);
    colour = color(random(255), random(255), random(255));
    drawBall = true;
    ballVector = new PVector(x,y,z);
  }

  void draw() {
    if (drawBall) {
      pushMatrix();
      fill(colour,128);
      //stroke(colour);
      noStroke();
      sphereDetail(10);
      translate(x, y, z);
      sphere(size);
      popMatrix();
      
      ballVector.set(x,y,z);

      checkWallCollision();
      checkCamCollision();
      
      x += dx;
      y += dy;
      z += dz;
    }
  }

  void checkWallCollision() {
    if (x >= width - size || x <= 0 + size) {
      dx = -dx;
    } else if (y >= height - size || y <= 0 + size) {
      dy = -dy;
    } else if (z >= depth - size || z <= 0 + size) {
      dz = -dz;
    }
  }

  void checkCamCollision() {
    if (drawBall == true && cam.position.dist(ballVector) < (size * 1.5)) {
      drawBall = false;
      ballsLeft -= 1;
      cam.speed += 0.01;
      timeLeft += 1;
      popSound();
    }
  }
}
