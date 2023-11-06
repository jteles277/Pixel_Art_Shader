// based on code by t3ssel8r: https://youtu.be/d6tp43wZqps
// adapted to Godot by denovodavid

shader_type canvas_item;

// Pixel Upscaler 
render_mode unshaded; 
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Colour Pallete limiter
uniform vec4 color_1 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_2 = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 color_3 = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 color_4 = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 color_5 = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 color_6 = vec4(1.0, 0.0, 1.0, 1.0);
uniform vec4 color_7 = vec4(0.0, 1.0, 1.0, 1.0);
uniform vec4 color_8 = vec4(0.5, 0.5, 0.5, 1.0);  
uniform vec4 color_9 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_10 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_11 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_12 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_13 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_14 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_15 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_16 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_17 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_18 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_19 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_20 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_21 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_22 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_23 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_24 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_25 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_26 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_27 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_28 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_29 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_30 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_31 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_32 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_33 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_34 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_35 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_36 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_37 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_38 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_39 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_40 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_41 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_42 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_43 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_44 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_45 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_46 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_47 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_48 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_49 = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_50 = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	
	vec4 colors[50] = {
    color_1, color_2, color_3, color_4, color_5, color_6, color_7, color_8, color_9, color_10,
    color_11, color_12, color_13, color_14, color_15, color_16, color_17, color_18, color_19, color_20,
    color_21, color_22, color_23, color_24, color_25, // Add 75 more colors like this
    color_26, color_27, color_28, color_29, color_30, color_31, color_32, color_33, color_34, color_35,
    color_36, color_37, color_38, color_39, color_40, color_41, color_42, color_43, color_44, color_45,
    color_46, color_47, color_48, color_49, color_50};
	
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