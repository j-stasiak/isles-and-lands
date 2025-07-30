extends Node
class_name State

signal state_changed(new_state: State)

func _ready() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)

func on_enter():
	set_physics_process(true)
	set_process_unhandled_input(true)

func on_exit():
	set_physics_process(false)
	set_process_unhandled_input(false)
