shader_type canvas_item;

uniform vec4 shadow_color: source_color;
uniform vec4 selection_color: source_color;
uniform bool is_selected = false;

bool color_match(vec4 first_color, vec4 second_color, float max_difference) {
  return distance(first_color, second_color) < max_difference;
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (is_selected && color_match(texture_color, shadow_color, 0.01)) {
		COLOR = selection_color;
	}
}
