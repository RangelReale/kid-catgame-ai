extends Node2D

## How high the seat goes, in pixels above the ground.
@export var height: float = 170.0
## How fast the seat goes up, in pixels per second.
@export var rise_speed: float = 40.0
## How fast the seat comes down, in pixels per second. Fast, but not scary.
@export var drop_speed: float = 160.0
## Seconds the seat waits at the top and at the bottom.
@export var wait_time: float = 1.5

enum State { WAITING_DOWN, RISING, WAITING_UP, DROPPING }

var _state: State = State.WAITING_DOWN
var _timer: float = 0.0

@onready var _seat: Node2D = $Seat


func _physics_process(delta: float) -> void:
	match _state:
		State.WAITING_DOWN, State.WAITING_UP:
			_timer += delta
			if _timer >= wait_time:
				_timer = 0.0
				_state = State.RISING if _state == State.WAITING_DOWN else State.DROPPING
		State.RISING:
			_seat.position.y = maxf(_seat.position.y - rise_speed * delta, -height)
			if _seat.position.y <= -height:
				_state = State.WAITING_UP
		State.DROPPING:
			_seat.position.y = minf(_seat.position.y + drop_speed * delta, 0.0)
			if _seat.position.y >= 0.0:
				_state = State.WAITING_DOWN
