// based on code by t3ssel8r: https://youtu.be/d6tp43wZqps
// adapted to Godot by denovodavid

shader_type canvas_item;

// Pixel Upscaler 
render_mode unshaded; 
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Colour Pallete limiter
uniform vec4 color_1 = vec4(.0, .0, .0, 1.0);
uniform vec4 color_2 = vec4(0.5, 0.5, 0.5, 1.0);
uniform vec4 color_3 = vec4(0.9, 0.0, 0.0, 1.0);
uniform vec4 color_4 = vec4(0.9, 0.9, 0.6, 1.0);

void fragment() {
	
	vec4 colors[4] = {color_1, color_2, color_3, color_4};
	float min_diff = -1.0;
	vec4 min_color = vec4(0.0, 0.0, 0.0, 1.0);

	vec2 c_uv = SCREEN_UV;

	vec4 temp = textureLod(screen_texture, c_uv, 0.0);
	min_diff = 1000.0;
	for (int i = 0; i < colors.length(); i++) {

		float curr_dist = distance(colors[i], temp);
		if (curr_dist < min_diff) {
			min_diff = curr_dist;
			min_color = colors[i];
		}
	} 
	COLOR.rgb = min_color.rgb; 
} 