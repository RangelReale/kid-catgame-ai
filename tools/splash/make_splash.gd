extends SceneTree
## Draws the picture shown while the game loads: the cat, big, on the sky.
## The cat comes from the player scene, so the picture stays sharp at any size.
## Run from the repository root (on Windows, with godot_console):
##   godot --path . -s tools/splash/make_splash.gd

const OUTPUT_PATH := "res://assets/icons/splash.png"
const SIZE := Vector2i(2560, 1440)

## How much bigger than in the game the cat is drawn.
const CAT_SCALE := 36.0

## The picture is drawn this many times bigger and then shrunk, which smooths
## the slanted edges. The Compatibility renderer has no 2D antialiasing.
const OVERSAMPLE := 2

## The middle of the cat's drawing, in the player scene.
const CAT_CENTER := Vector2(-4.5, -12.0)

## The frames to wait, so the viewport has finished drawing.
const FRAMES_TO_WAIT := 3

var _viewport: SubViewport
var _frames := 0


func _initialize() -> void:
	_viewport = SubViewport.new()
	_viewport.size = SIZE * OVERSAMPLE
	_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	root.add_child(_viewport)

	var player: Node = load("res://scenes/player/player.tscn").instantiate()
	var visual := player.get_node("Visual") as Node2D
	player.remove_child(visual)
	player.free()
	var cat_scale := CAT_SCALE * OVERSAMPLE
	visual.scale = Vector2(cat_scale, cat_scale)
	visual.position = Vector2(_viewport.size) / 2.0 - CAT_CENTER * cat_scale
	_viewport.add_child(visual)


func _process(_delta: float) -> bool:
	_frames += 1
	if _frames < FRAMES_TO_WAIT:
		return false
	var image := _viewport.get_texture().get_image()
	image.convert(Image.FORMAT_RGB8)
	image.resize(SIZE.x, SIZE.y, Image.INTERPOLATE_LANCZOS)
	image.save_png(OUTPUT_PATH)
	print("saved ", OUTPUT_PATH)
	return true
