
Blocks blocks = new Blocks();
ArrayList<Spawner> spawn = new ArrayList<Spawner>();


int columns = 10;


boolean gameover=false;
int score=0;

float maxh ;

void setup() {
  fullScreen(P3D);//size(600,600);
  frameRate(30);

  reset();
}

void reset() {
  float s=(width-100.0)/columns;
  s-=2;
  textSize(100);
  maxh=height-2*s;
  blocks.clear();
  blocks.add(new Block(new PVector(0,height-200),width,777));
  spawn.clear();
  for (int i = 0; i < columns; i++) {
    spawn.add(new Spawner(50+i*(s+2), 150, s));
  }
  
  gameover=false;
  score=0;
}

void draw() {
  background(gameover?color(155, 12, 13):(frameCount|0xff407f40));
  fill(0);
  if(gameover&&frameCount%10<2) fill(255);
  text("Score: "+score+(gameover?"  Try again.":" fr: "+frameRate), 
    50, 100);
   lights();camera();
  for (Spawner s : spawn) {
    s.draw();
    if (!gameover) {

      s.spawn();
      s.move();
    }
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
  if (gameover&&mouseY<200) reset();
}
