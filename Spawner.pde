

class Spawner extends Block {

  int delay;
  int timer = 0;
  
  
  Spawner(float pos,float y, float s) {
    super(
       new PVector(pos, y),
       s,0);
    setVel(0,random(0.1));
    delay=90;// delay/10=distance of blicks
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
    Block b=(random(10)>5)
      ?new Bouncy(pos, dim.x,type)
      :new Block(pos, dim.x,type);
    b.setVel(0,dim.y/10);
    blocks.add(b);
    next();
  }
    
 void next(){
   float r = random(3);
    r = round(r); 
    type=int(r);
    timer = int(delay+random(delay));
  }
}



