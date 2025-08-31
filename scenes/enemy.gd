extends RigidBody2D

# Simple variable to keep me from having to do too much effort
# Easier to use a switch statement for movement than make subclasses
# 0 = stationary, 1 = horizontal movement
# 2 = vertical movement, 3 = circular movement?
var enemy_type = 0 

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() #TODO: set this to a timer and/or distance variable
