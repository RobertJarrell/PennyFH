class_name  LevelManager

extends Node

@export var game_data : GameData
@export var level_sheet : LevelData

var items_caught : int = 0
var target_score : int 
var current_score : int
var current_combo : int
var attempts_left : int



# Called when the node enters the scene tree for the first time.
func _ready():
	current_score = game_data.score
	current_combo = game_data.combo_counter
	attempts_left = game_data.player_attempts
	target_score = level_sheet.target_score
	
	GameEvent.item_collected.connect(_update_score)
	GameEvent.item_dropped.connect(_update_score)
	GameEvent.game_end.connect(_game_over)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_score(value):
	if value > 0:
		items_caught += 1
	elif value <= 0:
		items_caught = 0
		
	current_score += value * current_combo
	#emit score change signal
	game_data.score_changed.emit(current_score)
	
	_update_combo_counter()
	

func _update_attempts():
	attempts_left -= 1
	
	#emit attempts signal
	game_data.player_attempts_changed.emit(attempts_left)
	

func _update_combo_counter():
	if items_caught == 0:
		current_combo = 1
		#emit combo update signal
		GameEvent.combo_counter_changed.emit(current_combo)
	elif items_caught == 10:
		current_combo += 1
		if current_combo > 6:
			current_combo = 6
			return
		items_caught = 0
		#emit combo update signal
		GameEvent.combo_counter_changed.emit(current_combo)
	

func _game_over():
	if current_score >= target_score:
		pass
	elif current_score < target_score:
		if attempts_left > 0:
			_update_attempts()

		else: 
			GameEvent.game_over = true
	
	
