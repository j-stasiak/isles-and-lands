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

@onready var state_machine: StateMachine = $StateMachine
@onready var placing_construction_site_state: PlacingConstructionSiteState = $StateMachine/PlacingConstructionSiteState
@onready var construction_in_progress_state: ConstructionInProgressState = $StateMachine/ConstructionInProgressState

var recruitment_queue = []

func enque_troop_recruitment(type: String):
	# TODO Will probably be another enum with troop types?
	# For testing purposes any value here is ok
	if spawnable_units.has(type):
		recruitment_queue.push_back(type)

func _process(_delta: float) -> void:
	if $TroopRecruitmentTimer.is_stopped() && recruitment_queue.size() > 0:
		$TroopRecruitmentTimer.start(recruitment_time)

func _on_troop_recruitment_timer_timeout() -> void:
	var troop_to_spawn = recruitment_queue.pop_front()
	unit_spawned.emit(troop_to_spawn, spawn_point.global_position)

func _on_construction_site_placed() -> void:
	state_machine.change_state(construction_in_progress_state)

func _on_construction_done() -> void:
	enque_troop_recruitment("lancer")
