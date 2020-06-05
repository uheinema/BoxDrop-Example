
class Block extends Something {

  Block(PVector p, float s, int type) {
    super(p, s);
    pos = p.copy();
    this.type = type;
  }

  //@Override 
  boolean xoverlaps(Something b) {
    boolean lap=false;
    float rim=dim.x/5;
    
    grow(rim, -rim);
    if (super.overlaps(b)) lap=true;
    grow(-rim*2, 2*rim);
    if (!lap&&super.overlaps(b)) lap=true;
    grow(rim, -rim);
    return lap;
  }

  color getColor(int type) {
    switch(type) {
    case 0: 
      return color(255, 0, 0);// red
    case 1: 
      return color(0, 255, 0);// green
    case 2: 
      return color(0, 0, 255);// blue
    case 3: 
      return color(255, 255, 0);// yellow
    case 4: 
      return color(255, 0, 255);// purple
    case 5: 
      return color(0, 255, 255);// cyan
    case 6: 
      return color(255, 165, 0);// orange
    default: 
      return color(223);
    }
  }

  void draw() {
    fill(getColor(type));
    super.draw();
  }

 @Override
  boolean move() {
    if (pos.y >= maxh){
      pos.y=maxh;
      return false; // at bottom
    }
    // only look in movement direction
    boolean moved=super.move();
    if(!moved) return false;
    grow(-2, -2);
    if (blocks.collides(this)>=0){
      moved=false;
      super.unmove();
    }
    grow(2, 2);
    return moved;
  }// move
}




