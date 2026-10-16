# Roteiro

O jogo cresce em marcos pequenos. Ao fim de cada marco, existe algo que a
filha pode ver ou jogar.

## Marcos

- [x] **1. Projeto vazio no Windows.** Um projeto Godot que abre no editor e
  mostra uma janela. Inclui `.gitignore` e `.gitattributes`.
- [x] **2. O gato anda e pula.** Um retângulo anda para os lados e pula sobre
  um chão, com o teclado ou com um controle.
- [x] **3. A câmera segue o gato.** A fase é mais larga que a tela.
- [ ] **4. Coletáveis e chegada.** O gato pega peixes, e a fase termina na
  chegada.
- [ ] **5. Jogo para Windows.** Um `.exe` que roda fora do editor.
- [ ] **6. Jogo para Android.** Um `.apk` no celular, com botões na tela, e
  no Retroid Pocket 3+, com os botões do aparelho. Os botões na tela já
  existem. Falta exportar e testar no celular.
- [ ] **7. Projeto no Mac.** O projeto abre no Mac e exporta um `.app`.
- [x] **8. Segunda fase.** O jogo passa de uma fase para a outra.
- [ ] **9. Arte e sons da filha.** Os desenhos e sons dela substituem os
  retângulos.

A ordem dos marcos 8 e 9 pode mudar conforme o interesse dela.

## Ideias da filha

Anote aqui tudo o que ela pedir, com a data. Marque o que já entrou no jogo.

- [x] 2026-10-15: gato cor-de-rosa (depois virou arco-íris).
- [x] 2026-10-15: gato com patas e rabo.
- [x] 2026-10-15: gato com olho e boca.
- [x] 2026-10-15: cambalhota ao pular.
- [x] 2026-10-15: gato com corpo arco-íris.
- [x] 2026-10-15: gato com cabeça separada do corpo.
- [x] 2026-10-15: fase maior.
- [x] 2026-10-15: gato com poderes e asas, que voa três vezes de cada vez.
  Entrou como três pulos extras no ar, batendo as asas.
- [x] 2026-10-15: um sol bem bonito.
- [x] 2026-10-15: nuvens bem bonitas.
- [x] 2026-10-15: monstrinhos no meio da fase. Ela pediu "monstrinhos pra
  matar". Sem violência: o gato pula em cima deles e eles somem num "puf"
  de estrelinhas, sem dor e sem morte.
- [x] 2026-10-15: som engraçado de pulo.
- [ ] 2026-10-15: 20 fases. Feitas 16: a fase 1, de chão verde, a fase 2,
  de chão de areia, a fase 3, a praia, a fase 4, o fundo do mar, a fase 5,
  a sala de computadores, a fase 6, a fuga do homem bravo, a fase 7, a
  floresta, a fase 8, o céu, a fase 9, a descida, a fase 10, o avião, a
  fase 11, o voo, a fase 12, o parque com castelo, a fase 13, dentro do
  castelo, a fase 14, a foto no Brasil, a fase 15, o monstro gigante, e a
  fase 16, os brinquedos do parque. Uma bandeira no fim de cada fase leva à próxima, e
  depois da última o jogo volta à primeira. Para criar uma fase nova, copie
  um `level_XX.tscn` e acrescente-o à lista `levels` de `main.tscn`.
- [x] 2026-10-16: fase da praia, com água no final. É a fase 3: areia clara
  e, no fim, um mar raso com ondinhas. O gato entra na água até a bandeira.
- [x] 2026-10-16: fase do fundo do mar, onde o gato ganha cauda de sereia.
  É a fase 4: água azul, raios de luz, bolhas, algas, pedras e uma estrela-do-mar.
  O gato troca as patas e o rabo por uma cauda de sereia e nada.
- [x] 2026-10-16: na fase da água, o gato tem que ir para cima. Segurando
  pular, o gato sereia sobe nadando; soltando, ele desce devagar.
- [x] 2026-10-16: no mar, o gato sobe com o botão de cima, fica lá em cima e
  desce com o botão de descer. Entrou a ação `move_down` (seta para baixo,
  S, direcional para baixo) e um botão de toque com seta para baixo.
- [x] 2026-10-16: o gato sai da água e invade uma sala de computadores. É a
  fase 5: começa no mar raso, passa pela areia e entra numa sala com mesas,
  computadores de telas coloridas e servidores com luzinhas.
- [x] 2026-10-16: um homem bravo quer que o gato pague pelo que fez, e o gato
  foge até o fim da sala de computadores. É a fase 6. O homem bravo
  (`scenes/angry_man/`) espera um pouco e anda atrás do gato, mais devagar que
  ele. Se ele alcançar o gato, a fase começa de novo, sem susto e sem dor.
- [x] 2026-10-16: depois da fuga, uma fase bem fácil na floresta, com um
  inimigo pequeno: um ratinho numa nave. É a fase 7: duas telas de largura,
  árvores, florzinhas e um só inimigo, o ratinho num disco voador
  (`scenes/mouse_ship/`, que usa o script do monstrinho).
