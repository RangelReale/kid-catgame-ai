extends Area2D

## Emitted once, when the cat touches the flag.
signal reached


func _ready() -> void:
	add_to_group("goal")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		set_deferred("monitoring", false)
		reached.emit()
