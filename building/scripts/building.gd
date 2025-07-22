extends StaticBody2D
class_name Building

signal unit_spawned(type: String, spawn_point: Vector2) # TODO Change later to enum

@export var base_health: float = 100
@export var recruitment_time: float = 1.5
@export var spawn_point: Marker2D
@export var spawnable_units: PackedStringArray
@export var construction_texture: Texture2D
@export var active_texture: Texture2D
@export var destroyed_texture: Texture2D
@export var sprite: Sprite2D

var state: BuildingState
var building_state
var dragging = false
var recruitment_queue = []

func place_construction_site():
	get_parent().global_position = get_global_mouse_position()

	state.change_state(BuildingConstants.BuildingState.CONSTRUCTION)

	$Ghost.set_ghost_appearance(true)
	dragging = true

func begin_building() -> void:
	$ConstructionTimer.start()

func enque_troop_recruitment(type: String):
	# TODO Will probably be another enum with troop types?
	# For testing purposes any value here is ok
	if spawnable_units.has(type):
		recruitment_queue.push_back(type)

func _ready() -> void:
	state = BuildingState.new()
	state.connect("state_changed", self._on_state_changed)
	sprite.texture = construction_texture
	$Ghost.sprite = sprite


func _process(_delta: float) -> void:
	if $TroopRecruitmentTimer.is_stopped() && recruitment_queue.size() > 0:
		$TroopRecruitmentTimer.start(recruitment_time)

func _physics_process(delta: float) -> void:
	if dragging:
		get_parent().global_position = get_global_mouse_position()

func _on_construction_timer_timeout() -> void:
	state.change_state(BuildingConstants.BuildingState.ACTIVE)
	# TODO: remove later
	enque_troop_recruitment("lancer")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and dragging:
		dragging = false
		$Ghost.set_ghost_appearance(false)
		if state.current_state == BuildingConstants.BuildingState.CONSTRUCTION:
			begin_building()

	if event.is_action_pressed("move_building") && state.current_state == BuildingConstants.BuildingState.ACTIVE:
		dragging = true
		$Ghost.set_ghost_appearance(true)


func _on_state_changed(new_state: BuildingConstants.BuildingState) -> void:
	match new_state:
		BuildingConstants.BuildingState.CONSTRUCTION:
			sprite.texture = construction_texture
		BuildingConstants.BuildingState.ACTIVE:
			sprite.texture = active_texture
		BuildingConstants.BuildingState.DESTROYED:
			sprite.texture = destroyed_texture

func _on_troop_recruitment_timer_timeout() -> void:
	var troop_to_spawn = recruitment_queue.pop_front()
	unit_spawned.emit(troop_to_spawn, spawn_point.global_position)
