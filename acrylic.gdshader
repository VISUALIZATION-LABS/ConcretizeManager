shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, filter_linear_mipmap;
uniform int maxSize : hint_range(0, 100) = 20;
uniform float downsampleAmount : hint_range(0.0, 50) = 4;
uniform vec4 tint : source_color;
uniform int colourMixType : hint_range(0, 3, 1) = 0;


vec4 blur(sampler2D sourceTexture, vec2 uv) {
	vec4 result = vec4(0.,0.,0.,0.);
	float x = 1.0;
	float y = 0.0;
	ivec2 size = textureSize(sourceTexture, 0);
	
	// Horizontal
	for (int i = -maxSize; i < maxSize; ++i) {
		vec2 offset = vec2(1.0, 0.) * float(i) / vec2(size);
		float weight = 1./float(maxSize);
		
		result += textureLod(sourceTexture, uv + offset, downsampleAmount) * weight;
	}
	
	// Vertical
	for (int i = -maxSize; i < maxSize; ++i) {
		vec2 offset = vec2(0., 1.) * float(i) / vec2(size);
		float weight = 1./float(maxSize);
		
		result += textureLod(sourceTexture, uv + offset, downsampleAmount) * weight;
	}
	return result / 4.;
}


void fragment() {
	switch (colourMixType) {
		case 0:
			COLOR = blur(screenTexture, SCREEN_UV) + tint;
			break;
		case 1:
			COLOR = blur(screenTexture, SCREEN_UV) - tint;
			break;
		case 2:
			COLOR = blur(screenTexture, SCREEN_UV) * tint;
			break;
		case 3:
			COLOR = blur(screenTexture, SCREEN_UV) / tint;
			break;
	}
	
}