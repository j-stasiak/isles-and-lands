extends State
class_name PlacingConstructionSiteState

@export var next_state: State
@export var building_ghost: BuildingGhost
@export var construction_texture: Texture2D
@export var sprite: Sprite2D

var valid_placement: bool = true

func on_enter() -> void:
	super.on_enter()

	building_ghost.set_ghost_appearance(true)

	building_ghost.sprite = sprite
	sprite.texture = construction_texture
	# To avoid flickering effect from (0, 0) to mouse on physics process
	$"../..".global_position = $"../..".get_global_mouse_position()

func on_exit() -> void:
	super.on_exit()

func _physics_process(delta: float) -> void:
	$"../..".global_position = $"../..".get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and valid_placement:
		building_ghost.set_ghost_appearance(false)
		state_changed.emit(next_state)
