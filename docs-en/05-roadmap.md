# Roadmap

[Português](../docs-pt-br/05-roteiro.md)

The game grows in small milestones. At the end of each milestone, there is
something the daughter can see or play.

## Milestones

- [x] **1. Empty project on Windows.** A Godot project that opens in the
  editor and shows a window. Includes `.gitignore` and `.gitattributes`.
- [x] **2. The cat walks and jumps.** A rectangle walks sideways and jumps
  on a ground, with the keyboard or a controller.
- [x] **3. The camera follows the cat.** The level is wider than the
  screen.
- [ ] **4. Collectibles and finish.** The cat picks up fish, and the level
  ends at the finish.
- [ ] **5. Game for Windows.** An `.exe` that runs outside the editor.
- [ ] **6. Game for Android.** An `.apk` on the phone, with on-screen
  buttons, and on the Retroid Pocket 3+, with the device's buttons. The
  on-screen buttons already exist. Exporting and testing on the phone are
  still to do.
- [ ] **7. Project on Mac.** The project opens on the Mac and exports an
  `.app`.
- [x] **8. Second level.** The game moves from one level to the next.
- [ ] **9. The daughter's art and sounds.** Her drawings and sounds replace
  the rectangles.

The order of milestones 8 and 9 may change depending on her interest.

## The daughter's ideas

Write down here everything she asks for, with the date. Mark what is
already in the game.

- [x] 2026-10-15: pink cat (later it became rainbow).
- [x] 2026-10-15: cat with paws and tail.
- [x] 2026-10-15: cat with an eye and a mouth.
- [x] 2026-10-15: somersault when jumping.
- [x] 2026-10-15: cat with a rainbow body.
- [x] 2026-10-15: cat with a head separate from the body.
- [x] 2026-10-15: bigger level.
- [x] 2026-10-15: cat with powers and wings, which flies three times in a
  row. It went in as three extra jumps in the air, flapping the wings.
- [x] 2026-10-15: a really pretty sun.
- [x] 2026-10-15: really pretty clouds.
- [x] 2026-10-15: little monsters in the middle of the level. She asked for
  "monstrinhos pra matar" ("little monsters to kill"). Without violence:
  the cat jumps on top of them and they vanish in a "poof" of sparkles,
  with no pain and no death.
- [x] 2026-10-15: funny jump sound.
- [ ] 2026-10-15: 20 levels. 16 done: level 1, with green ground, level 2,
  with sand ground, level 3, the beach, level 4, the bottom of the sea,
  level 5, the computer room, level 6, the escape from the angry man, level
  7, the forest, level 8, the sky, level 9, the descent, level 10, the
  airplane, level 11, the flight, level 12, the park with a castle, level
  13, inside the castle, level 14, the photo in Brazil, level 15, the giant
  monster, and level 16, the park rides. A flag at the end of each level
  leads to the next one, and after the last one come the victory and the
  credits. To create a new level, copy a `level_XX.tscn` and add it to the
  `levels` list in `main.tscn`.
- [x] 2026-10-16: beach level, with water at the end. It is level 3: light
  sand and, at the end, a shallow sea with little waves. The cat walks into
  the water up to the flag.
- [x] 2026-10-16: bottom-of-the-sea level, where the cat gets a mermaid
  tail. It is level 4: blue water, light rays, bubbles, seaweed, rocks and a
  starfish. The cat swaps its paws and tail for a mermaid tail and swims.
- [x] 2026-10-16: in the water level, the cat has to go up. Holding jump,
  the mermaid cat swims up; letting go, it sinks slowly.
- [x] 2026-10-16: in the sea, the cat goes up with the up button, stays up
  there and goes down with the down button. The `move_down` action came in
  (down arrow, S, D-pad down) and a touch button with a down arrow.
- [x] 2026-10-16: the cat comes out of the water and breaks into a computer
  room. It is level 5: it starts in the shallow sea, crosses the sand and
  enters a room with desks, computers with colorful screens and servers
  with little lights.
- [x] 2026-10-16: an angry man wants the cat to pay for what it did, and the
  cat runs away to the end of the computer room. It is level 6. The angry
  man (`scenes/angry_man/`) waits a little and walks after the cat, slower
  than it. If he reaches the cat, the level starts over, with no scare and
  no pain.
