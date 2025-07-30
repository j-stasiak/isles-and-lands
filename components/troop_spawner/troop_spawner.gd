extends Node
class_name TroopSpawner

signal troop_spawned(troop: Troop, spawn_point: Vector2)

@export var troop_to_spawn: String # TODO: Change to PackedScene or proper class later
@export var spawn_point: Marker2D
@export var recruitment_time: float = 1.5
## If option is set to false, the troop can only be spawned one at a time
@export var can_schedule: bool = true

var spawn_time_queue = []
var running_timer: float = 0

func _process(delta: float) -> void:
	if not spawn_time_queue.is_empty() and running_timer <= 0:
		running_timer = spawn_time_queue.pop_front()
		if running_timer == 0:
			spawn_unit()

	if running_timer > 0:
		running_timer -= delta

		if running_timer <= 0:
			spawn_unit()

func schedule_troop_creation():
	if can_schedule:
		spawn_time_queue.push_back(recruitment_time)
	elif spawn_time_queue.is_empty():
		spawn_time_queue.push_back(recruitment_time)
	else:
		print_debug("Cannot schedule while queue is not empty...")

func spawn_unit():
	var unit: Troop = load("res://entities/troops/troop.tscn").instantiate()
	var spawn_location = spawn_point.global_position if spawn_point != null else Vector2.ZERO
	var map = get_tree().get_first_node_in_group("map")
	map.add_child(unit)
	unit.spawn("lancer", spawn_location)
	troop_spawned.emit(unit, spawn_location)
