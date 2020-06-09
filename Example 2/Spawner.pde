

class Spawner extends Block {

  int delay;
  int timer = 0;
  boolean blocked=false;


  Spawner(float pos, float y, float s) {
    super(
      new PVector(pos, y), 
      s, 0);
    setVel(0, random(0.1));
    delay=10;//int(random(90));// delay/10=distance of blicks
    next();
    delay=90;
  }

  @Override
    int getColor(int type) { 
    color c=super.getColor(type); 
    float intense=map(timer,delay,0,0,255);
    intense=constrain(intense,0,255);
    int ii=int(intense);
    c&=ii<<24|0x1ffffff;
    if(blocked&&blink) c=color(255,123,123);
    return c;
  }
  
    public boolean spawn() {
    if (timer-->0) {
      return true;
    }
    if(blocked)return false;
    int colli=blocks.collides(this);
    if (colli>=0) {
     // gameover=true;
      //blocks.get(colli).setVel(0,0);
      grow(-dim.x/4,-dim.y/4);
      blocked=true;
      return false;
    }  
    Block b=(random(10)>5)
      ?new Bouncy(pos, dim.x, type)
      :new Block(pos, dim.x, type);
    b.setVel(0, dim.y/10);
    blocks.add(b);
    next();
    return true;
  }

  void next() {
    float r = random(types);
    r = floor(r); 
    type=int(r);
    timer = int(delay+random(delay));
  }
}