- [x] 2026-10-16: after the escape, a very easy level in the forest, with a
  small enemy: a little mouse in a ship. It is level 7: two screens wide,
  trees, little flowers and a single enemy, the little mouse in a flying
  saucer (`scenes/mouse_ship/`, which uses the little monster's script).
- [x] 2026-10-16: at the end of the forest, a big rat with a health bar to
  fight. If the cat cannot win, it goes back to the end of the level. The
  forest got three screens. The big rat (`scenes/big_rat/`) walks near the
  flag, which stays hidden until it is beaten. Each jump on top of it takes
  a piece off the pink bar; after three, it vanishes in a big "poof" and the
  flag appears. If it touches the cat from the side, the cat goes back to a
  little before it and the big rat recovers all its health.
- [x] 2026-10-16: level in the sky, flying with the wings and dodging the
  flying critters. It is level 8: the cat leaves a cloud and flies freely
  (up with jump, down with `move_down`, stays still when nothing is
  pressed) to the cloud with the flag. Little birds (`scenes/bird/`) fly
  from side to side; if one touches the cat, the level starts over.
- [x] 2026-10-16: the next level is the cat going down. It is level 9: one
  screen wide and four tall. The cat starts on a cloud high up and goes
  down jumping from cloud to cloud to the grass, where the flag is.
- [x] 2026-10-16: fly by airplane without making a mess; if you make a mess,
  you start again and have to get on the airplane. It is level 10: the cat
  climbs the stairs, enters the airplane and walks down the aisle between
  the seats. If it bumps into a suitcase (`scenes/suitcase/`), the level
  starts over outside the airplane.
- [x] 2026-10-16: an easy way to test the levels: pressing a number jumps
  straight to that level. Keys 1 to 9 lead to levels 1 to 9, and key 0
  leads to level 10 (actions `go_to_level_1` to `go_to_level_10`, on the
  main keyboard and on the numpad).
- [x] 2026-10-16: then the airplane takes off, and you have to wait for it
  to land; when it lands, the next level comes. It is level 11, with no
  controls: the airplane (`scenes/airplane/`), with the cat in the window,
  takes off, flies through clouds, lands and stops. Right after, the next
  level starts.
- [x] 2026-10-16: after landing, a man picks the cat up. When the airplane
  stops, the cat leaves the window and appears in the arms of a smiling man
  (`scenes/friendly_man/`) next to the airplane. A few seconds later, the
  next level comes.
- [x] 2026-10-16: after the airplane, the man takes the cat to Disney, in a
  much easier level. To avoid using the brand, it became a park with a pink
  castle and balloons. It is level 12: two screens, no enemies, with the
  flag in front of the castle.
- [x] 2026-10-16: the cat enters the castle and finds the princesses, who
  pick it up. It is level 13: a pink hall with columns, windows, chandeliers
  and two steps. At the end, two princesses (`scenes/princesses/`), generic
  and unbranded; when the cat arrives, one of them picks it up and, after a
  little while, the game moves on.
- [ ] 2026-10-16: after the princesses, fly back to Brazil to take a photo,
  return to the park and have fun on the rides. The photo went into level
  14 and the rides into level 16; the airplane trip is still missing.
- [x] 2026-10-16: in Brazil, take a photo with the princesses. It is level
  14: a beach with green hills, coconut trees and the Brazilian flag. When
  the cat reaches the princesses, one picks it up and the screen flashes
  white, like a camera flash (`photo_flash` in `scenes/princesses/`).
- [x] 2026-10-16: back at the park, where the cat now lives, a giant monster
  appears; beating the monster is winning the game. She asked to "matar"
  ("kill"); without violence, the cat jumps on top of it. It is level 15:
  the castle park, with a purple one-eyed monster
  (`scenes/giant_monster/`, which uses the big rat's script), with five
  health. Once beaten, the flag appears.
- [ ] 2026-10-16: when the giant monster is beaten, the game ends. A party
  screen at the end is still missing; for now, the game goes back to level
  1.
- [x] 2026-10-16: in the park, play as much as you want, with real rides;
  the game only ends when the cat goes to the flag. It is level 16: a
  Ferris wheel (`scenes/ferris_wheel/`) that turns slowly and carries the
  cat in its little seats, and trampolines (`scenes/trampoline/`) that throw
  the cat really high. The flag is in front of the castle, at the end.
- [x] 2026-10-16: a carousel in the park. It is in level 16, before the
  castle (`scenes/carousel/`): four colorful horses that turn and go up and
  down; the cat can ride a horse and go along.
- [x] 2026-10-16: jump straight to the levels after 10. Ctrl with a number
  leads to levels 11 to 20 (Ctrl+1 is 11 and Ctrl+0 is 20; actions
  `go_to_level_11` to `go_to_level_20`). The + key goes to the next level
  and the - key goes back to the previous one (`go_to_next_level` and
  `go_to_previous_level`, also on the numpad and with Page Down and Page
  Up).
- [x] 2026-10-16: roller coaster and tower of terror in the park. Level 16
  got six screens. The roller coaster (`scenes/roller_coaster/`) has a car
  that goes up and down the hills of the track, back and forth, and carries
  the cat along. The "tower of terror" became a tall, cheerful tower
  (`scenes/drop_tower/`), with no scare: the seat goes up slowly, waits at
  the top and comes down fast, but not too fast.
- [x] 2026-10-16: a fishing game in the park. It is in level 16, between the
  tower and the castle (`scenes/fishing_booth/`): a striped booth with
  little flags and a tub with four little fish (`scenes/fish/`). When the
  cat touches a little fish, it jumps out of the water in a burst of
  sparkles and comes back after a while. It does not count the fish caught
  yet.
- [x] 2026-10-23: title screen with the game name in big letters and parts
  of the game playing by themselves in the background, in sepia, with
  "press a button to start". At the end of the last level, the picture
  turns sepia, "You won!" appears and the credits roll, with only
  "Daughter" and "Dad". The background levels are in `demo_levels`, in
  `main.tscn`.
- [x] 2026-10-23: at the end, a blinking "press a button to go back", like
  on the title screen, and a text before the names in the credits. "Made
  by" went in above "Daughter" and "Dad".
- [x] 2026-10-23: a simple tune on the title screen, in the style of 1984 PC
  games, like the Alley Cat the father used to play. It is a new melody, of
  square-wave beeps, that repeats while the title screen is shown.
- [x] 2026-10-23: a sound when jumping on enemies and another when they
  explode, without the jump sound on the explosion. The jump that does not
  win yet makes a "bonk"; the one that wins makes only a "poof" with
  tinkling sparkles.
