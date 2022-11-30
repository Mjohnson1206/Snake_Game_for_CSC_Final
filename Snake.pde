class Snake {
  PVector position;
  PVector velocity;
  ArrayList<PVector> history;
  int leng;
  int moveX = 0;
  int moveY = 0;

  Snake() {
    position = new PVector(0, 0);
    velocity = new PVector();
    history = new ArrayList<PVector>();
    leng = 0;
  }

  void update() {
    history.add(position.copy());
    position.x += velocity.x*gridSize;
    position.y += velocity.y*gridSize;
    moveX = int(velocity.x);
    moveY = int(velocity.y);

    position.x = (position.x + width) % width;
    position.y = (position.y + height) % height;

    if (history.size() > leng) {
      history.remove(0);
    }

    for (PVector p : history) {
      if (p.x == position.x && p.y == position.y) {
        death = true;
        if (leng > highscore) highscore = leng;
      }
    }
  }

  void eat() {
    if (position.x == food.x && position.y == food.y) {
      leng++;
      if (speed > 5) speed--;
      newFood();
      munchSound.play();
    }
  }

  void show() {
    noStroke();
    fill(50, 150, 50);
    rect(position.x, position.y, gridSize, gridSize);
    for (PVector p : history) {
      rect(p.x, p.y, gridSize, gridSize);
    }
  }
}
