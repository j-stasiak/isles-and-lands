extends Node2D

@export_category("Exportables")
@export var castle_scene : PackedScene

var currently_held_building : Building = null

func _input(event : InputEvent):
	if not event is InputEventKey:
		return

	if currently_held_building:
		return
	
	if event.is_action_pressed("build_castle"):
		spawn_building(castle_scene)

func spawn_building(scene : PackedScene):
	currently_held_building = GH.spawn(scene, get_global_mouse_position()) as Building
	currently_held_building.building_placed.connect(on_building_placed)	

func on_building_placed():
	currently_held_building = null
