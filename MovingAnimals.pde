ArrayList<Animal> animals = new ArrayList<Animal>();

boolean isSizeRandom = false;
String sizeText = "Default";

void setup() {
  size(1000, 1000);
  surface.setResizable(true);
}

void draw() {
  background(0);
  drawAnimals();
  drawText();
}

void keyPressed() {
  if(isSizeRandom == true) {
    if(key == 'p')
      animals.add(0, new Pig());
    if(key == 'g')
      animals.add(0, new Giraffe());
    if(key == 'r')
      animals.add(0, new Rabbit());
  } else {
    if(key == 'p')
      animals.add(0, new Pig(80, 60, 2, 35));
    if(key == 'g')
      animals.add(0, new Giraffe(60, 100, 1, 200));
    if(key == 'r')
      animals.add(0, new Rabbit(40, 60, 4, 50));
  }
  if(key == '0') {
    isSizeRandom = true;
    sizeText = "Random";
  }
  if(key == '1') {
    isSizeRandom = false;
    sizeText = "Default";
  }
}

void drawAnimals() {
  for(Animal a : animals) {
    a.move();
    a.display(); 
  }
  if(animals.size() > 50)
    animals.remove(50);
}

void drawText() {
  textSize(20);
  fill(255);
  text(
    "Press 'p' to spawn in a pig.\n" +
    "Press 'g' to spawn in a giraffe.\n" +
    "Press 'r' to spawn in a rabbit.\n" +
    "Press '1' to choose default size.\n" +
    "Press '0' to randomize the size.\n" +
    "Current selected size is: " + sizeText + '.',
    10, 30);
}

class Animal {
  float posX, posY, dirX, dirY, bodyWidth, bodyHeight, speed;
  color bodyColor;
  
  Animal(int bodyWidth_, int bodyHeight_, color bodyColor_, float speed_) {
    bodyWidth = bodyWidth_;
    bodyHeight = bodyHeight_;
    bodyColor = bodyColor_;
    speed = speed_;
    setRandomMovement();
  }
  
  void setRandomMovement() {
    posX = random(0, width);
    posY = random(0, height);
    dirX = random(-1, 1);
    dirY = random(-1, 1);
    normalizeDirection();
  }
  
  void normalizeDirection() {
    float magnitude_ = sqrt(pow(dirX, 2) + pow(dirY, 2));
    dirX = dirX / magnitude_ * speed;
    dirY = dirY / magnitude_ * speed;
  }
  
  void move() {
    if((posX > width && dirX > 0) || (posX < 0 && dirX < 0)) {
      dirX *= -0.5;
      normalizeDirection();
    }
    if((posY > height && dirY > 0) || (posY < 0 && dirY < 0)) {
      dirY *= -0.5;
      normalizeDirection();
    }
    posX += dirX;
    posY += dirY;
  }
  
  void display() {
    stroke(0);
    fill(bodyColor);
    ellipse(posX, posY, bodyWidth, bodyHeight);
  }
}

class Pig extends Animal {
  float snoutSize;
  
  Pig(int width_, int height_, float speed_, int snout_) {
    super(width_, height_, color(255, 173, 226), speed_);
    snoutSize = snout_;
  }
  
  Pig() {
    this((int)random(60, 100), (int)random(40, 80), random(1, 3), (int)random(10, 50));
  }
  
  void display() {
    super.display();
    ellipse(posX, posY, snoutSize, snoutSize);
  }
}

class Giraffe extends Animal {
  float neckHeight;
  
  Giraffe(int width_, int height_, float speed_, int neck_) {
    super(width_, height_, color(255, 229, 59), speed_);
    neckHeight = neck_;
  }
  
  Giraffe() {
    this((int)random(40, 80), (int)random(80, 120), random(0, 2), (int)random(180, 220));
  }
  
  void display() {
    fill(bodyColor);
    triangle(
      posX - bodyWidth / 4, posY,
      posX + bodyWidth / 4, posY,
      posX                , posY - neckHeight
    );
    ellipse(
      posX         , posY - neckHeight + bodyHeight / 4,
      bodyWidth / 2, bodyHeight / 2
    );
    super.display();
  }
}

class Rabbit extends Animal {
  float earHeight;
  
  Rabbit(int width_, int height_, float speed_, int ear_) {
    super(width_, height_, color(181, 158, 132), speed_);
    earHeight = ear_;
  }
  
  Rabbit() {
    this((int)random(20, 60), (int)random(40, 80), random(3, 4), (int)random(30, 70));
  }
  
  void display() {
    fill(bodyColor);
    ellipse(
      posX - bodyWidth / 3, posY - bodyHeight / 2,
      bodyWidth / 5       , earHeight
    );
    ellipse(
      posX + bodyWidth / 3, posY - bodyHeight / 2,
      bodyWidth / 5       , earHeight
    );
    super.display();
  }
}
