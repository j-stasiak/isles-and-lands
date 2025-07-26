extends State
class_name ActiveState

@export var building: Building

func on_enter():
	building.sprite.texture = building.active_texture