- [x] 2026-10-16: no fim da floresta, um ratão com uma barra de vida para
  lutar. Se o gato não conseguir vencer, volta para o fim da fase. A
  floresta ficou com três telas. O ratão (`scenes/big_rat/`) anda perto da
  bandeira, que fica escondida até ele ser vencido. Cada pulo em cima dele
  tira um pedaço da barra rosa; com três, ele some num "puf" grande e a
  bandeira aparece. Se ele encostar no gato de lado, o gato volta para um
  pouco antes dele e o ratão recupera a vida toda.
- [x] 2026-10-16: fase no céu, voando com as asas e escapando dos bichos
  voadores. É a fase 8: o gato sai de uma nuvem e voa livre (sobe com pular,
  desce com `move_down`, fica parado sem apertar nada) até a nuvem da
  bandeira. Passarinhos (`scenes/bird/`) voam de um lado para o outro; se um
  encostar no gato, a fase recomeça.
- [x] 2026-10-16: a próxima fase é o gato descendo. É a fase 9: uma tela de
  largura e quatro de altura. O gato começa numa nuvem lá no alto e desce
  pulando de nuvem em nuvem até a grama, onde está a bandeira.
- [x] 2026-10-16: voar de avião sem fazer bagunça; se fizer bagunça, começa
  de novo e tem que entrar no avião. É a fase 10: o gato sobe a escada, entra
  no avião e anda pelo corredor entre as poltronas. Se ele esbarrar numa
  mala (`scenes/suitcase/`), a fase recomeça do lado de fora do avião.
- [x] 2026-10-16: um jeito fácil de testar as fases: apertar um número pula
  direto para aquela fase. As teclas 1 a 9 levam às fases 1 a 9, e a tecla
  0 leva à fase 10 (ações `go_to_level_1` a `go_to_level_10`, no teclado
  normal e no numérico).
- [x] 2026-10-16: depois, o avião decola, e é preciso esperar ele pousar;
  quando pousa, vem a outra fase. É a fase 11, sem controles: o avião
  (`scenes/airplane/`), com o gato na janela, decola, voa entre nuvens,
  pousa e para. Logo depois começa a fase seguinte.
- [x] 2026-10-16: depois do pouso, um homem pega o gato no colo. Quando o
  avião para, o gato some da janela e aparece no colo de um homem sorridente
  (`scenes/friendly_man/`) ao lado do avião. Uns segundos depois, vem a fase
  seguinte.
- [x] 2026-10-16: depois do avião, o moço leva o gato para a Disney, numa
  fase muito mais fácil. Para não usar a marca, virou um parque com um
  castelo cor-de-rosa e balões. É a fase 12: duas telas, sem inimigos, com a
  bandeira na frente do castelo.
- [x] 2026-10-16: o gato entra no castelo e acha as princesas, que pegam ele
  no colo. É a fase 13: um salão cor-de-rosa com colunas, janelas, lustres e
  dois degraus. No fim, duas princesas (`scenes/princesses/`), genéricas e
  sem marca; quando o gato chega, uma delas pega ele no colo e, depois de um
  tempinho, o jogo segue.
- [ ] 2026-10-16: depois das princesas, voltar de avião para o Brasil para
  tirar uma foto, voltar para o parque e se divertir nos brinquedos. A foto
  entrou na fase 14 e os brinquedos na fase 16; falta a viagem de avião.
- [x] 2026-10-16: no Brasil, tirar uma foto com as princesas. É a fase 14:
  uma praia com morros verdes, coqueiros e a bandeira do Brasil. Quando o
  gato chega nas princesas, uma pega ele no colo e a tela pisca branca, como
  o flash de uma foto (`photo_flash` em `scenes/princesses/`).
- [x] 2026-10-16: de volta ao parque, onde o gato passou a morar, aparece um
  monstro gigante; vencer o monstro é ganhar o jogo. Ela pediu "matar"; sem
  violência, o gato pula em cima dele. É a fase 15: o parque do castelo, com
  um monstro roxo de um olho só (`scenes/giant_monster/`, que usa o script do
  ratão), com cinco de vida. Vencido, a bandeira aparece.
- [ ] 2026-10-16: quando vence o monstro gigante, o jogo acaba. Falta uma
  tela de festa no fim; por enquanto, o jogo volta para a fase 1.
- [x] 2026-10-16: no parque, brincar quanto quiser, com brinquedos de
  verdade; o jogo só acaba quando o gato for para a bandeira. É a fase 16:
  uma roda-gigante (`scenes/ferris_wheel/`) que gira devagar e leva o gato
  nas cadeirinhas, e camas elásticas (`scenes/trampoline/`) que jogam o gato
  bem alto. A bandeira fica na frente do castelo, no fim.
- [x] 2026-10-16: um carrossel no parque. Fica na fase 16, antes do castelo
  (`scenes/carousel/`): quatro cavalinhos coloridos que giram e sobem e
  descem; o gato pode montar num cavalinho e ir junto.
- [x] 2026-10-16: pular direto para as fases depois da 10. Ctrl com um
  número leva às fases 11 a 20 (Ctrl+1 é a 11 e Ctrl+0 é a 20; ações
  `go_to_level_11` a `go_to_level_20`). A tecla + vai para a próxima fase e
  a tecla - volta para a anterior (`go_to_next_level` e
  `go_to_previous_level`, também no teclado numérico e com Page Down e Page
  Up).
