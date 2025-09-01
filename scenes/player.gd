extends Area2D

class_name Player

signal isHit
signal iframeTimeout

@onready var camera: Camera2D = $Camera2D
@onready var hitbox: CollisionShape2D = $PlayerHitbox
@onready var iframes: Timer = $IFrameTimer

var screen_size = 0
var speed = 400
var is_dead = false

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
	if is_dead == false:
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, Vector2(1152, 4564))
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
	hitbox.disabled = false


func _on_body_entered(body: Node2D) -> void:
	isHit.emit()
	iframes.start()
	hitbox.set_deferred("disabled", true) # Prevent issues.


func _on_i_frame_timer_timeout() -> void:
	iframeTimeout.emit()
