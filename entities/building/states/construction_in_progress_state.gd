extends State
class_name ConstructionInProgressState

@export var next_state: State
@onready var construction_timer: Timer = $ConstructionTimer

func on_enter() -> void:
	construction_timer.start()

func on_exit() -> void:
	pass

func _on_construction_timer_timeout() -> void:
	state_changed.emit(next_state)
