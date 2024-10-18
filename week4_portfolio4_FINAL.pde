float ballX; // X coordinate of the ball
float ballY; // Y coordinate of the ball
float ballWidth; // diameter of the ball
float speedX; // speed of movement in X direction
float speedY; // speed of movement in Y direction
float holeX, holeY, holeWidth;
void setup() {
  size(600, 600);
  // reset ball parameters, position and size
  ballX = 10;
  ballY = height/2;
  ballWidth = 60;
  // initialize the speed to random values
  initializeSpeed () ;
  initializeHole();
}
void draw() {
  background(127);
  // draw the ball
  drawColourCircle(ballX, ballY, ballWidth, (color(255, 0, 0))) ;
  drawColourCircle(holeX, holeY, holeWidth, color(0)); // draw black hole
  // move the ball
  moveBall();

  // check if red ball colides with hole and print line
  if (checkCollide(ballX, ballY, ballWidth, holeX, holeY, holeWidth)) {
    initializeHole();
    initializeSpeed();
    println("It Works!");
  }
  
  // bounce the ball ( if necessary)
  bounceBall();
}

void initializeSpeed() {
  // sets speed between 5, 10
  speedX = random(5, 10);
  speedY = random(5, 10);
}

void drawColourCircle(float bX, float bY, float bW, color colour) {
  // colour and draw circle from parameters
  fill(colour);
  circle(bX, bY, bW);
}

void moveBall() {
  // adds variables speedX and speedY to circle coordinates
  ballX += speedX;
  ballY += speedY;

  if (ballX < ballWidth / 2) {
    ballX = ballWidth / 2; // puts circle in correct position
  } else if (ballX > width - ballWidth / 2) {
    ballX = width - ballWidth / 2; // puts circle in correct position
  }

  // constrains Y coordinates between 0 and height
  if (ballY < ballWidth / 2) {
    ballY = ballWidth / 2; // Correct position
  } else if (ballY > height - ballWidth / 2) {
    ballY = height - ballWidth / 2; // Correct position
  }
}

void bounceBall() {
  // check if touching left or right, negate speedX
  if (ballX <= ballWidth / 2 || ballX >= width - ballWidth / 2) {
    speedX = speedX * -1;
  }
  // check if touching top or bottom, negate speedY
  if (ballY <= ballWidth / 2 || ballY >= height - ballWidth / 2) {
    speedY = speedY * -1;
  }
}

void keyPressed() {
  // when x is pressed, assign speedX random int between 5, 10
  if (key == 'x') {
    speedX = random(5, 10);
  println(speedX + " \n");
  }
  // when x is pressed, assign speedy random int between 5, 10
  if (key == 'y') {
    speedY = random(5, 10);
    // println(speedY + " \n");
  }
  // println("SpeedX: " + speedX + "\n" + "SpeedY: " + speedY);
}

void initializeHole() {
  // random int between 0 and width or height of canvas for black hole position
  holeX = random(0, width);
  holeY = random(0, height);
  // random int between 100 and 300 for black hole size
  holeWidth = random(100, 300);
}

float distance(float x1, float y1, float x2, float y2) {
  // calculate the differences between each side 
  float side1 = x1 - x2;
  float side2 = y1 - y2;

  // using sqrt to calculate distance
  float distance = sqrt((side1 * side1) + (side2 * side2));
  return distance;
}

boolean checkCollide(float x1, float y1, float d1, float x2, float y2, float d2) {
  // radius of both circles
  float rad1 = d1/2;
  float rad2 = d2/2;
  
  float centerDist = distance(x1, y1, x2, y2); // distance between circle centers

  return centerDist <= (rad1 + rad2); // return if center distances is less than or equal the sum of radius
}
