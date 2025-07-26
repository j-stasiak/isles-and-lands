extends Node2D

@export var building_types: Dictionary[BuildingConstants.BuildingType, PackedScene]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("build_castle"):
		add_building(BuildingConstants.BuildingType.CASTLE)

	if Input.is_action_just_pressed("build_house"):
		add_building(BuildingConstants.BuildingType.HOUSE)

func add_building(type: BuildingConstants.BuildingType):
	var building: PackedScene = building_types.get(type)
	var building_instance = building.instantiate()

	$Map/TileMapLayer.add_child(building_instance)
	building_instance.get_node("Building").unit_spawned.connect(_on_unit_spawned)

	var obstacle: NavigationObstacle2D = building_instance.get_node("NavigationObstacle2D")
	NavigationServer2D.obstacle_set_map(obstacle.get_rid(), $Map/TileMapLayer.get_navigation_map())

func _on_unit_spawned(type: String, spawn_point: Vector2):
	var unit: Troop = load("res://entities/troops/troop.tscn").instantiate()
	$Map/TileMapLayer.add_child(unit)
	unit.spawn(type, spawn_point)
