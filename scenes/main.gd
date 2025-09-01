extends Node2D

@onready var player: Player = $Player
@onready var oxygen_timer: Timer = $OxygenTimer
@onready var stats: HUD = $HUD

@export var enemy: PackedScene

var oxygen = 100
var can_surface = false

func _ready():
	stats.oxy.hide()
	$HUD/DepthMeter.hide()
	$HUD/MaxDepthMeter.hide()
	player.hide()
	player.is_dead = true

func new_game():
	stats.oxy.show()
	oxygen = 100
	stats.update_oxygen(100)
	stats.show_msg("Dive deep and resurface!")
	can_surface = false
	player.is_dead = false
	player.start($StartPosition.position)
	$StartTimer.start()

func game_over():
	oxygen_timer.stop()
	player.hide()
	player.hitbox.disabled = true
	player.iframes.stop()
	player.is_dead = true
	stats.show_game_over()
	oxygen_timer.stop() # Maybe THIS will make it work
	pass # Replace with function body.

func _on_oxygen_timer_timeout() -> void:
	reduce_oxygen(1)

func _on_start_timer_timeout() -> void:
	oxygen_timer.start()
	$StartTimer.stop()

func reduce_oxygen(reduction):
	if reduction > oxygen:
		oxygen = 0
	else:
		oxygen -= reduction
	stats.update_oxygen(oxygen)
	if oxygen <= 0:
		oxygen_timer.stop()
		game_over()

func _on_player_is_hit() -> void:
	if oxygen >= 1:
		reduce_oxygen(10)


func _start_button_selected() -> void:
	new_game()


func _on_lower_goal_area_entered(area: Area2D) -> void:
	if area == player && can_surface == false:
		can_surface = true
		stats.show_msg("You hit the bottom! Get to the surface!")

func _on_upper_bound_area_entered(area: Area2D) -> void:
	if area == player && can_surface == true:
		oxygen_timer.stop()
		stats.show_game_won()
		player.hide()
		player.hitbox.disabled = true
		player.iframes.stop()
		oxygen_timer.stop()
		player.is_dead = true

func _on_player_iframe_timeout() -> void:
	player.iframes.stop()
	if(oxygen >= 1):
		player.hitbox.disabled = false
