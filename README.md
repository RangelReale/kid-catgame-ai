# kid-catgame-ai

🇧🇷 [Leia em português](README.pt-br.md)

A 2D platform game with a cat, made by a father and his 6-year-old daughter
with help from Claude. The game uses the Godot 4 engine and runs on
Windows, Android and Mac.

![The rainbow cat flies over a little monster, with the sun and clouds in the sky](docs-en/images/screenshot.png)

For now, the cat has a rainbow body, a pink head and wings. It walks, jumps
and flies through two levels and jumps on top of the little monsters.
To run it, use `godot --path .` at the root of the repository. The keys are
in [Controls](#controls). Start with the [documentation
index](docs-en/README.md).

Play it in the browser at <https://rangelreale.github.io/kid-catgame-ai/>.

## Controls

| Action | Keyboard | Game controller |
| --- | --- | --- |
| Walk | Left and right arrows, or A and D | D-pad or left stick |
| Jump | Space bar or up arrow | Bottom button (A) |
| Fly | Jump again in the air, up to three times | Bottom button (A) |
| Swim up, in the sea | Jump | Bottom button (A) |
| Swim down, in the sea | Down arrow or S | D-pad down or left stick down |
| Start the game, on the title screen | Any key | Any button |
| Change the language, on the title screen | L | Back (Select) |

On touch screens without a game controller, four round buttons in the
bottom corners walk and jump.

## Languages

The documentation exists in English, in [docs-en](docs-en/README.md), and in
Brazilian Portuguese, in [docs-pt-br](docs-pt-br/README.md). Keep both
versions in sync.

AI interactions with this repository stay in Brazilian Portuguese, so the
daughter can keep working on the game. This applies to replies and commit
messages.

## The daughter's requests

Before the daughter started asking, the father built the base: the
documents, the empty Godot project and a cat that was only an orange
rectangle with ears. It walked and jumped on green ground, with the keyboard
or a game controller, and the game already ran on the Retroid Pocket 3+.

Everything else started as a request from the daughter, dictated by voice.
Below are her requests, in the order she made them, translated from her own
Portuguese words. A checked box means it is already in the game. The
[roadmap](docs-en/05-roadmap.md#the-daughters-ideas) explains how each
request went into the game.

- [x] Pink cat.
- [x] Cat with paws and tail.
- [x] Cat with an eye and a mouth.
- [x] Somersault when jumping.
- [x] Cat with a rainbow body.
- [x] Cat with a head separate from the body.
- [x] Bigger level.
- [x] Cat with powers and wings, which flies three times in a row.
- [x] A really pretty sun.
- [x] Really pretty clouds.
- [x] Little monsters in the middle of the level.
- [x] Funny jump sound.
- [ ] 20 levels.
- [x] Beach level, with water at the end.
- [x] Bottom-of-the-sea level, where the cat gets a mermaid tail.
- [x] In the water level, the cat has to go up.
- [x] In the sea, the cat goes up with the up button, stays up there and goes
  down with the down button.
- [x] The cat comes out of the water and breaks into a computer room.
- [x] An angry man wants the cat to pay for what it did, and the cat runs
  away to the end of the computer room.
- [x] After the escape, a very easy level in the forest, with a small enemy:
  a little mouse in a ship.
- [x] At the end of the forest, a big rat with a health bar to fight. If the
  cat cannot win, it goes back to the end of the level.
- [x] Level in the sky, flying with the wings and dodging the flying
  critters.
- [x] The next level is the cat going down.
- [x] Fly by airplane without making a mess; if you make a mess, you start
  again and have to get on the airplane.
- [x] An easy way to test the levels: pressing a number jumps straight to
  that level.
- [x] Then the airplane takes off, and you have to wait for it to land; when
  it lands, the next level comes.
- [x] After landing, a man picks the cat up.
- [x] After the airplane, the man takes the cat to Disney, in a much easier
  level.
- [x] The cat enters the castle and finds the princesses, who pick it up.
- [ ] After the princesses, fly back to Brazil to take a photo, return to the
  park and have fun on the rides.
- [x] In Brazil, take a photo with the princesses.
- [x] Back at the park, where the cat now lives, a giant monster appears;
  beating the monster is winning the game.
- [ ] When the giant monster is beaten, the game ends.
- [x] In the park, play as much as you want, with real rides; the game only
  ends when the cat goes to the flag.
- [x] A carousel in the park.
- [x] Jump straight to the levels after 10.
- [x] Roller coaster and tower of terror in the park.
- [x] A fishing game in the park.
- [x] Title screen with the game name in big letters and parts of the game
  playing by themselves in the background, in sepia, with "press a button to
  start". At the end of the last level, the picture turns sepia, "You won!"
  appears and the credits roll, with only "Daughter" and "Dad".
- [x] At the end, a blinking "press a button to go back", like on the title
  screen, and a text before the names in the credits.
- [x] A simple tune on the title screen, in the style of 1984 PC games, like
  the Alley Cat the father used to play.
- [x] A sound when jumping on enemies and another when they explode, without
  the jump sound on the explosion.
