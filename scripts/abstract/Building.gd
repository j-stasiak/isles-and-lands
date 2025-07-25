extends StaticBody2D
class_name Building

signal building_placed

@export_category("Values")
@export var base_health: float = 100
@export var recruitment_time: float = 1.5
@export var default_recruitment_queue : Array[PackedScene] = []
@export var building_time : float = 0.5

@export_category("Exportables")
@export var construction_texture: Texture2D
@export var active_texture: Texture2D
@export var destroyed_texture: Texture2D

@export_group("Local")
@export var spawn_point: Marker2D
@export var sprite: Sprite2D
@export var navigation_obstacle: NavigationObstacle2D

var placing_building_state : PlacingBuildingState = PlacingBuildingState.new()
var constructing_building_state : ConstructingBuildingState = ConstructingBuildingState.new()
var active_building_state : RecruitingBuildingState = RecruitingBuildingState.new()			
var idle_building_state : IdleBuildingState = IdleBuildingState.new()
var destroyed_building_state : DestroyedBuildingState = DestroyedBuildingState.new()

var recruitment_queue : Array[PackedScene]

var current_state : BuildingState :
	set(new_state):
		if current_state:
			current_state.exit()
		
		current_state = new_state
		current_state.building = self
		current_state.enter()

func _ready(): 
	current_state = placing_building_state
	recruitment_queue = default_recruitment_queue.duplicate()

	constructing_building_state.state_finished.connect(on_constructing_finished)
	active_building_state.state_finished.connect(on_active_building_state)

func _process(delta):
	current_state.process(delta)

func _input(event):
	if event.is_action_pressed("place_building"):
		current_state = constructing_building_state
		set_process_input(false)

func on_constructing_finished():
	current_state = active_building_state

func on_active_building_state():
	current_state = idle_building_state
