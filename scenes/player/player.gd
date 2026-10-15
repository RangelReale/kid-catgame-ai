extends CharacterBody2D

## Horizontal speed, in pixels per second.
@export var speed: float = 120.0
## Upward speed at the start of a jump, in pixels per second.
@export var jump_speed: float = 300.0
## Downward acceleration, in pixels per second squared.
@export var gravity: float = 900.0
## Time the somersault takes during a jump, in seconds.
@export var flip_duration: float = 0.5

## Point the somersault turns around: the middle of the cat.
const FLIP_PIVOT := Vector2(0, -8)

## Seconds since the somersault started; negative when not flipping.
var _flip_time: float = -1.0

@onready var _visual: Node2D = $Visual


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		_flip_time = 0.0

	velocity.x = Input.get_axis("move_left", "move_right") * speed

	move_and_slide()
	_update_flip(delta)


func _update_flip(delta: float) -> void:
	var angle := 0.0
	if _flip_time >= 0.0:
		_flip_time += delta
		var progress := _flip_time / flip_duration
		if progress >= 1.0 or is_on_floor():
			_flip_time = -1.0
		else:
			angle = TAU * progress
	_visual.rotation = angle
	_visual.position = FLIP_PIVOT - FLIP_PIVOT.rotated(angle)
