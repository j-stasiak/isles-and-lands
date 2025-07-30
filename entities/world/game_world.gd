extends Node2D

@export var building_types: Dictionary[BuildingConstants.BuildingType, PackedScene]

var actions_to_building_types_map: Dictionary[StringName, BuildingConstants.BuildingType] = {
	&"build_castle": BuildingConstants.BuildingType.CASTLE,
	&"build_house": BuildingConstants.BuildingType.HOUSE
}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var actions = actions_to_building_types_map.keys()

	for action in actions:
		if Input.is_action_just_pressed(action):
			add_building(actions_to_building_types_map[action])

func add_building(type: BuildingConstants.BuildingType):
	var building: PackedScene = building_types.get(type)
	var building_instance = building.instantiate()

	$Map/TileMapLayer.add_child(building_instance)

	var obstacle: NavigationObstacle2D = building_instance.get_node("NavigationObstacle2D")
	NavigationServer2D.obstacle_set_map(obstacle.get_rid(), $Map/TileMapLayer.get_navigation_map())
