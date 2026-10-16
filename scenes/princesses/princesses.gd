extends Area2D

## Emitted once, a little after a princess picks up the cat. Works like
## reaching the flag: the next level starts.
signal reached

## Seconds the princess holds the cat before the next level.
@export var wait_after_pickup: float = 2.5

var _picked_up: bool = false

@onready var _held_cat: Node2D = $Visual/HeldCat


func _ready() -> void:
	add_to_group("goal")
	body_entered.connect(_on_body_entered)
	_held_cat.hide()


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not _picked_up:
		_picked_up = true
		body.hide()
		body.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
		_held_cat.show()
		get_tree().create_timer(wait_after_pickup).timeout.connect(reached.emit)
