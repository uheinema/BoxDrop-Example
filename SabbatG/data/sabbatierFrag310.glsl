#version 310 es

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

in vec4 vertTexCoord;
out vec4 out_gl_FragColor;

uniform sampler2D texMap;
uniform float limit; // 0.0f if not initialized?

// from https://github.com/msfeldstein/glsl-map/blob/master/index.glsl
float map(float value, float inMin, float inMax, float outMin, float outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

// -------
// copied (almost) verbatim from java
float sabbatier(float u) {
  float lim=0.2f;
  float r;
  if(limit!=0.0f) lim=limit;
  if (u<lim) // in glsl, some ramp would be even faster
    r=map(u, 0.0, lim, 1.0, 0.0);
  else
    r=map(u, lim, 1.0, 0.0, 1.0);
  return r;
}
//-------

void main() {  
  vec2 p = vertTexCoord.st;
  out_gl_FragColor =vec4( vec3(sabbatier(texture(texMap,p).b)),1.0);
}