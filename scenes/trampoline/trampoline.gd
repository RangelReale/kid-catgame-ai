extends Area2D

## Upward speed the cat gets when it lands on the trampoline, in pixels per
## second.
@export var bounce_speed: float = 480.0

@onready var _mat: Node2D = $Visual/Mat


func _physics_process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is Player and body.velocity.y >= 0.0:
			body.bounce(bounce_speed)
			_mat.position.y = 3.0
			create_tween().tween_property(_mat, "position:y", 0.0, 0.2)
