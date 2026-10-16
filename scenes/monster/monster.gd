extends Area2D

## Walking speed, in pixels per second.
@export var speed: float = 25.0
## How far the monster walks to each side of where it starts, in pixels.
@export var walk_distance: float = 60.0

## How far above the monster's feet the cat's feet must be to count as
## landing on top, in pixels.
const STOMP_HEIGHT := 6.0

var _start_x: float
var _direction: float = 1.0
var _popped: bool = false

@onready var _visual: Node2D = $Visual
@onready var _poof: CPUParticles2D = $Poof


func _ready() -> void:
	_start_x = position.x
	_poof.finished.connect(queue_free)


func _physics_process(delta: float) -> void:
	if _popped:
		return

	position.x += speed * _direction * delta
	if absf(position.x - _start_x) >= walk_distance:
		position.x = _start_x + walk_distance * _direction
		_direction = -_direction
	_visual.scale.x = _direction

	for body in get_overlapping_bodies():
		if body is Player and _is_landed_on(body):
			_pop(body)
			return


func _is_landed_on(player: Player) -> bool:
	return player.velocity.y > 0.0 \
		and player.global_position.y < global_position.y - STOMP_HEIGHT


## Turns the monster into a puff of sparkles and bounces the cat up.
func _pop(player: Player) -> void:
	_popped = true
	_visual.hide()
	player.bounce()
	_poof.emitting = true
