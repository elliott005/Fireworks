shader_type canvas_item;

uniform float inner_radius: hint_range(0.0, 1.0, 0.1);
uniform vec4 inner_color: source_color;

uniform float middle_radius: hint_range(0.0, 1.0, 0.1);
uniform vec4 middle_color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float dist = length(UV);
	if (dist <= inner_radius) {
        COLOR = vec4(inner_color.rgba);
    } else if (dist <= middle_radius) {
		float blend_factor = (dist - inner_radius) / (middle_radius - inner_radius);
        COLOR = mix(inner_color, middle_color, blend_factor);
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
