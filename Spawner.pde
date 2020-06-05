

class Spawner extends Block {

  int delay;
  int timer = 0;
  
  
  Spawner(float pos,float y, float s) {
    super(
       new PVector(pos, y),
       s,0);
    vel.y=random(0.5);
    delay=60;// delay/10=distance of blicks
    next();
  }

  int getColor(int type) { 
    color c=super.getColor(type); 
    c&=0xaa757575;
    c|=0xff555555;
    return c;
  }

  void spawn() {
    if (gameover||timer-->0) {
      return;
    }
    int colli=blocks.collides(this);
    if (colli>=0) {
     gameover=true;
     return;  
    }  
    Block b=new Block(pos, dim.x,type);
    b.vel.y=dim.y/10;
    blocks.add(b);
    next();
  }
    
 void next(){
   float r = random(4);
    r = round(r); 
    type=int(r);
    timer = int(delay+random(delay));
  }
}



