/// @desc Control and animation logic
// Restart
if (keyboard_check_pressed(ord("R"))) {
  room_restart();
}

if (!anim_start && keyboard_check_pressed(ord("S"))) {
  anim_start = true;
}

// Animation started
if (anim_start) {
  // Animation progress value
  anim_val = clamp(anim_val + anim_speed, 0, 1);
  
  if (anim_val - anim_part_last > anim_part_interval && anim_val >= anim_spread) {
    var _x_origin = x - sprite_get_xoffset(sprite_index);
    var _y_origin = y - sprite_get_yoffset(sprite_index);
    
    var _theta = 90 - darctan2(direction_y, direction_x);
    
    var _cx = _x_origin + sprite_width / 2;
    var _cy = _y_origin + sprite_height / 2;
    
    var _px = _cx + sprite_width * sign(direction_x) * (anim_val - anim_spread - .5);
    var _py = _cy + sprite_height * sign(direction_y) * (anim_val - anim_spread - .5);
    
    var _dx = 0;
    var _dy = 0;
    
    while (abs(_dx) < (sprite_width / 2) && abs(_dy) < (sprite_height / 2)) {
      var _x = clamp(_px + _dx - _x_origin, 0, sprite_width - 1);
      var _y = clamp(_py + _dy - _y_origin, 0, sprite_height - 1);
      
      if (alpha[floor(_x), floor(_y)] > 0) {
        part_particles_create(part_sys, _px + _dx, _py + _dy, part_dust, 1);
      }
      
      _x = clamp(_px - _dx - _x_origin, 0, sprite_width - 1);
      _y = clamp(_py - _dy - _y_origin, 0, sprite_height - 1);
      
      if (alpha[floor(_x), floor(_y)] > 0) {
        part_particles_create(part_sys, _px - _dx, _py - _dy, part_dust, 1);
      }
      
      var _d = random_range(5, 10); // TODO: move to params
      _dx += lengthdir_x(_d, _theta);
      _dy += lengthdir_y(_d, _theta);
    }
    
    anim_part_last = anim_val;
  }
}
