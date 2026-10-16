extends Node2D

## Distance from the middle of the wheel to each cabin, in pixels.
@export var radius: float = 80.0
## How fast the wheel turns, in turns per second.
@export var turns_per_second: float = 0.05

var _angle: float = 0.0

@onready var _wheel: Node2D = $Visual/Wheel
@onready var _cabins: Array[Node] = $Cabins.get_children()


func _ready() -> void:
	_place_cabins()


func _physics_process(delta: float) -> void:
	_angle += TAU * turns_per_second * delta
	_wheel.rotation = _angle
	_place_cabins()


## Puts the cabins around the wheel, always hanging straight down.
func _place_cabins() -> void:
	for i in _cabins.size():
		var cabin := _cabins[i] as Node2D
		var cabin_angle := _angle + TAU * i / _cabins.size()
		cabin.position = Vector2.RIGHT.rotated(cabin_angle) * radius
