class_name TitleScreen
extends CanvasLayer

## Emitted when someone presses any key or button, or touches the screen.
signal start_requested

## Seconds the "press a button" words take to fade out and back in.
@export var blink_duration: float = 1.2

## On the web, the browser mutes all sound until the first key or click.
static var _audio_unlocked: bool = not OS.has_feature("web")

@onready var _press_label: Label = $Visual/Press
@onready var _music: AudioStreamPlayer = $Music
@onready var _flags: Array[Node] = $Visual/Languages.get_children()


func _ready() -> void:
	var tween := create_tween().set_loops()
	tween.tween_property(_press_label, "modulate:a", 0.2, blink_duration / 2.0)
	tween.tween_property(_press_label, "modulate:a", 1.0, blink_duration / 2.0)
	# The tune starts over each time it ends, while the title shows.
	_music.finished.connect(_music.play)
	visibility_changed.connect(_update_music)
	_update_music()
	for flag: LanguageFlag in _flags:
		flag.pressed.connect(_on_flag_pressed.bind(flag.locale))
	Language.changed.connect(_update_flags)
	_update_flags()


func _update_flags() -> void:
	for flag: LanguageFlag in _flags:
		flag.selected = flag.locale == Language.current()


func _on_flag_pressed(locale: String) -> void:
	_unlock_audio()
	Language.choose(locale)


## The browser kept the tune silent until the first press, so the tune starts
## over. Returns false when the sound was already on.
func _unlock_audio() -> bool:
	if _audio_unlocked:
		return false
	_audio_unlocked = true
	_music.play()
	return true


func _update_music() -> void:
	if visible:
		_music.play()
	else:
		_music.stop()


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("change_language"):
		get_viewport().set_input_as_handled()
		_unlock_audio()
		Language.choose_next()
		return
	if is_start_event(event) and not _is_on_flag(event):
		get_viewport().set_input_as_handled()
		# On the web, the first press only turns the sound on; the next one
		# starts the game.
		if not _unlock_audio():
			start_requested.emit()


## True when a finger touches a language flag. The flag itself takes care of
## it, so the game does not start.
func _is_on_flag(event: InputEvent) -> bool:
	if not event is InputEventScreenTouch:
		return false
	var position := (event as InputEventScreenTouch).position
	return _flags.any(func(flag: Node) -> bool:
			return (flag as Control).get_global_rect().has_point(position))


## Actions whose keys count as a start, besides the keys that type something.
const START_ACTIONS: Array[StringName] = [&"jump", &"move_left", &"move_right", &"move_down"]


## True for a real press of a key, a controller button, the mouse or a finger.
## Special keys, like volume, media, Shift, Ctrl or the F keys, and the
## controller's home button do not count.
static func is_start_event(event: InputEvent) -> bool:
	if not event.is_pressed() or event.is_echo():
		return false
	if event.is_action(&"change_language"):
		return false
	if event is InputEventKey:
		var key := event as InputEventKey
		if key.unicode != 0 or key.keycode in [KEY_ENTER, KEY_KP_ENTER]:
			return true
		return START_ACTIONS.any(func(action: StringName) -> bool:
				return event.is_action(action, true))
	if event is InputEventJoypadButton:
		return (event as InputEventJoypadButton).button_index != JOY_BUTTON_GUIDE
	if event is InputEventMouseButton:
		return (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
	return event is InputEventScreenTouch
