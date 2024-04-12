/// @desc Draw with shader
draw_set_alpha(1);
draw_set_color(c_white);
draw_text(4, 4, "Press [S] to play");

// Set shader
shader_set(shdr_dont_feel_good);
set_shdr_dont_feel_good_uniforms(
  uniforms,
  sprite_get_uvs(sprite_index, image_index),
  anim_val,
  fade_colour,
  anim_spread,
  false,
  direction_x,
  direction_y
);

draw_self();

shader_reset();

// Draw debug line to show the progress
if (keyboard_check(vk_space)) {
  var _x_origin = x - sprite_get_xoffset(sprite_index) * image_xscale;
  var _y_origin = y - sprite_get_yoffset(sprite_index) * image_yscale;
  
  draw_rectangle(_x_origin, _y_origin, _x_origin + sprite_width, _y_origin + sprite_height, true);
  
  var _theta = 90 - darctan2(direction_y, direction_x);
  
  var _cx = _x_origin + sprite_width / 2;
  var _cy = _y_origin + sprite_height / 2;
  
  var _px = _cx + sprite_width * sign(direction_x) * (anim_val - anim_spread - .5);
  var _py = _cy + sprite_height * sign(direction_y) * (anim_val - anim_spread - .5);
  
  draw_set_color(c_red);
  draw_line(
    _px - lengthdir_x(128, _theta),
    _py - lengthdir_y(128, _theta),
    _px + lengthdir_x(128, _theta),
    _py + lengthdir_y(128, _theta)
  );
}
