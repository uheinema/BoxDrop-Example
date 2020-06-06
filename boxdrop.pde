
Blocks blocks = new Blocks();
ArrayList<Spawner> spawn = new ArrayList<Spawner>();


final int columns = 10;
final int types=5;


boolean autoplay=true;

boolean gameover=false;
int score=0;

int restart=0;

float maxh ;

boolean blink=false;

void setup() {
  fullScreen();//size(600,600);
  frameRate(30);
  reset();
  autoplay=true;
}

void reset() {
  float s=(width-100.0)/columns;
  s-=2;
  textSize(100);

  maxh=height-2*s;
  blocks.clear();
  blocks.add(new Block(new PVector(0, height-200), width, 777));
  blocks.add(new Block(new PVector(0, -width+150), width, 777));
  spawn.clear();
  for (int i = 0; i < columns; i++) {
    spawn.add(new Spawner(50+i*(s+2), 150, s));
  }
  autoplay=false;
  gameover=false;
  restart=0;
  score=0;
}

void showScore()
{
  if (blink&&gameover)fill(255);
  textAlign(CENTER, TOP);
  text("Score: "+
    score, 
    width/2, 30);
  textAlign(CENTER, TOP);
  text(""+(autoplay?"Tap to start":
    (gameover?"Try again":"")
    ), width/2, height-130);
}

void draw() {
  background(gameover?color(155, 12, 13):(frameCount|0xff407f40));
  fill(0);
  blink=(frameCount%20<2);
  if(frameCount==restart) {
    reset();
    autoplay=true;
  }
  int active=0;
   
  for (Spawner s : spawn) {
    s.draw();
  if(!gameover){
      if (s.spawn()) {
        active++;
      }
      s.move();
    }
  }
  if (active==0&&!gameover) {
     restart=frameCount+(autoplay?300:3000);
     gameover=true;
  }
  else score++;
  
  blocks.draw().move();
  showScore();

  if (frameCount%10==0&&autoplay) { 
    play(blocks.get(int(random(blocks.size()-1))));
    // if(gameover) reset();
  }
}



void play(Something b) {
  int sc=blocks.markContacts(b);
  if (sc>=3) {     
    score+=10000*sc*(sc-2);
    blocks.cleanup();
    return;
  }
}

void mousePressed() {
  if (autoplay||gameover) reset();
  Something b=blocks.get(new PVector(mouseX, mouseY));
  if (b!=null) {
    play(b);
  }
  else{
    score-=1000;
  }
}
