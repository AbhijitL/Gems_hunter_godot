// Based on http://devlog-martinsh.blogspot.com/2011/03/glsl-dithering.html

shader_type canvas_item;

uniform float scale = 1.0;

float find_closest(int x, int y, float c0)
{
  mat4 dither = mat4(vec4( 1.0, 33.0, 9.0, 41.0),
		     vec4(49.0, 17.0, 57.0, 25.0),
		     vec4(13.0, 45.0, 5.0, 37.0),
		     vec4(61.0, 29.0, 53.0, 21.0));

  float limit = 0.0;

  vec4 subd;
  // No indexing on variables in Godot (as of 3.1)
  if (x == 0) {
    subd = dither[0];
  } else if (x == 1) {
    subd = dither[1];
  } else if (x == 2) {
    subd = dither[2];
  } else if (x == 3) {
    subd = dither[3];
  }

  if (y == 0) {
    limit = subd[0];
  } else if (y == 1) {
    limit = subd[1];
  } else if (y == 2) {
    limit = subd[2];
  } else if (y == 3) {
    limit = subd[3];
  }

  limit = limit / 64.0;

  if (c0 < limit){
    return 0.0;
  } else {
    return 1.0;
  }
}


void fragment() {
  vec2 texCoord = SCREEN_UV;

  vec4 lum = vec4(0.299, 0.587, 0.114, 0.0);
  float grayscale = dot(texture(TEXTURE, texCoord), lum);
  vec3 rgb = texture(TEXTURE, texCoord).rgb;

  vec2 xy = FRAGCOORD.xy;
  int x = int(mod(xy.x, 4.0));
  int y = int(mod(xy.y, 4.0));

  COLOR.r = find_closest(x, y, rgb.r);
  COLOR.g = find_closest(x, y, rgb.g);
  COLOR.b = find_closest(x, y, rgb.b);
}