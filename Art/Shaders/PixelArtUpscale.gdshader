// based on code by t3ssel8r: https://youtu.be/d6tp43wZqps
// adapted to Godot by denovodavid

shader_type canvas_item;
render_mode unshaded;
uniform float pixelate: hint_range(2, 512, 4) = 256;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	 vec2 uv2 = floor(UV * pixelate) / pixelate;
	
	// box filter size in texel units
	vec2 box_size = clamp(fwidth(UV) / TEXTURE_PIXEL_SIZE, 1e-5, 1);
	// scale uv by texture size to get texel coordinate
	vec2 tx = UV / TEXTURE_PIXEL_SIZE - 0.5 * box_size;
	// compute offset for pixel-sized box filter
	vec2 tx_offset = smoothstep(vec2(1) - box_size, vec2(1), fract(tx));
	// compute bilinear sample uv coordinates
	vec2 uv = (floor(tx) + 0.5 + tx_offset) * TEXTURE_PIXEL_SIZE;
	// sample the texture
	COLOR = textureGrad(TEXTURE, uv, dFdx(UV), dFdy(UV));
	//COLOR = textureLod(screen_texture, uv, 0.0);
}
