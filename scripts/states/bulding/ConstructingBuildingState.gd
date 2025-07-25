extends BuildingState
class_name ConstructingBuildingState

var current_building_time : float = 0.0

func enter():
	building.sprite.texture = building.construction_texture
	building.sprite.modulate = Color.WHITE
	current_building_time = building.building_time

func process(delta):
	current_building_time -= delta

	if current_building_time > 0.0:
		return
	
	state_finished.emit()