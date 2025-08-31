extends Area2D

signal isHit

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
	position = position.clamp(Vector2.ZERO, screen_size) # Let's see how this plays w/ camera later
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
