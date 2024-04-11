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

vec2 normalize_sum(vec2 v) {
  float sum = abs(v.x) + abs(v.y);
  if (sum == 0.0) {
    return v;
  }
  return v / sum;
}

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
    p_idx = dot(0.5 - coords, -normalize_sum(direction)) + 0.5; // This is crazy
  }
  
  // Value for this pixel
  float p_val = 0.0;
  if (spread == 0.0) {
    p_val = 1.0 - step(val, p_idx);
  } else {
    p_idx += patten_val * spread * 2.0;
    
    float val_rel = max(0.0, val - (p_idx - spread));
    p_val = min(1.0, val_rel / spread);
  }
  
  // Fade to color
  gl_FragColor.rgb = mix(gl_FragColor.rgb, colour, p_val);
  
  // Alpha
  gl_FragColor.a *= 1.0 - floor(p_val);
}
