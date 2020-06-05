
Blocks blocks = new Blocks();
ArrayList<Spawner> spawn = new ArrayList<Spawner>();


int columns = 10;


boolean gameover=false;
int score=0;

float maxh ;

void setup() {
  fullScreen();//size(600,600);
  frameRate(30);

  reset();
}

void reset() {
  float s=(width-100.0)/columns;
  s-=2;
  textSize(100);
  maxh=height-2*s;
  blocks.clear();
  spawn.clear();
  for (int i = 0; i < columns; i++) {
    spawn.add(new Spawner(50+i*(s+2), 150, s));
  }
  gameover=false;
  score=0;
}

void draw() {
  background(gameover?color(255, 12, 13):(frameCount|0xff807f80));
  fill(0);
  text("Score: "+score+(gameover?"  Try again.":" fr: "+frameRate), 
    50, 100);
  if (!gameover) for (Spawner s : spawn) {
    s.draw();
    s.spawn();
    s.move();
  }
  blocks.draw().move();
}

void mousePressed() {
  Something b=blocks.get(new PVector(mouseX, mouseY));
  if (b!=null) {
    int sc=blocks.markContacts(b);
    if (sc>=3) {     
      score+=sc*(sc-2);
      blocks.cleanup();
      return;
    }
  }
  if (gameover) reset();
}
