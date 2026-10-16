extends Node2D

## How far the horses go to each side of the middle, in pixels.
@export var radius: float = 55.0
## How fast the carousel turns, in turns per second.
@export var turns_per_second: float = 0.12
## How far each horse goes up and down while it turns, in pixels.
@export var bob_height: float = 6.0

var _angle: float = 0.0

@onready var _horses: Array[Node] = $Horses.get_children()


func _ready() -> void:
	_place_horses()


func _physics_process(delta: float) -> void:
	_angle += TAU * turns_per_second * delta
	_place_horses()


## Moves the horses around the carousel. Seen from the side, they go left and
## right; the ones in the back are drawn behind the pole.
func _place_horses() -> void:
	for i in _horses.size():
		var horse := _horses[i] as Node2D
		var horse_angle := _angle + TAU * i / _horses.size()
		horse.position = Vector2(cos(horse_angle) * radius, sin(horse_angle * 3.0) * bob_height)
		horse.z_index = 1 if sin(horse_angle) > 0.0 else -1
		var visual := horse.get_node("Visual") as Node2D
		visual.scale.x = -1.0 if sin(horse_angle) > 0.0 else 1.0
