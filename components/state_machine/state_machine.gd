extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State

func _ready() -> void:
	if initial_state != null:
		change_state(initial_state)

func change_state(new_state: State):
	if current_state != null:
		current_state.state_changed.disconnect(_on_state_changed)
		current_state.on_exit()

	new_state.on_enter()
	current_state = new_state
	current_state.state_changed.connect(_on_state_changed)

func _on_state_changed(new_state: State):
	change_state(new_state)
