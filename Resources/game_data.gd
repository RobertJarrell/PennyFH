class_name GameData

extends Resource

@export var score : int = 0 :
	set(value):
		score = value
@export var high_score : int = 0
@export var combo_counter : int = 1 :
	set(value):
		combo_counter = value
@export var player_attempts : int = 3 :
	set(value):
		player_attempts = value

signal score_changed(new_score)

signal player_attempts_changed(new_count)
