extends Area2D

## Walking speed, in pixels per second.
@export var speed: float = 40.0
## How far the rat walks to each side of where it starts, in pixels.
@export var walk_distance: float = 90.0
## How many times the cat must land on the rat to win.
@export var max_health: int = 3
## Where the cat goes back to when the rat touches it from the side.
@export var respawn_position: Vector2 = Vector2.ZERO
## The flag that appears when the rat is beaten.
@export var goal: Node
## Seconds after a hit when the rat does nothing to the cat.
@export var hurt_cooldown: float = 0.6

## How far above the rat's feet the cat's feet must be to count as landing on
## top, in pixels.
const STOMP_HEIGHT := 2.0

var _health: int
var _start_x: float
var _direction: float = 1.0
var _cooldown: float = 0.0
var _beaten: bool = false

@onready var _visual: Node2D = $Visual
@onready var _health_fill: Node2D = $HealthBar/Fill
@onready var _poof: CPUParticles2D = $Poof


func _ready() -> void:
	_health = max_health
	_start_x = position.x
	_poof.finished.connect(queue_free)


func _physics_process(delta: float) -> void:
	if _beaten:
		return

	position.x += speed * _direction * delta
	if absf(position.x - _start_x) >= walk_distance:
		position.x = _start_x + walk_distance * _direction
		_direction = -_direction
	_visual.scale.x = _direction

	_cooldown -= delta
	for body in get_overlapping_bodies():
		if body is Player:
			if _is_landed_on(body):
				_hit(body)
			elif _cooldown <= 0.0:
				_send_back(body)
			return


func _is_landed_on(player: Player) -> bool:
	return player.velocity.y > 0.0 \
		and player.global_position.y < global_position.y - STOMP_HEIGHT


## The cat landed on the rat: one less life, and the cat bounces up.
func _hit(player: Player) -> void:
	_health -= 1
	_cooldown = hurt_cooldown
	player.bounce()
	_update_health_bar()
	if _health <= 0:
		_beaten = true
		_visual.hide()
		$HealthBar.hide()
		_poof.emitting = true
		if goal != null:
			goal.unlock()
		return
	_visual.modulate = Color(1, 0.6, 0.6)
	create_tween().tween_property(_visual, "modulate", Color.WHITE, hurt_cooldown)


## The rat touched the cat from the side: the cat goes back a little and the
## rat gets all its life back.
func _send_back(player: Player) -> void:
	_health = max_health
	_cooldown = hurt_cooldown
	_update_health_bar()
	player.respawn(respawn_position)


func _update_health_bar() -> void:
	_health_fill.scale.x = float(_health) / max_health
