class_name TitleScreen
extends CanvasLayer

## Emitted when someone presses any key or button, or touches the screen.
signal start_requested

## Seconds the "press a button" words take to fade out and back in.
@export var blink_duration: float = 1.2

@onready var _press_label: Label = $Visual/Press


func _ready() -> void:
	var tween := create_tween().set_loops()
	tween.tween_property(_press_label, "modulate:a", 0.2, blink_duration / 2.0)
	tween.tween_property(_press_label, "modulate:a", 1.0, blink_duration / 2.0)


func _unhandled_input(event: InputEvent) -> void:
	if visible and is_start_event(event):
		get_viewport().set_input_as_handled()
		start_requested.emit()


## True for a real press of a key, a controller button, the mouse or a finger.
static func is_start_event(event: InputEvent) -> bool:
	if event is InputEventKey or event is InputEventJoypadButton \
			or event is InputEventMouseButton or event is InputEventScreenTouch:
		return event.is_pressed() and not event.is_echo()
	return false
