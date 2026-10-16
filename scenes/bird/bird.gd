extends Area2D

## Emitted once, when the bird touches the cat.
signal caught

## How far the bird flies from where it starts, and in which direction, in
## pixels. It goes back and forth between -travel and +travel.
@export var travel: Vector2 = Vector2(0, 60)
## Back-and-forth trips per second.
@export var trips_per_second: float = 0.3
## Where in its trip the bird starts, from 0 to 1.
@export_range(0.0, 1.0) var phase: float = 0.0
## Wing flaps per second.
@export var flaps_per_second: float = 4.0

var _start: Vector2
var _time: float = 0.0
var _caught: bool = false

@onready var _visual: Node2D = $Visual
@onready var _wing: Node2D = $Visual/Wing


func _ready() -> void:
	add_to_group("catcher")
	_start = position
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	_time += delta
	var angle := TAU * (_time * trips_per_second + phase)
	var previous_x := position.x
	position = _start + travel * sin(angle)
	if position.x != previous_x:
		_visual.scale.x = signf(previous_x - position.x)
	_wing.rotation = 0.6 * sin(TAU * _time * flaps_per_second)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not _caught:
		_caught = true
		caught.emit()
