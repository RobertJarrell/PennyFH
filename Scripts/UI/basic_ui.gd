extends CanvasLayer

@export var game_data : GameData

@onready var score_label = $PanelContainer/MarginContainer/HeadBoard/ScoreLabel
@onready var attempt_label = $PanelContainer/MarginContainer/AttemptTracker/AttemptLabel
@onready var combo_label = $PanelContainer/MarginContainer/ComboLabel
@onready var game_over_label = $PanelContainer/MarginContainer/GameOverLabel
@onready var win_label = $PanelContainer/MarginContainer/WinLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	game_data.score_changed.connect(_update_score_label)
	game_data.player_attempts_changed.connect(_update_attempt_label)
	GameEvent.combo_counter_changed.connect(_update_combo_label)
	GameEvent.game_end.connect(_end_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_score_label(new_score : int):
	score_label.text = "Score: " + str(new_score)
	

func _update_combo_label(new_multiplier : int):
	combo_label.text = "x " + str(new_multiplier)
	

func _update_attempt_label(new_count : int):
	attempt_label.text = "x " + str(new_count)
	

func _end_screen():
	if GameEvent.game_over:
		game_over_label.visible = true
	else:
		win_label.visible = true
	
