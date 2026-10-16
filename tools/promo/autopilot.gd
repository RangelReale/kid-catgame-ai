extends SceneTree
## Plays the game by itself for the promo video: walks right, hops on
## monsters, flies over the boxes and shows off the triple wing flap.
## Prints what it does, so a run without recording shows if the plan works.
## See README.md next to this file.

const START_DELAY := 1.2  # seconds standing still under the title
const END_TIME := 31.0

var _main: Node
var _tick := 0
var _jump_ticks: Array[int] = []  # ticks when "jump" gets pressed
var _release_tick := -1
var _last_level: Node
var _show_off_done := {}  # level names that already had the triple flap
var _popped_seen := {}  # monsters already reported as popped


func _initialize() -> void:
	_main = load("res://scenes/main.tscn").instantiate()
	root.add_child(_main)


func _level() -> Node:
	for child in _main.get_children():
		if not child.is_queued_for_deletion():
			return child
	return null


func _seconds() -> float:
	return _tick / 60.0


func _schedule_jump(delay_s: float) -> void:
	_jump_ticks.append(_tick + int(delay_s * 60.0))


func _physics_process(_delta: float) -> bool:
	_tick += 1
	var level := _level()
	if level != _last_level:
		_last_level = level
		_jump_ticks.clear()
		print("%.2f level %s" % [_seconds(), level.name])
	var player: CharacterBody2D = level.get_node("Player")

	if _tick == _release_tick:
		Input.action_release("jump")

	if _seconds() >= START_DELAY:
		Input.action_press("move_right")

	if player.is_on_floor() and _jump_ticks.is_empty() and _tick > _release_tick + 2:
		_plan(level, player)

	if _tick in _jump_ticks:
		_jump_ticks.erase(_tick)
		Input.action_release("jump")
		Input.action_press("jump")
		_release_tick = _tick + 2

	for monster in level.get_children():
		if monster.has_method("_pop") and monster.get("_popped") \
				and not _popped_seen.has(monster):
			_popped_seen[monster] = true
			print("%.2f POP %s" % [_seconds(), monster.name])

	if _seconds() >= END_TIME:
		print("end at x=%.0f" % player.position.x)
		return true
	return false


func _plan(level: Node, player: CharacterBody2D) -> void:
	var x := player.position.x
	# Show off: one big triple flap per level, in open space.
	var show_x := 300.0
	if x > show_x and not _show_off_done.has(level.name):
		_show_off_done[level.name] = true
		_schedule_jump(0.0)
		for i in 3:
			_schedule_jump(0.35 + 0.2 * i)
		print("%.2f show off at x=%.0f" % [_seconds(), x])
		return
	# Hop on a monster that is a little ahead.
	for monster in level.get_children():
		if monster.has_method("_pop") and not monster.get("_popped"):
			var dx: float = monster.position.x - x
			var dir: float = monster.get("_direction")
			# Jump when the monster will be under the cat as it falls, about
			# 0.6 s after take-off.
			var closing_speed: float = player.get("speed") - monster.get("speed") * dir
			var lead := closing_speed * 0.6
			if dx > lead - 6.0 and dx < lead + 6.0:
				_schedule_jump(0.0)
				print("%.2f hop at monster %s dx=%.0f" % [_seconds(), monster.name, dx])
				return
	# Blocked by a box: jump and flap over it.
	if _seconds() > START_DELAY + 0.3 and absf(player.velocity.x) < 1.0:
		_schedule_jump(0.0)
		_schedule_jump(0.3)
		print("%.2f over obstacle at x=%.0f" % [_seconds(), x])
