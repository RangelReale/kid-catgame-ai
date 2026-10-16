extends Node2D

## How fast the rays turn, in radians per second.
@export var ray_speed: float = 0.3

@onready var _rays: Node2D = $Visual/Rays


func _process(delta: float) -> void:
	_rays.rotation += ray_speed * delta
