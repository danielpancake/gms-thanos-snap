/// @description 
// Text
draw_text(4, 4, "Press S to play");

// Set shader
shader_set(shNoFeelGood);

// UVs for base sprite
var _uvs = sprite_get_uvs(sprite_index, image_index);
_uvs = [_uvs[0], _uvs[1], _uvs[2], _uvs[3]];
shader_set_uniform_f_array(uniUvs, _uvs);

// Pattern texture
var _tex = sprite_get_texture(sNoisePattern, 0);
texture_set_stage(uniTex, _tex);

// Pattern texture UVs
_uvs = texture_get_uvs(_tex);
_uvs = [_uvs[0], _uvs[1], _uvs[2], _uvs[3]];
shader_set_uniform_f_array(uniTexUvs, _uvs);

// Other uniforms
shader_set_uniform_f(uniSpread, animSpread);
shader_set_uniform_f(uniVal, animVal);
shader_set_uniform_f(uniCol, 
	color_get_red(fadeColor)/255,
	color_get_blue(fadeColor)/255,
	color_get_green(fadeColor)/255);

draw_self();

shader_reset();