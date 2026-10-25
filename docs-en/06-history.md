# Change history

[Português](../docs-pt-br/06-historico.md)

Everything that has changed in the game, from the beginning until today, in
the order it happened. Consecutive commits on the same subject appear
together in one item. The codes in parentheses are the commits.

Add a new item at the end for each change, here, in the [read-aloud
version](07-history-read-aloud.md) and in both Portuguese versions.

## October 13, 2026

- **Base documents.** The repository is born with the choice of game
  engine, the environment, the architecture, the way of working and the
  roadmap. It includes the Retroid Pocket 3+ controls and how to install
  Godot 4.7.2 on Windows. (5cdfd11, 571845a, 653322f, 04e8a8b, 1701e91,
  42408f8)
- **Empty Godot project (milestone 1).** The game opens an empty window.
  (523e3f0, 8d10fcf)
- **The cat walks and jumps (milestone 2).** A rectangle walks sideways and
  jumps on a ground. (7a3a56e, fe4312d)

## October 15, 2026

- **Game on the Retroid Pocket 3+.** First installation on the Android
  device. (568ee55)
- **Cat drawing.** The cat turns pink, gets paws, a tail, an eye and a
  mouth, and then the body takes the colors of the rainbow and the pink
  head becomes separate. (3f305ac, c9164f3, bef8295, 77ce769, c78d053)
- **Somersault.** The cat spins in the air when it jumps. (56366d1)
- **Bigger level and camera (milestone 3).** The level becomes four screens
  wide, with a box, a platform and a step, and the camera follows the cat.
  (cecdfd1)
- **Wings.** The cat flaps its wings in the air to go higher, up to three
  times before landing. (ac5f136)
- **Sky.** A smiling sun with turning rays and three drifting clouds.
  (60e0344, bfcec15)
- **Little monsters.** Three little monsters walk on the ground. Jumping on
  one makes it vanish in a "poof" of sparkles. Later, landing the jump on
  them got easier. (7d97df1, 3fc768d)
- **Flag and second level.** A flag at the end of the level leads to the
  next one. (4f4edca)
- **Jump sound.** Each jump makes a "boing", higher with each wing flap.
  (32bb3ec)
- **Video and screenshot.** The promo video scripts go to `tools/promo`,
  the README gets a screenshot and Godot starts ignoring the `docs` folder.
  (bb4cb58, 71ac3e3, 9fa1c4b)

## October 16, 2026

- **Touch buttons.** On touch screens without a controller, round buttons
  in the bottom corners make the cat walk and jump. (5322dfd)
- **Game on the iPad.** "iOS" export preset, icon with the cat and
  installation instructions through the Mac. (f4c8083)
- **Level 3, the beach.** A beach with a shallow sea at the end. (4075e15,
  6c7012a)
- **Level 4, the bottom of the sea.** The cat becomes a mermaid and swims:
  up with jump, down with the down button, and it stays at its height when
  nothing is pressed. (64dfd74, 9236f8e, 55a0944)
- **Level 5, the computer room.** It starts in the sea and enters a room
  with computers. (76d7ae4)
- **Level 6, the angry man.** An angry man walks after the cat. If he
  reaches the cat, the level starts over. (ef4e28e)
- **Level 7, the forest.** An easy forest with a little mouse in a flying
  saucer and, at the end, a big rat with a health bar. Three jumps on top
  of it make the flag appear. (1a7db95, ea72b28)
- **Level 8, the sky.** The cat flies freely and dodges little birds.
  (5a8a71a)
- **Level 9, coming down from the sky.** The cat goes down from cloud to
  cloud to the grass. (5aa1719)
- **Level 10, the airplane.** Inside an airplane, bumping into a suitcase
  makes the level start over. (e5203fc)
- **Number keys.** Keys 1 to 9 and 0 jump straight to each level. (6701b6f)
- **Level 11, the airplane trip.** With no controls, the airplane takes
  off, flies and lands by itself, and a smiling man picks the cat up.
  (e32cb8b, 4422f1e)
- **Level 12, the park.** An easy park with a pink castle and balloons.
  (c02ccd3)
- **Level 13, the castle.** Two princesses pick the cat up. (ffc3839)
- **Levels 14 and 15, Brazil and the giant monster.** In Brazil, the photo
  with the princesses makes the screen flash. In the park, a giant monster
  has five health and, once beaten, makes the flag appear. (8e112c2)
- **Level 16, the amusement park.** A Ferris wheel that turns with the cat
  and trampolines, then a carousel of horses, a roller coaster, a tower that
  goes up and down and a fishing game where the little fish jump out of the
  water. (d913ebe, 805c68f, 87130bf, fe8a154)
- **More level shortcuts.** Ctrl with a number goes to levels 11 to 20, and
  the + and - keys go to the next and to the previous level. (2abb633)

## October 17, 2026

- **New promo video.** The video shows clips of ten levels, from the first
  to the roller coaster, with a title for each one. (cab5c29)

## October 23, 2026

- **Title and victory screens.** The game opens with the name in big
  letters over levels that play by themselves, in sepia. At the end of the
  last level, "You won!" and the credits, "Daughter" and "Dad", appear.
- **Credits with a heading and a prompt.** "Made by" appears before the
  names, and "Press a button to go back" blinks at the end.
- **Title music.** A melody of beeps, in the style of old PCs, plays on the
  title screen.
- **Enemy sounds.** Jumping on an enemy makes a "bonk", and beating it makes
  a "poof" with sparkles.
- **Special keys do not start the game.** Volume, media, Shift, Ctrl, F1 to
  F12, Esc and the Android back button do not count as "press a button".

## October 24, 2026

- **Portuguese and English.** The game opens in the device language. On the
  title screen, the flags of Brazil and the United States switch the
  language, and the game remembers the choice.
- **Documents in two languages.** The documents now exist in English, in
  `docs-en`, and in Portuguese, in `docs-pt-br`. The README also has both
  versions.

## October 25, 2026

- **Promo video in English.** The video now also exists in English, with
  the same clips and translated titles. Both videos were recorded again
  with today's game. The video's autopilot now skips the title screen.
