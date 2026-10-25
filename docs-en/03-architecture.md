# Architecture

[Português](../docs-pt-br/03-arquitetura.md)

This document describes how the project is organized. The structure is
created bit by bit, following the [roadmap](05-roadmap.md). Today there is
the `project.godot`, with the screen and the input actions described below,
and the `Main`, `Player` and `Level01` scenes. Folders appear when their
first file is created.

## Godot concepts

- **Node:** a piece of the game, such as an image, a sound or a body with
  physics.
- **Scene:** a set of nodes saved in a `.tscn` file. The cat is a scene. A
  level is a scene. A scene can contain other scenes.
- **Script:** a `.gd` file with the behavior of a node.

## Folders

```
project.godot        project settings
scenes/
  main.tscn          the scene the game opens first
  player/            the cat
  levels/            one scene per level
  sun/               the sun in the sky, which stays still on screen
  cloud/             a cloud in the sky, which drifts slowly across the screen
  monster/           a little monster that walks; vanishes in sparkles when the cat jumps on it
  goal/              the finish flag; touching it moves the game to the next level
  objects/           reusable pieces: collectible, platform, finish
  ui/                screens and buttons
assets/
  sprites/           images
  sounds/            sound effects
  music/             music
  fonts/             fonts
docs-pt-br/          these documents, in Portuguese
docs-en/             these documents, in English
tools/               tools outside the game; Godot ignores the folder
  promo/             autopilot and ffmpeg filters for the promo videos
build/               exported games (outside Git)
```

Each script sits next to the scene that uses it, with the same name:
`scenes/player/player.tscn` and `scenes/player/player.gd`.

## Names

- Files and folders: English, lowercase, with `_` (`level_01.tscn`).
- Nodes and classes: English, in `PascalCase` (`Player`, `FishPickup`).
- Variables and functions: English, in `snake_case`, with declared types.

## Main scenes

| Scene | Root node | Purpose |
| --- | --- | --- |
| `Main` | `Node` | Loads the current level and switches levels. |
| `Player` | `CharacterBody2D` | The cat: walks, jumps and falls with gravity. |
| `Level` | `Node2D` | A level: ground and platforms in a `TileMapLayer`, plus the objects. |
| `Pickup` | `Area2D` | A collectible, such as a fish. |
| `Goal` | `Area2D` | The finish point of the level. |
| `HUD` | `CanvasLayer` | Collectible counter and touch buttons. |

The camera (`Camera2D`) is a child node of `Player`, so the screen follows
the cat. It lives in the level scene, not in `player.tscn`, because the
camera limits depend on the size of each level.

For now, the ground of `level_01` is a single `StaticBody2D`, not a
`TileMapLayer`. The level has two invisible walls (`WallLeft` and
`WallRight`) at the edges, so the cat cannot leave it.

The `Player` has its origin at the feet, in the center. Its position in a
level is the point where the feet touch the ground.

## Input

The code never reads keys directly. It reads named actions, defined in the
project's Input Map:

| Action | Keyboard | Controller | Android |
| --- | --- | --- | --- |
| `move_left` | Left arrow, A | D-pad and left stick | On-screen button |
| `move_right` | Right arrow, D | D-pad and left stick | On-screen button |
| `jump` | Space, up arrow | Bottom button (`JOY_BUTTON_A`) | On-screen button |
| `change_language` | L | Back button (`JOY_BUTTON_BACK`) | Tap on the flag |

On Android, the buttons are large `TouchScreenButton` nodes, in the bottom
corners of the screen. They live in `scenes/hud/hud.tscn`, and the `Main`
scene has an instance of it. Each button fires the action in its `action`
field. The walk buttons use `passby_press`, so the finger can slide from one
to the other.

The touch buttons appear only when there is a touch screen
(`DisplayServer.is_touchscreen_available()`) and no controller is connected.
The `HUD` checks `Input.get_connected_joypads()` at startup and listens to
the `Input.joy_connection_changed` signal.

On the computer, the buttons are hidden. To test them with the mouse, run
`godot --path . -- --touch`. That argument turns on
`Input.emulate_touch_from_mouse` and shows the buttons.

The Retroid Pocket 3+ uses the same controller actions as the computer.
Android presents its buttons as an always-connected controller. That is why
the touch buttons do not appear on it.

## Languages

The game speaks Brazilian Portuguese and English. The on-screen texts live
in `assets/translations/strings.csv`, one line per text, with a key
(`TITLE`) and one column per language. In the scenes, each `Label` holds the
key, and Godot replaces it with the sentence in the current language. Godot
generates the `.translation` files on import; they stay outside Git.

The first time, the game uses the device language. If the device is in
neither Portuguese nor English, it uses English. The `Language` autoload
(`scenes/language/language.gd`) switches the language and saves the choice
in `user://settings.cfg`, for next time.

On the title screen, two flags in the top corner (Brazil and the United
States) show the current language. Tapping or clicking a flag switches the
language, and the `change_language` action moves to the next one. Neither
starts the game.

## Screen

The game has a fixed base resolution of 480x270 points, in 16:9 aspect
ratio. Godot stretches that image to the real size of the window or phone,
with the `canvas_items` stretch mode and the `expand` aspect. On screens
wider than 16:9, the player sees a bit more of the level at the sides.

On the computer, the window opens at 1280x720 points. The background is
light blue, the color of the sky.

On Android, the game always runs lying down (landscape).

## Simple shapes first

At first, everything is drawn with colored rectangles. In each scene, the
visual part lives in its own node called `Visual`, separate from the
collision and the script. To swap the rectangle for the final drawing, only
that node needs to change. The game logic does not change.

## Levels are data

A level is a `.tscn` file, not code. That allows two ways to build a level:

- **By voice:** the child describes the level, and Claude edits the file.
- **In the editor:** the child drags platforms and objects with the mouse.

Game rules, such as the jump height, live in exported variables (`@export`)
in the script. That way they appear in the editor and change without
touching the code.
