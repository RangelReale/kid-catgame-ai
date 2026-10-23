extends Node

## TITLE shows the game's name over levels that play by themselves, PLAYING is
## the real game and ENDING shows "you won" and the credits.
enum State { TITLE, PLAYING, ENDING }

## The levels, in the order they are played. After the last one, the ending
## shows up.
@export var levels: Array[PackedScene] = []
## The levels that play by themselves behind the title, as positions in
## `levels`: 0 is the first level.
@export var demo_levels: Array[int] = []
## Seconds each level plays behind the title before the next one.
@export var demo_duration: float = 8.0
## Seconds between the jumps of the cat behind the title.
@export var demo_jump_interval: float = 1.0

var _state: State = State.TITLE
var _level_index: int = 0
var _level: Node
var _demo_index: int = 0
var _demo_time: float = 0.0
var _demo_jump_time: float = 0.0

@onready var _hud: CanvasLayer = $HUD
@onready var _title_screen: TitleScreen = $TitleScreen
@onready var _ending: CanvasLayer = $Ending


func _ready() -> void:
	_title_screen.start_requested.connect(_start_game)
	_ending.finished.connect(_show_title)
	_show_title()


func _physics_process(delta: float) -> void:
	if _state != State.TITLE:
		return
	# Behind the title, the cat walks right and jumps now and then, as if
	# someone were playing.
	Input.action_press("move_right")
	if Input.is_action_pressed("jump"):
		Input.action_release("jump")
	_demo_jump_time += delta
	if _demo_jump_time >= demo_jump_interval:
		_demo_jump_time = 0.0
		Input.action_press("jump")
	_demo_time += delta
	if _demo_time >= demo_duration:
		_next_demo_level()


## Shows the title, with the levels playing by themselves in the back.
func _show_title() -> void:
	_state = State.TITLE
	_hud.hide()
	_title_screen.show()
	# The cat's "boing" would play by itself, so the game sounds stay off.
	# The title music plays on another bus.
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), true)
	_demo_index = -1
	_next_demo_level()


func _next_demo_level() -> void:
	if demo_levels.is_empty():
		return
	_demo_index = (_demo_index + 1) % demo_levels.size()
	_demo_time = 0.0
	_demo_jump_time = 0.0
	_load_level.call_deferred(demo_levels[_demo_index])


func _start_game() -> void:
	_release_demo_actions()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), false)
	_title_screen.hide()
	_hud.show()
	_state = State.PLAYING
	_load_level.call_deferred(0)


func _release_demo_actions() -> void:
	Input.action_release("move_right")
	Input.action_release("jump")


## The last level is done: the picture stops, turns brown and the credits
## roll.
func _show_ending() -> void:
	_state = State.ENDING
	_level.process_mode = Node.PROCESS_MODE_DISABLED
	_hud.hide()
	_ending.play()


## The number keys jump straight to a level, to test levels quickly: 1 is the
## first level and 0 is the tenth. With Ctrl held, 1 is the eleventh and 0 is
## the twentieth. Plus and minus go to the next and the previous level.
func _unhandled_input(event: InputEvent) -> void:
	if _state != State.PLAYING:
		return
	if event.is_action_pressed("go_to_next_level"):
		_load_level.call_deferred((_level_index + 1) % levels.size())
		return
	if event.is_action_pressed("go_to_previous_level"):
		_load_level.call_deferred(posmod(_level_index - 1, levels.size()))
		return
	for index in mini(levels.size(), 20):
		if event.is_action_pressed("go_to_level_%d" % (index + 1), false, true):
			_load_level.call_deferred(index)
			return


func _load_level(index: int) -> void:
	if _level != null:
		_level.queue_free()
	_level_index = index
	_level = levels[index].instantiate()
	add_child(_level)
	# With physics interpolation on, the new level's camera does not take over
	# the screen by itself while the old level is still being freed.
	for camera in _level.find_children("*", "Camera2D"):
		camera.make_current()
		camera.reset_smoothing()
	for goal in get_tree().get_nodes_in_group("goal"):
		if _level.is_ancestor_of(goal):
			goal.reached.connect(_on_goal_reached)
	for catcher in get_tree().get_nodes_in_group("catcher"):
		if _level.is_ancestor_of(catcher):
			catcher.caught.connect(_on_caught)


func _on_goal_reached() -> void:
	if _state == State.TITLE:
		_next_demo_level()
	elif _level_index == levels.size() - 1:
		_show_ending.call_deferred()
	else:
		_load_level.call_deferred(_level_index + 1)


## Something caught the cat, like the angry man: the level starts over.
## Behind the title, the next level plays instead.
func _on_caught() -> void:
	if _state == State.TITLE:
		_next_demo_level()
	else:
		_load_level.call_deferred(_level_index)
