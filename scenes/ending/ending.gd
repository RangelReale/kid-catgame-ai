extends CanvasLayer

## Emitted when the credits have finished and someone presses a button.
signal finished

## Seconds the picture takes to turn brown.
@export var fade_duration: float = 1.5
## Seconds the credits take to go up the screen.
@export var scroll_duration: float = 6.0

var _can_finish: bool = false

@onready var _sepia: ColorRect = $Sepia
@onready var _won_label: Label = $Visual/Won
@onready var _credits: Control = $Visual/Credits


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
	_credits.position.y = screen.y
	var tween := create_tween()
	tween.tween_method(func(value: float) -> void:
			material.set_shader_parameter("amount", value), 0.0, 1.0, fade_duration)
	tween.tween_property(_won_label, "modulate:a", 1.0, 0.5)
	tween.tween_property(_credits, "position:y",
			(screen.y - _credits.size.y) / 2.0 + 30.0, scroll_duration)
	tween.tween_callback(func() -> void: _can_finish = true)


func _unhandled_input(event: InputEvent) -> void:
	if visible and _can_finish and TitleScreen.is_start_event(event):
		get_viewport().set_input_as_handled()
		hide()
		finished.emit()
