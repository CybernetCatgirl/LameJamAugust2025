extends CanvasLayer

class_name HUD

signal starting_game

@onready var start_button: Button = $StartGameButton
#@onready var depth: Label = $DepthMeter
#@onready var hi_score: Label = $MaxDepthMeter
@onready var oxy: Label = $OxygenCount
@onready var msg: Label = $MessageLabel
@onready var msg_timer: Timer = $MessageTimer

var max_depth = 0

func ready():
	oxy.hide()
	$DepthMeter.hide()
	$MaxDepthMeter.hide()

func update_oxygen(remaining):
	oxy.text = ("Oxygen: " + str(remaining) + "%")

#func update_depth(depth):
#	depth.text = ("Current Depth: " + str(depth) + "m")
#	if depth > max_depth:
#		max_depth = depth
#		hi_score.text = ("Maximum Depth: " + str(depth) + "m")

func show_msg(text):
	msg.text = text
	msg.show()
	msg_timer.start()

func show_game_over():
#	depth.hide()
#	hi_score.hide()
	oxy.hide()
	show_msg("You drowned...")
	await msg_timer.timeout
	msg_timer.stop()
	msg.text = "Deep Delve"
	msg.show()
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func show_game_won():
#	depth.hide()
#	hi_score.hide()
	oxy.hide()
	show_msg("Congratulations! You dove deep and lived to resurface!")
	await msg_timer.timeout
	msg_timer.stop()
	msg.text = "Deep Delve"
	msg.show()
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func _on_start_game_button_pressed() -> void:
	start_button.hide()
	starting_game.emit()

func _on_message_timer_timeout() -> void:
	msg.hide()
