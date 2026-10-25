# App Store screenshots

[Português](README.pt-br.md)

The `screenshots.gd` script makes the screenshots for the game's App Store
page. It shows the title screen, in Portuguese and in English, and five
levels: the first one, the sea floor, the big rat, the sky and the Ferris
wheel. The game is drawn at the exact size the App Store asks for, whatever
the computer's screen is.

| Device | Size |
| --- | --- |
| 6.9" iPhone | 2868 x 1320 |
| 13" iPad | 2752 x 2064 |
| Page header (`header.png`) | 3840 x 1646 |
| Search results (`search.png`) | 3840 x 2560 |

The pictures have no see-through channel, because the App Store refuses
it.

Run it from the repository root. On Windows, use `godot_console` instead of
`godot`. Godot opens a window for a few seconds:

```sh
godot --path . --fixed-fps 60 -s tools/screenshots/screenshots.gd
```

The pictures go to `build/screenshots/`. The `SHOTS` list says which level
goes in, where the cat starts and how long it plays before the picture. The
`SIZES` list has the sizes, and the `STORE_ART` list has the two page
pictures.
