/// @func set_shdr_dont_feel_good_uniforms()
function set_shdr_dont_feel_good_uniforms(_uniforms, _uvs, _val, _colour, _spread, _radial = false, _direction_x = 0, _direction_y = -1) {
  shader_set_uniform_f(_uniforms.u_uvs, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
  
  shader_set_uniform_f(_uniforms.u_val, _val);
  shader_set_uniform_f(_uniforms.u_spread, _spread);
  
  shader_set_uniform_f(_uniforms.u_colour,
    colour_get_red(_colour)   / 255,
    colour_get_green(_colour) / 255,
    colour_get_blue(_colour)  / 255,
    1.0
  );
  
  shader_set_uniform_f(_uniforms.u_radial, _radial);
  shader_set_uniform_f(_uniforms.u_direction, _direction_x, _direction_y);
  
  // Pattern texture
  var _tex = sprite_get_texture(sNoisePattern, 0);
  texture_set_stage(_uniforms.u_tex, _tex);

  // Pattern texture UVs
  var _tex_uvs = texture_get_uvs(_tex);
  shader_set_uniform_f(_uniforms.u_tex_uvs, _tex_uvs[0], _tex_uvs[1], _tex_uvs[2], _tex_uvs[3]);
}
