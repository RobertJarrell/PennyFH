class_name SpawnComponent

extends Node3D

@export var packed_scene : PackedScene



func spawn_new_item(spawn_location : Vector3 = global_position, parent : Node = get_tree().current_scene) -> Node:
	assert(packed_scene is PackedScene, "Error: The scene export was never set on this spawner component")
	var instance = packed_scene.instantiate()
	parent.add_child(instance)
	instance.global_position = spawn_location
	return instance
