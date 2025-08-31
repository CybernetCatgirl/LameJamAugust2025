extends Area2D

class_name CameraLimiter

enum LimitX{NONE, LEFT, RIGHT}
enum LimitY{NONE, TOP, BOTTOM}

const MAX_VAL = 10000000

@export var limit_x: LimitX = LimitX.NONE
@export var limit_y: LimitY = LimitY.NONE
