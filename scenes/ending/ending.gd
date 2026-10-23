extends CanvasLayer

## Emitted when the credits have finished and someone presses a button.
signal finished

## Seconds the picture takes to turn brown.
@export var fade_duration: float = 1.5
## Seconds the credits take to go up the screen.
@export var scroll_duration: float = 6.0
## Seconds the "press a button" words take to fade out and back in.
@export var blink_duration: float = 1.2

var _can_finish: bool = false
var _blink_tween: Tween

@onready var _sepia: ColorRect = $Sepia
@onready var _won_label: Label = $Visual/Won
@onready var _credits: Control = $Visual/Credits
@onready var _press_label: Label = $Visual/Press


func _ready() -> void:
	hide()


## Turns the frozen picture brown, says the player won and rolls the credits.
func play() -> void:
	show()
	_can_finish = false
	var screen := get_viewport().get_visible_rect().size
	var material := _sepia.material as ShaderMaterial
	material.set_shader_parameter("amount", 0.0)
	_won_label.modulate.a = 0.0
	_press_label.modulate.a = 0.0
	_credits.position.y = screen.y
	var tween := create_tween()
	tween.tween_method(func(value: float) -> void:
			material.set_shader_parameter("amount", value), 0.0, 1.0, fade_duration)
	tween.tween_property(_won_label, "modulate:a", 1.0, 0.5)
	# The credits stop just below "you won", to leave room for the words at
	# the bottom.
	tween.tween_property(_credits, "position:y",
			_won_label.position.y + _won_label.size.y + 4.0, scroll_duration)
	tween.tween_callback(_on_credits_done)


func _on_credits_done() -> void:
	_can_finish = true
	_blink_tween = create_tween().set_loops()
	_blink_tween.tween_property(_press_label, "modulate:a", 1.0, blink_duration / 2.0)
	_blink_tween.tween_property(_press_label, "modulate:a", 0.2, blink_duration / 2.0)


func _unhandled_input(event: InputEvent) -> void:
	if visible and _can_finish and TitleScreen.is_start_event(event):
		get_viewport().set_input_as_handled()
		_blink_tween.kill()
		hide()
		finished.emit()
