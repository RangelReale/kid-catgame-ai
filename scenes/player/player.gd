class_name Player
extends CharacterBody2D

## Horizontal speed, in pixels per second.
@export var speed: float = 120.0
## Upward speed at the start of a jump, in pixels per second.
@export var jump_speed: float = 300.0
## Downward acceleration, in pixels per second squared.
@export var gravity: float = 900.0
## Extra jumps the cat can do in the air with its wings, before landing.
@export var air_jumps: int = 3
## Upward speed at the start of each wing flap, in pixels per second.
@export var flap_speed: float = 250.0
## Upward speed after landing on a monster, in pixels per second.
@export var bounce_speed: float = 220.0
## Time the somersault takes during a jump, in seconds.
@export var flip_duration: float = 0.5

## Point the somersault turns around: the middle of the cat.
const FLIP_PIVOT := Vector2(0, -8)

## Seconds since the somersault started; negative when not flipping.
var _flip_time: float = -1.0
## Wing flaps left before the cat touches the floor again.
var _air_jumps_left: int = 0

@onready var _visual: Node2D = $Visual
@onready var _jump_sound: AudioStreamPlayer = $JumpSound


func _physics_process(delta: float) -> void:
	if is_on_floor():
		_air_jumps_left = air_jumps
	else:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed
			_flip_time = 0.0
			_play_jump_sound(1.0)
		elif _air_jumps_left > 0:
			velocity.y = -flap_speed
			_air_jumps_left -= 1
			_play_jump_sound(1.0 + 0.15 * (air_jumps - _air_jumps_left))

	velocity.x = Input.get_axis("move_left", "move_right") * speed

	move_and_slide()
	_update_flip(delta)


## Plays the "boing"; each wing flap sounds a little higher.
func _play_jump_sound(pitch: float) -> void:
	_jump_sound.pitch_scale = pitch
	_jump_sound.play()


## Makes the cat hop up, as when it lands on a monster.
func bounce() -> void:
	velocity.y = -bounce_speed
	_flip_time = 0.0


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
