
class Blocks
  extends ArrayList<Something> {

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

  int marked;

  int markContacts(Something mark) {
    ArrayList<Something> hood;
    for (Something b : this) {
      b.distmark=0;
    }
    mark.distmark=1;
    marked=1;
    hood=new ArrayList<Something>();
    hood.add(mark);
    mark(hood);
    if (marked<3)marked=0;
    for (Something b : this) {
      if (marked<3) b.distmark=0;
    }
    return marked;
  }

  void mark(ArrayList<Something> lasthood) {
    ArrayList<Something> hood=new ArrayList<Something>();
    for (Something mark : lasthood) {
      for (Something b : this) {
        Block bb=(Block)b;
        if (b==mark||
          b.type!=mark.type||
          b.distmark!=0) {
          continue;
        } else if (bb.xoverlaps(mark)) {
          b.distmark=mark.distmark+1;
          hood.add(b);
          marked++;
        }
      }
    }
    if (hood.size()>0) {
      mark(hood);
    }
  }

  void cleanup() {
    for (int i=0; i<size(); ) {
      Something  b = get(i);
      if (b.distmark >0)
        remove(i);
      else
        i++;
    }
  }
}
