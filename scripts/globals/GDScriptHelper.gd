extends Node

func tween(object : Object, property : NodePath, amount : Variant, duration : float) -> Tween:
	if object == null:
		return
	
	var tween_object = create_tween()
	tween_object.tween_property(object, property, amount, duration)
	
	return tween_object

func find_child_of_type(node : Node, child_type : String) -> Node:
	var children = node.find_children("*", child_type)
	if children.size() != 0:
		return children[0]
	else:
		return null

func find_component(node : Node, child_type : String) -> Node:
	return find_child_of_type(node, child_type)

func wait(time : float):
	await create_timer(time).timeout

func spawn(scene : PackedScene, position : Vector2) -> Node2D:
	var instance = scene.instantiate()
	instance.global_position = position
	get_tree().root.add_child.call_deferred(instance)

	return instance

func spawn_parentless(scene : PackedScene, position : Vector2) -> Node2D:
	var instance = scene.instantiate()
	instance.global_position = position

	return instance

func get_random_position_in_area(area : Area2D) -> Vector2:
	var shape = area.get_node("CollisionShape2D").shape
	var origin = area.global_position

	var extents = shape.extents
	
	return origin + Vector2(
		randf_range(-extents.x, extents.x),
		randf_range(-extents.y, extents.y)
	)

func create_timer(time : float):
	return get_tree().create_timer(time)

func unmute_audio_bus(bus_name : String):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), false)

func mute_audio_bus(bus_name : String):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), true)

func change_parent(node : Node, new_parent : Node):
	node.get_parent().remove_child(node)
	new_parent.add_child.call_deferred(node)

func get_random_direction():
	var angle = randf() * TAU
	return Vector2(cos(angle), sin(angle))
