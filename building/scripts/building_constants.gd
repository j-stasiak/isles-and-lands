extends Node

enum BuildingType {
	CASTLE,
	HOUSE
}

enum BuildingState {
	CONSTRUCTION,
	ACTIVE,
	DESTROYED
}

const BUILDING_CONFIGURATION = {
	BuildingType.CASTLE: CASTLE_RESOURCES,
	BuildingType.HOUSE: HOUSE_RESOURCES
}

const CASTLE_RESOURCES: Dictionary[BuildingConstants.BuildingState, String] = {
	BuildingState.CONSTRUCTION: "res://building/art/Castle_Construction.png",
	BuildingState.ACTIVE: "res://building/art/Castle_Blue.png",
	BuildingState.DESTROYED: "res://building/art/Castle_Destroyed.png"
}

const HOUSE_RESOURCES: Dictionary[BuildingConstants.BuildingState, NodePath] = {
	BuildingState.CONSTRUCTION: "res://building/art/House_Construction.png",
	BuildingState.ACTIVE: "res://building/art/House_Blue.png",
	BuildingState.DESTROYED: "res://building/art/House_Destroyed.png"
}
