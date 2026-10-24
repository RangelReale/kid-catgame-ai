# How we work

[Português](../docs-pt-br/04-como-trabalhamos.md)

The game is made by three participants:

- **The daughter (6 years old):** gives the ideas, asks for changes by
  voice, draws, records sounds, builds levels and tests the game.
- **The father:** operates the computer, takes care of Git and helps
  translate the ideas.
- **Claude:** writes and changes the game files.

Conversations with Claude happen in Portuguese, the daughter's language.

## A session cycle

1. The daughter says what she wants. Example: "quero que o gato pule mais
   alto" ("I want the cat to jump higher").
2. Claude makes a small change and says in one sentence what changed.
3. She plays and sees the result.
4. She says whether she liked it or what to change.

Each round should take a few minutes. One change at a time keeps her
attention and makes it easy to undo what did not turn out well.

## Voice requests

She talks and the computer turns speech into text:

- **Windows:** voice typing, with the `Win` + `H` keys.
- **Mac:** system dictation, enabled in System Settings > Keyboard.
- **Claude Code:** its own voice mode, if the installed version has it.

Dictated text arrives with errors and without punctuation. Claude should
work out the intent and move on.

### Examples

| She says | Claude does |
| --- | --- |
| "o gato tem que correr mais rápido" ("the cat has to run faster") | Increases the `Player` speed. |
| "põe mais peixe lá em cima" ("put more fish up there") | Adds collectibles on high platforms in the current level. |
| "quero uma fase com neve" ("I want a level with snow") | Creates a new level with white ground and a light blue background. |
| "ficou muito difícil" ("it got too hard") | Brings the platforms closer or raises the jump. |

## Building levels

At first, she builds levels by voice: she describes what she wants, and
Claude edits the level file. Later, she can open the level in the Godot
editor and drag the pieces with the mouse.

## Her drawings and sounds

This part starts at the last milestone of the [roadmap](05-roadmap.md).

**Drawings**

1. She draws on paper with a dark outline, or on a tablet.
2. Photograph or scan the drawing in good light.
3. Remove the background and save it as a PNG with a transparent
   background.
4. Save it in `assets/sprites/`, with an English, lowercase name
   (`cat_idle.png`).

**Sounds**

1. Record with the phone or with the computer microphone.
2. Convert to WAV (short effects) or OGG (music).
3. Save in `assets/sounds/` or `assets/music/`.

## Git

- Never work on the `master` branch. Each session uses its own branch.
- Commit whenever the game is working and she likes the result. That makes
  it possible to go back to a good version.
- At the end of the session, merge the branch straight into `master`, push
  `master` and delete the branch. The project does not use pull requests.
- Write her ideas in the list in the [roadmap](05-roadmap.md), even the
  ones left for later.
