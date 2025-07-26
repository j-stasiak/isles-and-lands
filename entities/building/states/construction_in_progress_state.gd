extends State
class_name ConstructionInProgressState

signal construction_done

@export var building: Building
@onready var construction_timer: Timer = $"../../ConstructionTimer"

func on_enter() -> void:
	construction_timer.start()

func on_exit() -> void:
	pass


func _on_construction_timer_timeout() -> void:
	construction_done.emit()
