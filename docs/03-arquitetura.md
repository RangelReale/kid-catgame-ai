# Arquitetura

Este documento descreve como o projeto será organizado. A estrutura é criada
aos poucos, seguindo o [roteiro](05-roteiro.md). Hoje existem o
`project.godot`, com a tela e as ações de entrada descritas abaixo, e as cenas
`Main`, `Player` e `Level01`. As pastas aparecem quando o primeiro arquivo
delas é criado.

## Conceitos do Godot

- **Nó (node):** uma peça do jogo, como uma imagem, um som ou um corpo com
  física.
- **Cena (scene):** um conjunto de nós salvo em um arquivo `.tscn`. O gato é
  uma cena. Uma fase é uma cena. Uma cena pode conter outras cenas.
- **Script:** um arquivo `.gd` com o comportamento de um nó.

## Pastas

```
project.godot        configuração do projeto
scenes/
  main.tscn          a cena que o jogo abre primeiro
  player/            o gato
  levels/            uma cena por fase
  sun/               o sol do céu, que fica parado na tela
  cloud/             uma nuvem do céu, que passa devagar pela tela
  monster/           um monstrinho que anda; some em estrelinhas quando o gato pula nele
  goal/              a bandeira de chegada; ao tocá-la, o jogo passa para a próxima fase
  objects/           peças reutilizáveis: coletável, plataforma, chegada
  ui/                telas e botões
assets/
  sprites/           imagens
  sounds/            efeitos sonoros
  music/             músicas
  fonts/             fontes
docs/                estes documentos
tools/               ferramentas fora do jogo; o Godot ignora a pasta
  promo/             piloto automático e filtro do ffmpeg do vídeo de promoção
build/               jogos exportados (fora do Git)
```

Cada script fica ao lado da cena que o usa, com o mesmo nome:
`scenes/player/player.tscn` e `scenes/player/player.gd`.

## Nomes

- Arquivos e pastas: inglês, minúsculas, com `_` (`level_01.tscn`).
- Nós e classes: inglês, em `PascalCase` (`Player`, `FishPickup`).
- Variáveis e funções: inglês, em `snake_case`, com tipos declarados.

## Cenas principais

| Cena | Nó raiz | Função |
| --- | --- | --- |
| `Main` | `Node` | Carrega a fase atual e troca de fase. |
| `Player` | `CharacterBody2D` | O gato: anda, pula e cai com gravidade. |
| `Level` | `Node2D` | Uma fase: chão e plataformas em um `TileMapLayer`, mais os objetos. |
| `Pickup` | `Area2D` | Um coletável, como um peixe. |
| `Goal` | `Area2D` | O ponto de chegada da fase. |
| `HUD` | `CanvasLayer` | Contador de coletáveis e botões de toque. |

A câmera (`Camera2D`) é um nó filho do `Player`, para a tela seguir o gato.
Ela fica na cena da fase, e não em `player.tscn`, porque os limites da câmera
dependem do tamanho de cada fase.

Por enquanto, o chão da fase `level_01` é um único `StaticBody2D`, e não um
`TileMapLayer`. A fase tem duas paredes invisíveis (`WallLeft` e `WallRight`)
nas bordas, para o gato não sair dela.

O `Player` tem a origem nos pés, no centro. A posição dele em uma fase é o
ponto onde os pés tocam o chão.

## Entrada

O código nunca lê teclas diretamente. Ele lê ações com nome, definidas no
Input Map do projeto:

| Ação | Teclado | Controle | Android |
| --- | --- | --- | --- |
| `move_left` | Seta esquerda, A | Direcional e analógico esquerdo | Botão na tela |
| `move_right` | Seta direita, D | Direcional e analógico esquerdo | Botão na tela |
| `jump` | Espaço, seta para cima | Botão de baixo (`JOY_BUTTON_A`) | Botão na tela |

No Android, os botões são nós `TouchScreenButton` grandes, nos cantos de
baixo da tela. Eles ficam em `scenes/hud/hud.tscn`, e a cena `Main` tem uma
instância dela. Cada botão dispara a ação do seu campo `action`. Os botões
de andar usam `passby_press`, para o dedo deslizar de um para o outro.

Os botões de toque aparecem só quando há tela de toque
(`DisplayServer.is_touchscreen_available()`) e nenhum controle conectado. O
`HUD` consulta `Input.get_connected_joypads()` ao iniciar e escuta o sinal
`Input.joy_connection_changed`.

No computador, os botões ficam escondidos. Para testá-los com o mouse, rode
`godot --path . -- --touch`. Esse argumento liga
`Input.emulate_touch_from_mouse` e mostra os botões.

O Retroid Pocket 3+ usa as mesmas ações do controle no computador. O Android
apresenta os botões dele como um controle sempre conectado. Por isso os
botões de toque não aparecem nele.

## Tela

O jogo tem uma resolução base fixa de 480x270 pontos, na proporção 16:9. O
Godot estica essa imagem para o tamanho real da janela ou do celular, com o
modo de esticamento `canvas_items` e o aspecto `expand`. Em telas mais largas
que 16:9, o jogador vê um pouco mais da fase nas laterais.

No computador, a janela abre com 1280x720 pontos. O fundo é azul-claro, a cor
do céu.

No Android, o jogo roda sempre deitado (paisagem).

## Formas simples primeiro

No começo, tudo é desenhado com retângulos coloridos. Em cada cena, a parte
visual fica em um nó próprio chamado `Visual`, separado da colisão e do
script. Para trocar o retângulo pelo desenho final, basta mudar esse nó. A
lógica do jogo não muda.

## Fases são dados

Uma fase é um arquivo `.tscn`, não código. Isso permite dois jeitos de montar
uma fase:

- **Por voz:** a criança descreve a fase, e o Claude edita o arquivo.
- **No editor:** a criança arrasta plataformas e objetos com o mouse.

Regras do jogo, como a altura do pulo, ficam em variáveis exportadas
(`@export`) no script. Assim elas aparecem no editor e mudam sem mexer no
código.
