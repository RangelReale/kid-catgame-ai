extends Node2D

## How fast the cloud drifts to the right, in pixels per second.
@export var speed: float = 6.0

## Half the cloud's width, so it leaves the screen fully before coming back.
const HALF_WIDTH := 30.0


func _process(delta: float) -> void:
	position.x += speed * scale.x * delta
	if position.x - HALF_WIDTH * scale.x > get_viewport_rect().size.x:
		position.x = -HALF_WIDTH * scale.x
