# Technology

[Português](../docs-pt-br/01-tecnologia.md)

## What the game needs

- Be a 2D side-scrolling platform game: the character walks and jumps, and
  the screen follows.
- Run on Windows, Android and Mac, in that order of priority.
- On Android, run on a phone and on a Retroid Pocket 3+, a handheld game
  console with Android 11 and physical buttons.
- Be simple enough for a 6-year-old child to take part.
- Keep all files in text format, so Claude can read and edit them.

## Choice: Godot 4

Godot is a game engine, that is, a program that already provides physics,
drawing on screen, sound, and keyboard and touch input. We chose Godot 4 for
four reasons:

- **It exports to all three platforms.** The same project produces an `.exe`
  for Windows, an `.apk` for Android and an `.app` for Mac, without separate
  code.
- **The files are text.** Scenes (`.tscn`) and scripts (`.gd`) are plain
  text. Claude can create and change levels, characters and rules.
- **It has a visual editor.** The child sees the level on screen and can
  drag platforms and objects with the mouse.
- **It is free and open source.** There is no license, account or fee.

## Alternatives considered

| Option | Strength | Why not |
| --- | --- | --- |
| Go + Ebitengine | Uses Go, a language we already know. | No visual editor. Android needs an extra project. |
| Phaser + Capacitor | Runs in the browser, easy to test. | Needs different packagers for Android and for desktop. |
| LÖVE (Lua) | Small and simple. | No visual editor. Packaging for Android is manual. |

## Choices within Godot

- **Version:** 4.7.x. All computers must use the same minor version (4.7),
  because Godot rewrites project files when opened in another version.
- **Language:** GDScript, Godot's own language, with declared types. The C#
  alternative needs more installation and complicates exporting.
- **Renderer:** Compatibility. The renderer is the part that draws on the
  screen. Compatibility is the lightest and works on old Android phones. A
  simple 2D game does not need the others.
