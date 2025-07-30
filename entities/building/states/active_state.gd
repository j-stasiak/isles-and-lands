extends State
class_name ActiveState

@export var sprite: Sprite2D
@export var active_texture: Texture2D

@onready var troop_spawner: TroopSpawner = $"../../TroopSpawner"

func on_enter():
	sprite.texture = active_texture

	if troop_spawner != null:
		troop_spawner.schedule_troop_creation()
