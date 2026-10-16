extends Node

## The levels, in the order they are played. After the last one, the game
## goes back to the first.
@export var levels: Array[PackedScene] = []

var _level_index: int = 0
var _level: Node


func _ready() -> void:
	if not levels.is_empty():
		_load_level(0)


func _load_level(index: int) -> void:
	if _level != null:
		_level.queue_free()
	_level_index = index
	_level = levels[index].instantiate()
	add_child(_level)
	for goal in get_tree().get_nodes_in_group("goal"):
		if _level.is_ancestor_of(goal):
			goal.reached.connect(_on_goal_reached)


func _on_goal_reached() -> void:
	_load_level.call_deferred((_level_index + 1) % levels.size())
