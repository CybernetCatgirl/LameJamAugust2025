extends Area2D

class_name Player

signal isHit

@onready var camera: Camera2D = $Camera2D
@onready var lower_spawn: Path2D = $PathLower
@onready var upper_spawn: Path2D = $PathUpper
@onready var hitbox: CollisionShape2D = $PlayerHitbox

var screen_size = 0
var speed = 400
var iframes = 0
var iframes_max = 120

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
	position += velocity * delta
	if velocity.x != 0:
		$PlayerSprite.animation = "right"
		$PlayerSprite.flip_v = false
		$PlayerSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$PlayerSprite.animation = "up"
		$PlayerSprite.flip_v = velocity.y > 0

func start(pos):
	position = pos
	show()
	$PlayerHitbox.disabled = false
