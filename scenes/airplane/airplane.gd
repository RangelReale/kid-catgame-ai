extends Node2D

## Emitted once, a little after the plane lands and stops. Works like
## reaching the flag: the next level starts.
signal reached

## Top speed along the runway and in the air, in pixels per second.
@export var speed: float = 180.0
## How high the plane flies above the runway, in pixels.
@export var cruise_height: float = 130.0
## Where the plane leaves the ground and where it reaches cruise height.
@export var climb_start_x: float = 400.0
@export var climb_end_x: float = 1000.0
## Where the plane starts going down and where its wheels touch the ground.
@export var descend_start_x: float = 2100.0
@export var descend_end_x: float = 2700.0
## Where the plane stops on the runway.
@export var stop_x: float = 3100.0
## How long the plane slows down before stopping, in pixels.
@export var braking_distance: float = 200.0
## Seconds to wait after stopping before the next level.
@export var wait_after_landing: float = 4.0
## Shown when the plane stops, like someone holding the cat. The cat leaves
## the window at the same time.
@export var show_on_landing: CanvasItem

var _ground_y: float
var _waiting: float = -1.0


func _ready() -> void:
	add_to_group("goal")
	_ground_y = position.y
	if show_on_landing != null:
		show_on_landing.hide()


func _physics_process(delta: float) -> void:
	if _waiting >= 0.0:
		_waiting += delta
		if _waiting >= wait_after_landing:
			_waiting = -INF
			reached.emit()
		return

	var previous := position
	var braking := clampf((stop_x - position.x) / braking_distance, 0.3, 1.0)
	position.x = minf(position.x + speed * braking * delta, stop_x)
	var height := cruise_height \
			* smoothstep(climb_start_x, climb_end_x, position.x) \
			* (1.0 - smoothstep(descend_start_x, descend_end_x, position.x))
	position.y = _ground_y - height
	rotation = (position - previous).angle()
	if position.x >= stop_x:
		rotation = 0.0
		_waiting = 0.0
		if show_on_landing != null:
			show_on_landing.show()
			$Visual/Window3/CatFace.hide()
			$Visual/Window3/CatEye.hide()
