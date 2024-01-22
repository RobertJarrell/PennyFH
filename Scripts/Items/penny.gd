class_name Collectable

extends Node3D

@onready var shadow_spawner = $ShadowSpawner as SpawnComponent

var shadow : Node
var just_entered : bool = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if just_entered:
		_spawn_shadow()
		just_entered = false
		



func _spawn_shadow():
	var space_state = get_world_3d().direct_space_state
	var spawn_range = position + Vector3(0,-10,0)
	var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(position, spawn_range,1,[self]))
	var shadow_position = Vector3.ZERO
	
	if result:
		shadow_position = result["position"]
	
	shadow = shadow_spawner.spawn_new_item(shadow_position)
	
func clean_up():
	shadow.queue_free()
	queue_free()
