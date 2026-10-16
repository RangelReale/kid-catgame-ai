extends Area2D

## Emitted once, when the man catches the cat.
signal caught

## Walking speed, in pixels per second. Slower than the cat, so it can run away.
@export var speed: float = 80.0
## Seconds the man waits before he starts walking after the cat.
@export var start_delay: float = 1.5

var _player: Node2D
var _caught: bool = false

@onready var _visual: Node2D = $Visual


func _ready() -> void:
	add_to_group("catcher")
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if start_delay > 0.0:
		start_delay -= delta
		return
	if _caught:
		return
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")
		if _player == null:
			return
	var direction := signf(_player.global_position.x - global_position.x)
	position.x += speed * direction * delta
	if direction != 0.0:
		_visual.scale.x = direction


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not _caught:
		_caught = true
		caught.emit()
