extends RigidBody2D

class_name Enemy

enum EnemyType{NO_MOVE, HORI_MOVE, VERT_MOVE}

@onready var sprite: AnimatedSprite2D = $EnemySprite
@onready var hitbox: CollisionShape2D = $EnemyHitbox
@onready var reverse_timer: Timer = $DirectionReverseTimer

@export var enemy_type: EnemyType = EnemyType.NO_MOVE

var sign = 1
var SPEED = 350

func _process(delta: float):
	if enemy_type == EnemyType.VERT_MOVE:
		position.y += SPEED * delta * sign
	elif enemy_type == EnemyType.HORI_MOVE:
		position.x += SPEED * delta * sign

func _ready():
	var mob_types = Array(sprite.sprite_frames.get_animation_names())
	
	#Determine animation type by enemy_type enum.
	if enemy_type == EnemyType.VERT_MOVE:
		sprite.animation = "vertical"
		reverse_timer.start()
	elif enemy_type == EnemyType.HORI_MOVE:
		sprite.animation = "horizontal"
		reverse_timer.start()
	else:
		sprite.animation = "stationary"
	
	sprite.play()


func _on_direction_reverse_timer_timeout() -> void:
	sign *= -1
