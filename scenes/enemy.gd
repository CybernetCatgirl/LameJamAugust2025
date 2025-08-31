extends RigidBody2D

enum EnemyType{NO_MOVE, HORI_MOVE, VERT_MOVE, CIRCLE_MOVE}

@export var enemy_type: EnemyType = EnemyType.NO_MOVE

func _ready():
	var mob_types = Array($EnemySprite.sprite_frames.get_animation_names())
	
	#Determine animation type by enemy_type enum.
	if enemy_type == EnemyType.VERT_MOVE:
		$EnemySprite.animation = "vertical"
	else:
		$EnemySprite.animation = "stationary"
	
	$EnemySprite.play()

#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free() #TODO: set this to a timer and/or distance variable
