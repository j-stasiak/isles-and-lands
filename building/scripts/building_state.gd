class_name BuildingState

## Key: State Name, Value: Path to building img
signal state_changed(new_state: BuildingConstants.BuildingState)
var current_state: BuildingConstants.BuildingState

func change_state(new_state: BuildingConstants.BuildingState):
	if current_state != new_state:
		current_state = new_state
		emit_signal("state_changed", current_state)
