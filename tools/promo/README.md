# Vídeo de promoção

Estes arquivos refazem o vídeo de promoção de 30 segundos,
`build/promo/jogo_do_gato_promo.mp4`.

- `autopilot.gd`: joga sozinho. O gato anda para a direita, pula nos
  monstrinhos, passa por cima das caixas e bate as asas três vezes em cada
  fase.
- `filter.txt`: o filtro do ffmpeg. Ele corta o vídeo em 30 segundos, põe
  os títulos e mistura a música com o som do jogo.

O arquivo `tools/.gdignore` faz o Godot ignorar esta pasta. Assim, o script
não entra no jogo exportado.

## Requisitos

- `godot` e `ffmpeg` no `PATH`.
- A fonte Comic Sans MS Bold. Ela vem no Windows e no Mac.

## Passos

Rode a partir da raiz do repositório. No Windows, use `godot_console` no
lugar de `godot`.

1. Teste o piloto automático sem gravar. A saída deve mostrar um `POP` para
   cada monstrinho e a troca de `Level01` para `Level02`:

   ```sh
   godot --headless --path . --fixed-fps 60 -s tools/promo/autopilot.gd
   ```

2. Grave a jogada. O Godot abre uma janela e grava 31 segundos:

   ```sh
   mkdir -p build/promo
   godot --path . --write-movie build/promo/gameplay.avi --fixed-fps 30 -s tools/promo/autopilot.gd
   ```

   No PowerShell, troque `mkdir -p build/promo` por
   `New-Item -ItemType Directory -Force build/promo`.

3. Baixe a música e copie a fonte:

   ```sh
   curl -L -o build/promo/music.wav "https://opengameart.org/sites/default/files/Cat%20Song%201.2.wav"
   ```

   - Windows: `Copy-Item C:\Windows\Fonts\comicbd.ttf build\promo\font.ttf`
   - Mac: `cp "/System/Library/Fonts/Supplemental/Comic Sans MS Bold.ttf" build/promo/font.ttf`

4. Monte o vídeo a partir de `build/promo`. O filtro procura `font.ttf` na
   pasta atual:

   ```sh
   cd build/promo
   ffmpeg -y -i gameplay.avi -i music.wav -/filter_complex ../../tools/promo/filter.txt -map "[v]" -map "[a]" -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart jogo_do_gato_promo.mp4
   cd ../..
   ```

## Quando o jogo mudar

Os títulos de `filter.txt` aparecem em segundos fixos. Eles combinam com o
que o piloto automático faz hoje: o triplo bater de asas aos 3 s, os
monstrinhos entre 6 s e 15 s, e a fase 2 a partir de 16 s. Se as fases
mudarem, rode o passo 1. Depois, ajuste os tempos de `enable='between(t,...)'`
para os novos momentos da saída.

## Música

"Cat Song", de Dan Knoflicek, está em
<https://opengameart.org/content/cat-song>. A licença é CC0, então não é
preciso pedir permissão. O autor pede o crédito, que já aparece no fim do
vídeo. Ele também pede uma mensagem ou um link quando alguém usa a música.
A música tem 27 segundos. O filtro repete o começo dela por 2,8 segundos e
abaixa o volume até o fim.
