class_name ItemMoveComponent

extends Node

@export var sheet : ItemSheet
@export var model : Node3D

var speed
var min_fall_speed : float = 0
var max_fall_speed : float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var varied_speed = randf_range(min_fall_speed, max_fall_speed)
	speed = sheet.fall_speed + varied_speed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)


func move(delta):
	model.global_position.y = lerp(model.global_position.y, -speed * delta, delta)
