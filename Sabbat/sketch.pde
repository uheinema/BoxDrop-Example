
PImage pic, sab;

float aspect;
float piwi;

void setup() {
  fullScreen();
  pic=loadImage(
    "manray.png"
    // "face.png"
   // "athene.jpg"
    );
  piwi=width;
  aspect=1.0*pic.height/pic.width;
  if (aspect>1) piwi/=aspect;
  sab=pic.get();
  sab.loadPixels();
  sabbatier(sab.pixels);
  sab.updatePixels();
}

void sabbatier(int[] pixels) {
  for (int i=0; i<pixels.length; i++) {
    int c=pixels[i];
    float blue=(c&0xff)/255.0f;
    pixels[i]=color(255*sabbatier(blue));
  }
}

float sabbatier(float u) {
  final float lim=0.2f;
  float r;
  if (u<lim)
    r=map(u, 0, lim, 1, 0);
  else
    r=map(u, lim, 1, 0, 1);
  return r;
}

void draw() {
  background(frameCount);
  image(pic, 0, 10, piwi, piwi*aspect);
  image(sab, 0, 20+piwi*aspect, piwi, piwi*aspect);
}
