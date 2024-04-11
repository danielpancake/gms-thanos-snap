/// @func get_shdr_dont_feel_good_uniforms()
/// @desc Returns uniforms for the thanos snap shader
function get_shdr_dont_feel_good_uniforms() {
  return {
    u_uvs    : shader_get_uniform(shdr_dont_feel_good, "uvs"),
    u_val    : shader_get_uniform(shdr_dont_feel_good, "val"),
    u_colour : shader_get_uniform(shdr_dont_feel_good, "colour"),
    u_spread : shader_get_uniform(shdr_dont_feel_good, "spread"),
    
    u_radial    : shader_get_uniform(shdr_dont_feel_good, "radial"),
    u_direction : shader_get_uniform(shdr_dont_feel_good, "direction"),
    
    u_tex     : shader_get_sampler_index(shdr_dont_feel_good, "tex"),
    u_tex_uvs : shader_get_uniform(shdr_dont_feel_good, "tex_uvs"),
  }
}
