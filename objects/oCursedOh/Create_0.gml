/// @desc Setup variables
// Debug overlay
show_debug_overlay(true);

image_speed = 0;

anim_val = 0; // Animation progress

anim_start = false;
anim_part_last = 0;

// Shader Uniforms
uniforms = get_shdr_dont_feel_good_uniforms();

// Dust particles
part_sys = part_system_create();
part_dust = part_type_create();

//part_type_sprite(part_dust, sPixel, 0, 0, 0);
part_type_shape(part_dust, pt_shape_sphere);
part_type_scale(part_dust, 0.25, 0.25);
part_type_color1(part_dust, fade_colour);
part_type_speed(part_dust, 0.2, 0.5, 0.01, 0.01);
part_type_direction(part_dust, 35, 145, 0.5, 8);
part_type_alpha2(part_dust, 1, 0);
part_type_life(part_dust, 80, 140);

// Alpha array
// In a 2D array, stores the alpha of each pixel of the sprite
alpha = [];

var _w = sprite_width;
var _h = sprite_height;

for (var _x = 0; _x < _w; ++_x) {
  for (var _y = 0; _y < _h; ++_y) {
    var _col = sprite_getpixel(sprite_index, 0, _x, _y);
    alpha[_x, _y] = _col[3];
  }
}
