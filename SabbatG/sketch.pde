/***************************************************************************************
 * Copyright (c) 2020 by the author
 * @author Ullrich Heinemann , https://github.com/uheinema
 * Released under the terms of the GPLv3, refer to: http://www.gnu.org/licenses/gpl.html
 ***************************************************************************************/

PImage pic;

PShader FILTER;

String filterFrag="sabbatierFrag310.glsl";

float aspect;
float piwi;

void setup() {
  fullScreen(P3D);
  pic=loadImage(
    "manray.png"
    // "face.png"
   // "athene.jpg"
    );
  piwi=width;
  aspect=1.0*pic.height/pic.width;
  if (aspect>1) piwi/=aspect;
  
  FILTER=loadShader(
     filterFrag,
     "FilterVert310.glsl"
    );
}

void draw() {
  background(frameCount);
  image(pic, 0, 10, piwi, piwi*aspect);
  g.shader(FILTER);
  FILTER.set("limit",(float)(frameCount%500)/500.0);
  image(pic, 0, 20+piwi*aspect, piwi, piwi*aspect);
  g.resetShader();;
}
