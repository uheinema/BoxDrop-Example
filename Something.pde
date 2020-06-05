
class Something { // a moving rect? 
  
  PVector pos;
  PVector dim;
  PVector vel;
  
  int distmark=0;
  int type=0;
  
  

  Something (float s) {
    dim = new PVector(s, s);
    vel= new PVector(0, 0);
    pos=new PVector(0, 0);
  }
  
  Something(PVector ps,float s){
    this(s);
    pos.x=ps.x;
    pos.y=ps.y;
  }
  
  void setVel(float x,float y){
    vel.x=x;vel.y=y;
  }
  
  boolean move() {
    pos.add(vel);
    return true;
  }
  
  void unmove() {
    pos.sub(vel);
  }
  
  boolean overlaps(Something other) {
    return overlaps(other,0.0f);
  }
  
  boolean overlaps(Something other,float tol) {
    // bounding box as default
    return
      pos.x-tol<other.pos.x+other.dim.x&&
      pos.y-tol<other.pos.y+other.dim.y&&
      other.pos.x-tol<pos.x+dim.x&&
      other.pos.y-tol<pos.y+dim.y;
  };
  
  boolean inside(PVector p){
    return 
     p.x>pos.x&&p.x<pos.x+dim.x&&
     p.y>pos.y&&p.y<pos.y+dim.y
    ;  
  }

  void draw() {
    rect(pos.x, pos.y, dim.x, dim.y);
  }
  
  void grow(float x,float y){
    pos.x-=x; dim.x+=x+x;
    pos.y-=y; dim.y+=y+y;
  }

}



