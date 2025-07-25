extends CharacterBody2D
class_name Troop 

@export_group("Local")
@export var navigation_agent : NavigationAgent2D
@export var animated_sprite : AnimatedSprite2D
@export var collision : CollisionShape2D

var movement_speed : float = 200.0
var is_moving : bool = false
var is_selected : bool = false :
	set(new_is_selected):
		is_selected = new_is_selected
		animated_sprite.material.set_shader_parameter("is_selected", is_selected)
		set_process_input(is_selected)

func _ready():
	# Invoke setter
	is_selected = false

	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	actor_setup.call_deferred()

func actor_setup():
	await get_tree().physics_frame

func _process(_delta: float):
	if is_moving:
		animated_sprite.play(&"run")
	else:
		animated_sprite.play(&"idle")

func _input(event : InputEvent):
	if not event is InputEventMouseButton:
		return

	if event.is_action_pressed("move_selected_unit"):
		set_movement_target(get_global_mouse_position())

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		is_moving = false
		return

	var current_pos = global_position
	var desired_pos = navigation_agent.get_next_path_position()

	animated_sprite.set_flip_h(desired_pos - current_pos <= Vector2.ZERO)

	velocity = current_pos.direction_to(desired_pos) * movement_speed

	move_and_slide()

func set_movement_target(movement_target: Vector2):
	is_moving = true
	navigation_agent.target_position = movement_target

func check_selection(selection_rect: Rect2):
	var collision_rect = collision.shape.get_rect()
	collision_rect.position = global_position - collision_rect.size / 2
	is_selected = collision_rect.intersects(selection_rect)
