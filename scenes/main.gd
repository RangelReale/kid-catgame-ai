extends Node

## The levels, in the order they are played. After the last one, the game
## goes back to the first.
@export var levels: Array[PackedScene] = []

var _level_index: int = 0
var _level: Node


func _ready() -> void:
	if not levels.is_empty():
		_load_level(0)


## The number keys jump straight to a level, to test levels quickly: 1 is the
## first level and 0 is the tenth.
func _unhandled_input(event: InputEvent) -> void:
	for index in mini(levels.size(), 10):
		if event.is_action_pressed("go_to_level_%d" % (index + 1)):
			_load_level.call_deferred(index)
			return


func _load_level(index: int) -> void:
	if _level != null:
		_level.queue_free()
	_level_index = index
	_level = levels[index].instantiate()
	add_child(_level)
	for goal in get_tree().get_nodes_in_group("goal"):
		if _level.is_ancestor_of(goal):
			goal.reached.connect(_on_goal_reached)
	for catcher in get_tree().get_nodes_in_group("catcher"):
		if _level.is_ancestor_of(catcher):
			catcher.caught.connect(_on_caught)


func _on_goal_reached() -> void:
	_load_level.call_deferred((_level_index + 1) % levels.size())


## Something caught the cat, like the angry man: the level starts over.
func _on_caught() -> void:
	_load_level.call_deferred(_level_index)
