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


func _ready() -> void:
	var tween := create_tween().set_loops()
	tween.tween_property(_press_label, "modulate:a", 0.2, blink_duration / 2.0)
	tween.tween_property(_press_label, "modulate:a", 1.0, blink_duration / 2.0)
	# The tune starts over each time it ends, while the title shows.
	_music.finished.connect(_music.play)
	visibility_changed.connect(_update_music)
	_update_music()


func _update_music() -> void:
	if visible:
		_music.play()
	else:
		_music.stop()


func _unhandled_input(event: InputEvent) -> void:
	if visible and is_start_event(event):
		get_viewport().set_input_as_handled()
		if not _audio_unlocked:
			# The browser kept the tune silent until now, so this press only
			# starts it over; the next one starts the game.
			_audio_unlocked = true
			_music.play()
			return
		start_requested.emit()


## Actions whose keys count as a start, besides the keys that type something.
const START_ACTIONS: Array[StringName] = [&"jump", &"move_left", &"move_right", &"move_down"]


## True for a real press of a key, a controller button, the mouse or a finger.
## Special keys, like volume, media, Shift, Ctrl or the F keys, and the
## controller's home button do not count.
static func is_start_event(event: InputEvent) -> bool:
	if not event.is_pressed() or event.is_echo():
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
