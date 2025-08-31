extends Node2D

@export var stationary_mob: PackedScene
@export var horizontal_mob: PackedScene
@export var vertical_mob: PackedScene
@export var circular_mob: PackedScene

func _ready():
	$Player.position = $StartPosition.position
