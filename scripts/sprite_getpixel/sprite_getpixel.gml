/// @func sprite_getpixel(sprite, subimg, x, y);
/// @desc Returns an array with the color info of a pixel inside a sprite
/// @param _sprite
/// @param _subimg
/// @param _x
/// @param _y
function sprite_getpixel(_sprite, _subimg, _x, _y) {
  var _spr_w = sprite_get_width(_sprite);
  var _spr_h = sprite_get_height(_sprite);
  var _spr_x = sprite_get_xoffset(_sprite);
  var _spr_y = sprite_get_yoffset(_sprite);
  
  // Check if buffer already _exists
  var _exists = 0;
  
  // 0 = doesn't exist
  // 1 = sprite array _exists
  // 2 = subimg element _exists
  
  var _key = string(_sprite);
  
  if (ds_map_exists(global.spr_data_cache, _key)) {
    var _arr = global.spr_data_cache[? _key];
    _exists = 1;
    
    if (array_length(_arr) > _subimg && buffer_exists(_arr[_subimg])) {
      _exists = 2;
    }
  }
  
  // Create sprite array
  if (_exists == 0) {
    var _arr = array_create(_subimg + 1);
    
    for (var _i = 0; _i < _subimg + 1; ++_i) {
      _arr[_i] = -1;
    }
    
    global.spr_data_cache[? _key] = _arr;
    
    _exists = 1;
  }
  
  // Create buffer
  if (_exists == 1) {
    var _arr = global.spr_data_cache[? _key];
    
    var _buff = buffer_create(4 * _spr_w * _spr_h, buffer_fixed, 1);
    _arr[_subimg] = _buff;
    
    var _surf = surface_create(_spr_w, _spr_h);
    
    surface_set_target(_surf);
      draw_clear_alpha(c_white, 0);
      gpu_set_blendmode_ext(bm_one, bm_zero);
      
      draw_sprite(_sprite, _subimg, _spr_x, _spr_y);
      
      gpu_set_blendmode(bm_normal);
    surface_reset_target();
    
    buffer_get_surface(_arr[_subimg], _surf, 0);
    surface_free(_surf);
    
    _exists = 2;
  }
  
  // Get pixel
  if (_exists == 2) {
    var _arr = global.spr_data_cache[? _key];
    var _buff = _arr[_subimg];
    
    buffer_seek(_buff, buffer_seek_start, 4 * ((_spr_w * _y) + _x));
    
    var _clr = array_create(4);
    _clr[0] = buffer_read(_buff, buffer_u8);
    _clr[1] = buffer_read(_buff, buffer_u8);
    _clr[2] = buffer_read(_buff, buffer_u8);
    _clr[3] = buffer_read(_buff, buffer_u8);
    
    return _clr;
  }
}
