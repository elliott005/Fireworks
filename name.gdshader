shader_type canvas_item;

uniform float appear_time = 2.0;
uniform float appear_speed = 1.0;
uniform float start_time = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float elapsed_time = TIME - start_time;
	if (elapsed_time > appear_time) {
		float dif = elapsed_time - appear_time;
		vec4 original_color = texture(TEXTURE, UV);
		if (original_color.a == 1.0) {
			COLOR.a = dif * appear_speed;
		}
	} else {
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
