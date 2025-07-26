extends State
class_name PlacingConstructionSiteState

signal construction_site_placed

@export var building_ghost: BuildingGhost
@export var building: Building

var valid_placement: bool

func on_enter() -> void:
	super.on_enter()

	building_ghost.set_ghost_appearance(true)
	var collision_shape: CollisionShape2D = building.get_node("CollisionShape2D")
	$Area2D.shape_owner_add_shape(building.get_instance_id(), collision_shape.shape.duplicate(true))

	building.sprite.texture = building.construction_texture
	building_ghost.sprite = building.sprite

func on_exit() -> void:
	super.on_exit()

func _physics_process(delta: float) -> void:
	building.get_parent().global_position = building.get_parent().get_global_mouse_position()
	if not $Area2D.get_overlapping_bodies().is_empty():
		valid_placement = false
		building_ghost.set_invalid_placement()
	else:
		valid_placement = true
		building_ghost.set_valid_placement()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and valid_placement:
		building_ghost.set_ghost_appearance(false)
		construction_site_placed.emit()
