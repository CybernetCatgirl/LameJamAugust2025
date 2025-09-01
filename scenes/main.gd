extends Node2D

@onready var player: Player = $Player
@onready var oxygen_timer: Timer = $OxygenTimer
@onready var stats: HUD = $HUD

@export var enemy: PackedScene

var oxygen = 100

func _ready():
	new_game()

func new_game():
	oxygen = 100
	stats.update_oxygen(100)
	player.start($StartPosition.position)
	$StartTimer.start()

func game_over():
	oxygen_timer.stop()
	pass # Replace with function body.

func _on_oxygen_timer_timeout() -> void:
	reduce_oxygen(1)

func _on_start_timer_timeout() -> void:
	oxygen_timer.start()

func reduce_oxygen(reduction):
	if reduction > oxygen:
		oxygen = 0
	else:
		oxygen -= reduction
	stats.update_oxygen(oxygen)
	if oxygen <= 0:
		game_over()

func _on_player_is_hit() -> void:
	reduce_oxygen(10)
