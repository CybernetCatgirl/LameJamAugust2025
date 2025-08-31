extends Node2D

@onready var player: Player = $Player
@onready var upper_path: PathFollow2D = player.upper_spawn_point
@onready var lower_path: PathFollow2D = player.lower_spawn_point
@onready var upper_timer: Timer = $MobTimerUpper
@onready var lower_timer: Timer = $MobTimerLower
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
	get_tree().call_group("enemies", "queue_free") # This SHOULD clear enemies on game start
	$StartTimer.start()

func game_over():
	oxygen_timer.stop()
	lower_timer.stop()
	upper_timer.stop()
	pass # Replace with function body.

# ALL OF THIS is a MUCH simpler, torn-open section from the Godot 4 "Dodge the Creeps!" tutorial
# Sure, it uses two paths, but I also don't need to choose a direction.
func _on_mob_timer_upper_timeout() -> void:
	var mob = enemy.instantiate()
	upper_path.progress_ratio = randf()
	mob.position = upper_path.position
	add_child(mob)
func _on_mob_timer_lower_timeout() -> void:
	var mob = enemy.instantiate()
	lower_path.progress_ratio = randf()
	mob.position = lower_path.position
	add_child(mob)

func _on_oxygen_timer_timeout() -> void:
	reduce_oxygen(1)


func _on_start_timer_timeout() -> void:
	upper_timer.start()
	lower_timer.start()
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
