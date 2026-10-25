extends SceneTree
## Takes the App Store screenshots. For each screen size, it shows the title
## and a few levels, lets the cat play for a moment and saves a picture.
## The game draws into a SubViewport of the exact size the store asks for, so
## the computer screen size does not matter.
## See README.md next to this file.

const OUTPUT_DIR := "res://build/screenshots"

## The game's base size, from project.godot. With the "expand" aspect, the
## shorter side keeps this size and the other side grows.
const BASE_SIZE := Vector2(480.0, 270.0)

## The screen sizes the App Store asks for, in landscape.
const SIZES: Dictionary = {
	"iphone_6_9": Vector2i(2868, 1320),
	"iphone_6_3": Vector2i(2622, 1206),
	"ipad_13": Vector2i(2752, 2064),
}

## The pictures, in order. "level" is the index in main.tscn, or -1 for the
## title. "x" is where the cat starts, "seconds" is how long it plays before
## the picture and "mode" is how it plays: "walk" (the default), "swim",
## "fly" or "still". "ride" puts the cat on the leftmost seat of that node.
const SHOTS: Array[Dictionary] = [
	{"name": "01_title", "level": -1, "seconds": 3.6},
	{"name": "02_first_level", "level": 0, "x": 330.0, "seconds": 1.6},
	{"name": "03_sea", "level": 3, "x": 250.0, "seconds": 1.5, "mode": "swim"},
	{"name": "04_big_rat", "level": 6, "x": 950.0, "seconds": 1.8},
	{"name": "05_sky", "level": 7, "x": 250.0, "seconds": 1.5, "mode": "fly"},
	{"name": "06_ferris_wheel", "level": 15, "seconds": 2.5, "ride": "FerrisWheel/Cabins"},
]

## The pictures for the top of the store page and for the search results.
## They have no words, so they serve both languages.
const STORE_ART: Array[Dictionary] = [
	{"name": "header", "size": Vector2i(3840, 1646), "level": 15, "x": 330.0, "seconds": 1.6},
	{"name": "search", "size": Vector2i(3840, 2560), "level": 15, "x": 330.0, "seconds": 1.6},
]

## The languages of the title picture. The levels have no words, so they are
## taken once.
const LOCALES: Array[String] = ["pt_BR", "en"]

var _viewport: SubViewport
var _main: Node
var _jobs: Array[Dictionary] = []
var _job := -1
var _tick := 0
var _end_tick := 0
var _start_tick := 0  # the tick when the shot's game was built
var _level: Node  # the shot's level, once it is open
var _level_tick := 0  # the tick when it opened


func _initialize() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUTPUT_DIR))
	for size_name: String in SIZES:
		for shot in SHOTS:
			var locales: Array[String] = LOCALES if shot.level == -1 else ([""] as Array[String])
			for locale in locales:
				var job := shot.duplicate()
				job.size = SIZES[size_name]
				job.name = size_name + "_" + job.name
				job.locale = locale
				_jobs.append(job)
	for art in STORE_ART:
		var job := art.duplicate()
		job.locale = ""
		_jobs.append(job)


func _process(_delta: float) -> bool:
	if _job >= 0 and _tick == _end_tick:
		_save()
	if _tick >= _end_tick:
		_job += 1
		if _job >= _jobs.size():
			print("done")
			return true
		_start(_jobs[_job])
	_tick += 1
	_play(_jobs[_job])
	return false


## Builds a new game in a viewport of the shot's size and opens the level.
func _start(job: Dictionary) -> void:
	if _viewport != null:
		_viewport.queue_free()
	for action in ["jump", "move_right", "move_down"]:
		Input.action_release(action)
	if job.locale != "":
		TranslationServer.set_locale(job.locale)
	var size: Vector2i = job.size
	_viewport = SubViewport.new()
	_viewport.size = size
	_viewport.size_2d_override = _base_size_for(size)
	_viewport.size_2d_override_stretch = true
	_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	root.add_child(_viewport)
	_main = load("res://scenes/main.tscn").instantiate()
	_viewport.add_child(_main)
	if job.level >= 0:
		_main.call_deferred("_start_game")
	_start_tick = _tick
	_end_tick = _tick + int(job.seconds * 60.0)


## The part of the game world the screen shows, as the "expand" aspect does.
func _base_size_for(size: Vector2i) -> Vector2i:
	var ratio := float(size.x) / size.y
	if ratio >= BASE_SIZE.x / BASE_SIZE.y:
		return Vector2i(roundi(BASE_SIZE.y * ratio), int(BASE_SIZE.y))
	return Vector2i(int(BASE_SIZE.x), roundi(BASE_SIZE.x / ratio))


func _play(job: Dictionary) -> void:
	if job.level < 0:
		return
	# The game opens the first level a frame after the start, so the shot's
	# level opens a little later, or it would be replaced.
	if _tick == _start_tick + 10:
		_main._load_level(job.level)
	if _tick <= _start_tick + 10:
		_end_tick = _tick + 1
		return
	var level: Node = _main.get("_level")
	# The title's own levels open first, so wait for the shot's level.
	if level == null or _main.get("_level_index") != job.level \
			or level.is_queued_for_deletion():
		return
	if level != _level:
		_level = level
		_level_tick = _tick
		_end_tick = _tick + int(job.seconds * 60.0)
	var player := level.get_node_or_null("Player") as CharacterBody2D
	if player == null:
		return
	var age := _tick - _level_tick
	if age == 2:
		if job.has("x"):
			player.position.x = job.x
		_snap_camera(player)
	if age == 6 and job.has("ride"):
		_get_on_ride(level, player, job.ride)
	var mode: String = job.get("mode", "still" if job.has("ride") else "walk")
	if mode == "still":
		return
	Input.action_press("move_right")
	if mode == "swim":
		_hold("jump", int(age / 40.0) % 2 == 0)
		_hold("move_down", int(age / 40.0) % 2 == 1)
	elif mode == "fly":
		_hold("jump", age % 50 < 15)
	else:
		# A jump and two flaps, so the cat is high in the air in the picture.
		_hold("jump", age % 25 < 4 and age < 75)


func _hold(action: String, pressed: bool) -> void:
	if pressed:
		Input.action_press(action)
	else:
		Input.action_release(action)


## Puts the cat a little above the leftmost seat of the ride.
func _get_on_ride(level: Node, player: Node2D, ride_path: String) -> void:
	var ride := level.get_node(ride_path) as Node2D
	var seat := ride
	for child in ride.get_children():
		if child is PhysicsBody2D \
				and (seat == ride or child.global_position.x < seat.global_position.x):
			seat = child
	player.global_position = seat.global_position + Vector2(0.0, -30.0)
	_snap_camera(player)


## Moves the camera straight to the cat, without the smooth glide.
func _snap_camera(body: Node2D) -> void:
	body.reset_physics_interpolation()
	var camera := body.get_node("Camera2D") as Camera2D
	camera.reset_smoothing()


func _save() -> void:
	var job := _jobs[_job]
	var file_name: String = job.name
	if job.locale != "":
		file_name += "_" + job.locale
	var path := "%s/%s.png" % [OUTPUT_DIR, file_name]
	# The App Store refuses pictures with a see-through channel.
	var image := _viewport.get_texture().get_image()
	image.convert(Image.FORMAT_RGB8)
	image.save_png(path)
	print("saved ", path)
