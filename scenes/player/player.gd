extends CharacterBody2D

## Horizontal speed, in pixels per second.
@export var speed: float = 120.0
## Upward speed at the start of a jump, in pixels per second.
@export var jump_speed: float = 300.0
## Downward acceleration, in pixels per second squared.
@export var gravity: float = 900.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed

	velocity.x = Input.get_axis("move_left", "move_right") * speed

	move_and_slide()
