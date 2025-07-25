extends BuildingState
class_name PlacingBuildingState

func enter():
	building.sprite.texture = building.active_texture
	building.sprite.modulate = Color.GREEN

func process(_delta):
	var mouse_pos = building.get_global_mouse_position()
	building.global_position = mouse_pos

func exit():
	NavigationServer2D.obstacle_set_map(building.navigation_obstacle.get_rid(), Globals.map.tile_map_layer.get_navigation_map())
	building.building_placed.emit()
