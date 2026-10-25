# kid-catgame-ai

🇺🇸 [Read in English](README.md)

Um jogo 2D de plataforma com um gato, feito por um pai e sua filha de 6
anos, com a ajuda do Claude. O jogo usa o motor Godot 4 e roda em Windows,
Android e Mac.

![O gato arco-íris voa sobre um monstrinho, com o sol e as nuvens no céu](docs-en/images/screenshot.png)

Por enquanto, o gato tem corpo arco-íris, cabeça cor-de-rosa e asas. Ele
anda, pula e voa por duas fases e pula em cima dos monstrinhos.
Para rodar, use `godot --path .` na raiz do repositório. As teclas estão em
[Controles](#controles). Comece pelo [índice dos
documentos](docs-pt-br/README.md).

Jogue no navegador em <https://rangelreale.github.io/kid-catgame-ai/>.

## Controles

| Ação | Teclado | Controle |
| --- | --- | --- |
| Andar | Setas para a esquerda e para a direita, ou A e D | Direcional ou alavanca esquerda |
| Pular | Barra de espaço ou seta para cima | Botão de baixo (A) |
| Voar | Pular de novo no ar, até três vezes | Botão de baixo (A) |
| Subir nadando, no mar | Pular | Botão de baixo (A) |
| Descer nadando, no mar | Seta para baixo ou S | Direcional para baixo ou alavanca esquerda para baixo |
| Começar o jogo, na tela de início | Qualquer tecla | Qualquer botão |
| Trocar o idioma, na tela de início | L | Voltar (Select) |
| Ir para as fases de 1 a 10 | 1 a 9 e 0, também no teclado numérico | |
| Ir para as fases de 11 a 20 | Ctrl com 1 a 9 e 0 | |
| Próxima fase | `+`, `=` ou Page Down | |
| Fase anterior | `-` ou Page Up | |

Em telas de toque sem controle, quatro botões redondos nos cantos de baixo
fazem o gato andar e pular.

## Idiomas

Os documentos existem em português, em [docs-pt-br](docs-pt-br/README.md), e
em inglês, em [docs-en](docs-en/README.md). Mantenha as duas versões iguais.

As conversas com a IA neste repositório continuam em português, para a filha
continuar trabalhando no jogo. Isso vale para as respostas e os commits.

## Pedidos da filha

Antes de a filha começar a pedir, o pai montou a base: os documentos, o
projeto Godot vazio e um gato que era só um retângulo laranja com orelhas.
Ele andava e pulava sobre um chão verde, com o teclado ou com um controle, e
o jogo já rodava no Retroid Pocket 3+.

Todo o resto começou com um pedido da filha, ditado por voz. Abaixo estão os
pedidos dela, na ordem em que ela pediu e com as palavras dela. A caixinha
marcada mostra o que já está no jogo. Os detalhes de como cada pedido entrou
no jogo ficam no [roteiro](docs-pt-br/05-roteiro.md#ideias-da-filha).

- [x] Gato cor-de-rosa.
- [x] Gato com patas e rabo.
- [x] Gato com olho e boca.
- [x] Cambalhota ao pular.
- [x] Gato com corpo arco-íris.
- [x] Gato com cabeça separada do corpo.
- [x] Fase maior.
- [x] Gato com poderes e asas, que voa três vezes de cada vez.
- [x] Um sol bem bonito.
- [x] Nuvens bem bonitas.
- [x] Monstrinhos no meio da fase.
- [x] Som engraçado de pulo.
- [ ] 20 fases.
- [x] Fase da praia, com água no final.
- [x] Fase do fundo do mar, onde o gato ganha cauda de sereia.
- [x] Na fase da água, o gato tem que ir para cima.
- [x] No mar, o gato sobe com o botão de cima, fica lá em cima e desce com o
  botão de descer.
- [x] O gato sai da água e invade uma sala de computadores.
- [x] Um homem bravo quer que o gato pague pelo que fez, e o gato foge até o
  fim da sala de computadores.
- [x] Depois da fuga, uma fase bem fácil na floresta, com um inimigo
  pequeno: um ratinho numa nave.
- [x] No fim da floresta, um ratão com uma barra de vida para lutar. Se o
  gato não conseguir vencer, volta para o fim da fase.
- [x] Fase no céu, voando com as asas e escapando dos bichos voadores.
- [x] A próxima fase é o gato descendo.
- [x] Voar de avião sem fazer bagunça; se fizer bagunça, começa de novo e tem
  que entrar no avião.
- [x] Um jeito fácil de testar as fases: apertar um número pula direto para
  aquela fase.
- [x] Depois, o avião decola, e é preciso esperar ele pousar; quando pousa,
  vem a outra fase.
- [x] Depois do pouso, um homem pega o gato no colo.
- [x] Depois do avião, o moço leva o gato para a Disney, numa fase muito mais
  fácil.
- [x] O gato entra no castelo e acha as princesas, que pegam ele no colo.
- [ ] Depois das princesas, voltar de avião para o Brasil para tirar uma
  foto, voltar para o parque e se divertir nos brinquedos.
- [x] No Brasil, tirar uma foto com as princesas.
- [x] De volta ao parque, onde o gato passou a morar, aparece um monstro
  gigante; vencer o monstro é ganhar o jogo.
- [ ] Quando vence o monstro gigante, o jogo acaba.
- [x] No parque, brincar quanto quiser, com brinquedos de verdade; o jogo só
  acaba quando o gato for para a bandeira.
- [x] Um carrossel no parque.
- [x] Pular direto para as fases depois da 10.
- [x] Montanha-russa e torre do terror no parque.
- [x] Uma pescaria no parque.
- [x] Tela de início com o nome do jogo em letras grandes e partes do jogo
  rodando sozinhas no fundo, em tom sépia, com "aperte um botão para
  começar". No fim da última fase, a imagem fica sépia, aparece "Você
  venceu!" e sobem os créditos, só com "Filha" e "Pai".
- [x] No fim, "aperte um botão para voltar" piscando, como na tela de
  início, e um texto antes dos nomes dos créditos.
- [x] Musiquinha simples na abertura, no estilo dos jogos de PC de 1984, como
  o Alley Cat que o pai jogava.
- [x] Som ao pular em cima dos inimigos e outro quando eles explodem, sem o
  som de pulo junto na explosão.
