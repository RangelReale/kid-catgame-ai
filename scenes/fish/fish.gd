extends Area2D

## Swimming speed, in pixels per second.
@export var speed: float = 20.0
## How far the fish swims to each side of where it starts, in pixels.
@export var swim_distance: float = 30.0
## Seconds before a caught fish comes back to the water.
@export var respawn_time: float = 3.0

var _start_x: float
var _direction: float = 1.0
var _caught: bool = false

@onready var _visual: Node2D = $Visual
@onready var _sparkles: CPUParticles2D = $Sparkles


func _ready() -> void:
	_start_x = position.x
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if _caught:
		return
	position.x += speed * _direction * delta
	if absf(position.x - _start_x) >= swim_distance:
		position.x = _start_x + swim_distance * _direction
		_direction = -_direction
	_visual.scale.x = _direction


## The cat caught the fish: it jumps out in sparkles and comes back later.
func _on_body_entered(body: Node2D) -> void:
	if not body is Player or _caught:
		return
	_caught = true
	_visual.hide()
	_sparkles.restart()
	get_tree().create_timer(respawn_time).timeout.connect(_come_back)


func _come_back() -> void:
	_caught = false
	_visual.show()
	# Lets a cat that is still touching the fish catch it again.
	for body in get_overlapping_bodies():
		_on_body_entered(body)
