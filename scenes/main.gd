extends Node

## The level loaded when the game starts.
@export var first_level: PackedScene


func _ready() -> void:
	if first_level != null:
		add_child(first_level.instantiate())
