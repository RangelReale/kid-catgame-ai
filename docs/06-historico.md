# Histórico de mudanças

Tudo o que mudou no jogo, do começo até hoje, na ordem em que aconteceu.
Commits seguidos sobre o mesmo assunto aparecem juntos em um item. Os
códigos entre parênteses são os commits.

Acrescente um item novo no fim a cada mudança, aqui e na [versão para
ouvir](07-historico-para-ouvir.md).

## 13 de outubro de 2026

- **Documentos de base.** O repositório nasce com a escolha do motor de
  jogo, o ambiente, a arquitetura, o jeito de trabalhar e o roteiro. Inclui
  os controles do Retroid Pocket 3+ e como instalar o Godot 4.7.2 no
  Windows. (5cdfd11, 571845a, 653322f, 04e8a8b, 1701e91, 42408f8)
- **Projeto Godot vazio (marco 1).** O jogo abre uma janela vazia.
  (523e3f0, 8d10fcf)
- **O gato anda e pula (marco 2).** Um retângulo anda para os lados e pula
  sobre um chão. (7a3a56e, fe4312d)

## 15 de outubro de 2026

- **Jogo no Retroid Pocket 3+.** Primeira instalação no aparelho Android.
  (568ee55)
- **Desenho do gato.** O gato fica cor-de-rosa, ganha patas, rabo, olho e
  boca, e depois o corpo fica com as cores do arco-íris e a cabeça
  cor-de-rosa separada. (3f305ac, c9164f3, bef8295, 77ce769, c78d053)
- **Cambalhota.** O gato gira no ar quando pula. (56366d1)
- **Fase maior e câmera (marco 3).** A fase passa a ter quatro telas de
  largura, com caixa, plataforma e degrau, e a câmera segue o gato.
  (cecdfd1)
- **Asas.** O gato bate as asas no ar para subir mais, até três vezes antes
  de pousar. (ac5f136)
- **Céu.** Um sol sorridente com raios que giram e três nuvens que passam.
  (60e0344, bfcec15)
- **Monstrinhos.** Três monstrinhos andam pelo chão. Pular em cima de um faz
  ele sumir num "puf" de estrelinhas. Depois, ficou mais fácil acertar o
  pulo em cima deles. (7d97df1, 3fc768d)
- **Bandeira e segunda fase.** Uma bandeira no fim da fase leva à próxima.
  (4f4edca)
- **Som de pulo.** Cada pulo faz um "boing", mais agudo a cada batida de
  asa. (32bb3ec)
- **Vídeo e captura de tela.** Os scripts do vídeo de promoção vão para
  `tools/promo`, o README ganha uma captura de tela e o Godot passa a
  ignorar a pasta `docs`. (bb4cb58, 71ac3e3, 9fa1c4b)

## 16 de outubro de 2026

- **Botões de toque.** Em telas de toque sem controle, botões redondos nos
  cantos de baixo fazem o gato andar e pular. (5322dfd)
- **Jogo no iPad.** Predefinição de exportação "iOS", ícone com o gato e
  instruções de instalação pelo Mac. (f4c8083)
- **Fase 3, a praia.** Uma praia com mar raso no fim. (4075e15, 6c7012a)
- **Fase 4, o fundo do mar.** O gato vira sereia e nada: sobe com pular,
  desce com o botão de descer e fica parado na altura quando nada é
  apertado. (64dfd74, 9236f8e, 55a0944)
- **Fase 5, a sala de computadores.** Começa no mar e entra numa sala com
  computadores. (76d7ae4)
- **Fase 6, o homem bravo.** Um homem bravo anda atrás do gato. Se ele
  alcançar o gato, a fase recomeça. (ef4e28e)
- **Fase 7, a floresta.** Uma floresta fácil com um ratinho num disco
  voador e, no fim, um ratão com barra de vida. Três pulos em cima dele
  fazem a bandeira aparecer. (1a7db95, ea72b28)
- **Fase 8, o céu.** O gato voa livre e desvia de passarinhos. (5a8a71a)
- **Fase 9, descendo do céu.** O gato desce de nuvem em nuvem até a grama.
  (5aa1719)
- **Fase 10, o avião.** Dentro de um avião, esbarrar numa mala faz a fase
  recomeçar. (e5203fc)
- **Teclas de número.** As teclas de 1 a 9 e o 0 pulam direto para cada
  fase. (6701b6f)
- **Fase 11, a viagem de avião.** Sem controles, o avião decola, voa e pousa
  sozinho, e um homem sorridente pega o gato no colo. (e32cb8b, 4422f1e)
- **Fase 12, o parque.** Um parque fácil com castelo cor-de-rosa e balões.
  (c02ccd3)
- **Fase 13, o castelo.** Duas princesas pegam o gato no colo. (ffc3839)
- **Fases 14 e 15, Brasil e monstro gigante.** No Brasil, a foto com as
  princesas faz a tela piscar. No parque, um monstro gigante tem cinco de
  vida e, vencido, faz a bandeira aparecer. (8e112c2)
- **Fase 16, o parque de diversões.** Roda-gigante que gira com o gato e
  camas elásticas, depois um carrossel de cavalinhos, uma montanha-russa,
  uma torre que sobe e desce e uma pescaria onde os peixinhos pulam da água.
  (d913ebe, 805c68f, 87130bf, fe8a154)
- **Mais atalhos de fase.** Ctrl com número vai para as fases de 11 a 20, e
  as teclas + e - vão para a próxima fase e para a anterior. (2abb633)
