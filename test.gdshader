shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform vec4 color : source_color = vec4(1);
uniform float blur : hint_range(0.0, 10.0) = 1;

void fragment() {
		COLOR = textureLod(screen_texture, SCREEN_UV, blur) + color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
