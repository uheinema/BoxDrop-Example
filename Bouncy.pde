class Bouncy extends Block{
  PVector target=new PVector(0,0);
  Bouncy(PVector p, float s, int type) {
    super(p,s,type);
  }
  
  @Override
  void setVel(float x,float y){
    super.setVel(x,y);
    target.x=x;target.y=y;
  }
  
  @Override
  boolean move(){
    PVector to=target.copy();
    to.sub(vel); 
    to.mult(0.011f);
    vel.add(to);
    if(!super.move()){ // reflect angular
      vel.mult(-1.0f);
      if(autoplay)vel.x+=5*(random(2.0)-1);
      return false;
    }
    return true;
  }
  
  @Override void draw(){
    fill(getColor(type));
    ellipse (pos.x+dim.x/2,pos.y+dim.y/2,dim.x,dim.y);
   // drawMark();
  }
  
}