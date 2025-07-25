extends Node2D
class_name Map

@export_group("Local")
@export var tile_map_layer : TileMapLayer

func _ready():
    Globals.map = self