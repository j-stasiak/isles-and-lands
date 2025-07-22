extends Node2D

var selection_start_position = null
var selection_box: Rect2

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if selection_start_position != null:
		selection_box = Rect2(selection_start_position, get_global_mouse_position() - selection_start_position) * global_transform
		queue_redraw()

func _input(event: InputEvent) -> void:
	var left_mouse_button_pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT);
	if left_mouse_button_pressed:
		if selection_start_position == null:
			selection_start_position = get_global_mouse_position()

	if !left_mouse_button_pressed and selection_start_position != null:
		selection_start_position = null
		get_tree().call_group("troops", "check_selection", selection_box)
		queue_redraw()

func _draw() -> void:
	if selection_start_position != null:
		draw_rect(selection_box, Color.AQUA, false)
