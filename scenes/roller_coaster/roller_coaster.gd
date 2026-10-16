extends Path2D

## How fast the cart rides along the track, in pixels per second.
@export var speed: float = 110.0
## Seconds the cart waits at each end of the track, so the cat can get in.
@export var wait_at_ends: float = 1.5

var _progress: float = 0.0
var _direction: float = 1.0
var _waiting: float = 0.0

@onready var _cart: Node2D = $Cart


func _ready() -> void:
	_cart.position = curve.sample_baked(0.0)


## Moves the cart along the track, back and forth. The cart is moved directly,
## not through a PathFollow2D, so its collision moves with it.
func _physics_process(delta: float) -> void:
	if _waiting > 0.0:
		_waiting -= delta
		return
	var length := curve.get_baked_length()
	_progress += speed * _direction * delta
	if _progress >= length or _progress <= 0.0:
		_progress = clampf(_progress, 0.0, length)
		_direction = -_direction
		_waiting = wait_at_ends
	_cart.position = curve.sample_baked(_progress)
