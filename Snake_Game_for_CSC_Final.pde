//setup. Make sure evrything working 
int gridSize = 25; //size of each square snake is going through
PVector food;
int speed = 15;
boolean death = true;
int highscore = 0;
Snake snake;
import processing.sound.*;

PImage brownImg;

PImage[] appleImages = new PImage[5];

Animation appleAnimation;

SoundFile munchSound;
SoundFile background;

void setup() {
  size(700, 700);
  snake = new Snake();
  food = new PVector();
  newFood();
  
   munchSound = new SoundFile(this, "munch.wav");
    munchSound.amp(3.0);
    munchSound.rate(4);
   background = new SoundFile(this, "minecraft.wav");
   background.amp(-1.1);
   
   background.play();

   brownImg = loadImage ("brown.jpeg");
  brownImg.resize (width, height);
  imageMode (CENTER);
  
  for (int i=0; i<appleImages.length; i++) {
  appleImages [i] = loadImage ("apple" + str(i) + ".png");
}

appleAnimation = new Animation(appleImages, 0.2, 3.5);
  appleAnimation.isAnimating = true;
}

void draw() {
  background(42);
  fill(255);
  
   background (brownImg);
  image (brownImg, width/2, height/2);
  
  
  if (!death) {

    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat(); 
    fill(255, 100, 100);
    //rect(food.x, food.y, gridSize, gridSize);
    appleAnimation.display(food.x,food.y);
    appleAnimation.isAnimating = true;
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Score: " + snake.leng, 20, 30);
  } else {
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
  }
}
//time to make some food
void newFood() {
  food.x = floor(random(width));
  food.y = floor(random(height));
  food.x = floor(food.x/gridSize) * gridSize;
  food.y = floor(food.y/gridSize) * gridSize;
}



void mousePressed() {
  if (death) {
    snake = new Snake();
    newFood();
    speed = 15;
    death = false;
  }
}

void keyPressed() {
  if (keyCode == LEFT && snake.moveX != 1) {
    snake.velocity.x = -1;
    snake.velocity.y = 0;
  } else if (keyCode == RIGHT && snake.moveX != -1) {
    snake.velocity.x = 1;
    snake.velocity.y = 0;
  } else if (keyCode == UP && snake.moveY != 1) {
    snake.velocity.y = -1;
    snake.velocity.x = 0;
  } else if (keyCode == DOWN && snake.moveY != -1) {
    snake.velocity.y = 1;
    snake.velocity.x = 0;
  }
}
