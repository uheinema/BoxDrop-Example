
class Blocks
  extends ArrayList<Something> {
  static final long serialVersionUID=12334;
  
  Blocks() {
    super();
  }

  int collides(int b) {
    return collides(b, 0);
  }

  private int collides(int b, float tol) {
    for (int i=b+1; i<size(); i++) {
      // if(b==i) continue ;
      if (get(b).overlaps(get(i), tol)) {
        return i;
      }
    }
    return -1; // no collision
  }

  int collides(Something b) {
    return collides(b, 0);
  }

  private int collides(Something b, float tol) {
    for (int i=0; i<size(); i++) {
      Something gi=get(i);
      if (b==gi) continue ;
      if (b.overlaps(get(i), tol)) {
        return i;
      }
    }
    return -1; // no collision
  }

  Blocks draw() {
    for (Something b : this) {
      b.draw();
    }
    return this;
  }

  Blocks move() {
    for (Something b : this) {
      b.move();
    }
    return this;
  }

  Something get(PVector where) {
    for (Something b : this) {
      if (b.inside(where)) {
        return b;
      }
    }
    return null;
  }

  

  public int markContacts(Something mark) {
    ArrayList<Something> hood=new ArrayList<Something>(1);
    for (Something b : this) {
      b.distmark=0;
    }
    mark.distmark=1;
    hood.add(mark);
    int marked=mark(hood)+1;
    if (marked<3) {   
      marked=0;
      for (Something b : this) {
        b.distmark=0;
      }
    }
    return marked;
  }

  int mark(ArrayList<Something> lasthood) {
    ArrayList<Something> hood=new ArrayList<Something>();
    int marked=0;
    for (Something mark : lasthood) {
      for (Something b : this) {
        if (b!=mark&&
          b.type==mark.type&&
          b.distmark==0&&
          b.isHoodie(mark)) 
        {
          b.distmark=mark.distmark+1;
          hood.add(b);
          marked++;
        }
      }
    }
    if (hood.size()>0) {
      marked+=mark(hood);
    }
    return marked;
  }

  void cleanup() {
    for (int i=0; i<size(); ) {
      Something  b = get(i);
      if (b.distmark >0||
         b.pos.x<-b.dim.x||
         b.pos.x>width)
        remove(i);
      else
        i++;
    }
  }
}
