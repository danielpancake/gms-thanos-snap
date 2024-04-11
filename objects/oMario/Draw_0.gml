/// @description 
// Text
draw_text(4, 4, "Press S to play");

// Set shader
shader_set(shdr_dont_feel_good);

shader_set(shdr_dont_feel_good);
set_shdr_dont_feel_good_uniforms(
  uniforms,
  sprite_get_uvs(sprite_index, image_index),
  animVal,
  fadeColor,
  animSpread,
  false,
  1, 1
);
draw_self();

shader_reset();