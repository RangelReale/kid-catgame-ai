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
- [ ] 2026-10-15: 20 fases. Feitas 4: a fase 1, de chão verde, a fase 2,
  de chão de areia, a fase 3, a praia, e a fase 4, o fundo do mar. Uma bandeira no fim de cada fase leva à próxima, e
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
