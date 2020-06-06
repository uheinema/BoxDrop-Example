
Blocks blocks = new Blocks();
ArrayList<Spawner> spawn = new ArrayList<Spawner>();


final int columns = 8;
final int types=5;


boolean autoplay=true;

boolean gameover=false;
int score=0;

float maxh ;

boolean blink=false;

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
  blink=(frameCount%20<2);
  if(blink&&gameover)fill(255);
  text("Score: "+score+(gameover?"  Try again.":""),// fr: "+frameRate), 
    50, 100);
   //lights();camera();
  int active=0;
  for (Spawner s : spawn) {
    s.draw();
    if (!gameover) {
      if(s.spawn()){
         active++;       
      }
      s.move();
    }
  }
  if(active==0) gameover=true;
  else score++;
  blocks.draw().move();
  if(frameCount%100==0&&autoplay){
    
   for(int i=0;i<10;i++) play(blocks.get(int(random(blocks.size()-1))));
    if(gameover) reset();
  }
}



void play(Something b){
int sc=blocks.markContacts(b);
    if (sc>=3) {     
      score+=10000*sc*(sc-2);
      blocks.cleanup();
      return;
    }
}

void mousePressed() {
  Something b=blocks.get(new PVector(mouseX, mouseY));
  if (b!=null) {
    play(b); 
  }
  if (gameover&&mouseY<200) reset();
}
