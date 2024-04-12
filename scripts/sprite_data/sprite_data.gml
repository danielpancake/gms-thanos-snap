/// @func sprite_data_begin()
function sprite_data_begin() {
  global.spr_data_cache = ds_map_create();
}

/// @func sprite_data_end()
/// @desc Deletes all data required for sprite_getpixel
function sprite_data_end() {
  // Delete all buffers
  var _ds_size = ds_map_size(global.spr_data_cache);
  for (var _i = 0; _i < _ds_size; ++_i) {
    var _arr = global.spr_data_cache[? _i];
    
    array_foreach(_arr, function(_buff) {
      if (buffer_exists(_buff)) {
        buffer_delete(_buff);
      }
    });
  }
  
  // Destroy map
  ds_map_destroy(global.spr_data_cache);
}

gml_pragma("global", "sprite_data_begin()");
