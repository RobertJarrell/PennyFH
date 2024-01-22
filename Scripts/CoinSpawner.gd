class_name CoinSpawner

extends Node3D

@export var level_sheet : LevelData

var item_spawner : SpawnComponent
var spawn_count : int 
var min_spawn_range : float
var max_spawn_range : float
var min_spawn_time : float 
var max_spawn_time : float
var spawn_pool : int
var spawn_array : Array[SpawnComponent] 

var active_spawns : int = 0
var current_multiplier : int = 1

@onready var spawn_timer : Timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_count = level_sheet.spawn_count
	min_spawn_range = level_sheet.min_spawn_range
	max_spawn_range = level_sheet.max_spawn_range
	min_spawn_time = level_sheet.min_spawn_time
	max_spawn_time = level_sheet.max_spawn_time
	spawn_pool = level_sheet.spawn_pool
	
	spawn_array.resize(spawn_pool)
	
	var i = 0
	
	for child in get_children():
		if child is SpawnComponent:
			spawn_array[i] = child
			i += 1
	
	GameEvent.combo_counter_changed.connect(_set_multiplier)
	GameEvent.item_collected.connect(_reduce_active_spawns)
	GameEvent.item_dropped.connect(_reduce_active_spawns)
	spawn_timer.timeout.connect(_spawn)
	
	spawn_timer.start(randf_range(min_spawn_time, max_spawn_time))
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn_count == 0 and active_spawns == 0:
		GameEvent.game_end.emit()
	

func _set_multiplier(value):
	current_multiplier = value
	
func pick_random_spawner(range) -> int:
	var spawner_key = randi_range(0, range - 1)
	return spawner_key

func set_item_spawner(range):
	item_spawner = spawn_array[pick_random_spawner(range)]
	pass

func get_random_x() -> float:
	var x = randf_range(min_spawn_range, max_spawn_range)
	return x
	
func get_random_z() -> float:
	var z = randf_range(min_spawn_range, max_spawn_range)
	return z

func _spawn():
	spawn_count -= 1
	
	set_item_spawner(current_multiplier)
	
	var x = get_random_x()
	var z = get_random_z()
	var item_spawn_location : Vector3 = Vector3(x, 10, z)
	
	item_spawner.spawn_new_item(item_spawn_location)
	
	_increase_active_spawns()
	
	if spawn_count > 0:
		spawn_timer.start(randf_range(min_spawn_time, max_spawn_time))
		

func _reduce_active_spawns(_value):
	active_spawns -= 1
	

func _increase_active_spawns():
	active_spawns += 1
	
