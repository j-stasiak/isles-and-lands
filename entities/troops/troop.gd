class_name Troop extends CharacterBody2D

var selected: bool = false
var moving: bool = false
var movement_speed: float = 200.0
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	actor_setup.call_deferred()

func actor_setup():
	await get_tree().physics_frame

func _process(delta: float):
	if moving:
		$AnimatedSprite2D.play(&"run")
	else:
		$AnimatedSprite2D.play(&"idle")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		var mouse_event: InputEventMouseButton = event
		if selected && mouse_event.button_index == MOUSE_BUTTON_RIGHT:
			moving = true
			set_movement_target(get_global_mouse_position())

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		moving = false
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	$AnimatedSprite2D.set_flip_h(next_path_position - current_agent_position <= Vector2.ZERO)

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func spawn(type: String, new_position: Vector2):
	$AnimatedSprite2D.sprite_frames = load("res://entities/troops/lancer/lancer.tres")
	$AnimatedSprite2D.play("idle")
	add_to_group(&"troops")
	position = new_position

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func check_selection(selection_rect: Rect2):
	var collision_rect: Rect2 = $CollisionShape2D.shape.get_rect()
	collision_rect.position = global_position - collision_rect.size / 2
	selected = collision_rect.intersects(selection_rect)
	$AnimatedSprite2D.material.set_shader_parameter("is_selected", selected)
