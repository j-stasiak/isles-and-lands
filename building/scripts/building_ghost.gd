class_name BuildingGhost extends Node

@export var can_place_color: Color = Color(0.5, 1.0, 0.5, 0.7)
@export var cannot_place_color: Color = Color(1.0, 0.5, 0.5, 0.7)

var sprite: Sprite2D

func _ready() -> void:
	pass

func set_ghost_appearance(is_ghost: bool):
	if not sprite:
		return

	if is_ghost:
		set_valid_placement()
	else:
		reset_appearance()

func set_custom_color(color: Color):
	if not sprite:
		push_warning("Cannot set color: Sprite2D not found")
		return

	sprite.modulate = color

func set_valid_placement():
	set_custom_color(can_place_color)

func set_invalid_placement():
	set_custom_color(cannot_place_color)

func reset_appearance():
	set_custom_color(Color.WHITE)
