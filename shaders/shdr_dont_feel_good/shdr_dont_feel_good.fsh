//
// Oh no...
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform vec4 uvs;  // Base texture UVs
uniform float val; // Animation progress (0-1)
 
uniform vec3 colour;  // Dust color
uniform float spread; // Feathering

uniform bool radial; // Mode of the effect

uniform vec2 direction; // Direction for the straight line mode

// Pattern sampler
uniform sampler2D tex; // Pattern texture
uniform vec4 tex_uvs;  // Pattern UVs

#define eps 0.0001

void main() {
  gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
  
  // Normalize coords
  vec2 coords = v_vTexcoord;
  coords = (coords - uvs.xy) / (uvs.zw - uvs.xy);
  
  // Sample pattern texture
  vec2 patten_coords = tex_uvs.xy + coords * (tex_uvs.zw - tex_uvs.xy);
  float patten_val = texture2D(tex, patten_coords).r;
  
  // Apply mode
  float p_idx = 0.0;
  if (radial) {
    p_idx = length(coords - 0.5);
  } else {
    vec2 wrapped = vec2(fract(coords * direction));
    p_idx = (wrapped.x + wrapped.y) / 2.0;
  }
  
  p_idx += patten_val * spread * 2.0;
  
  // Value for this pixel
  float p_val = 1.0;
  if (spread == 0.0) {
    // Hard transition
    p_val = 1.0 - step(val, p_idx);
  } else if (val < 1.0) {
    // Smooth transition
    float p_base = p_idx - spread;
    float val_rel = max(0.0, val - p_base);
    p_val = min(1.0, val_rel / spread);
  }
  
  // Fade to color
  gl_FragColor.rgb = mix(gl_FragColor.rgb, colour, p_val);
  
  // Alpha
  gl_FragColor.a *= 1.0 - floor(p_val);
}
