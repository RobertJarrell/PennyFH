class_name CollectBox

extends Area3D

@export var sheet : ItemSheet
@export var model : Collectable
var collect_value

# Called when the node enters the scene tree for the first time.
func _ready():
	collect_value = sheet.value
	body_entered.connect(check_collision)


func check_collision(body):
	print("body entered")
	if body is PlayerToken:
		GameEvent.item_collected.emit(collect_value)
		print("coin collected")
	else:
		GameEvent.item_dropped.emit(-collect_value)
	
	model.clean_up()
	
