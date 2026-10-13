# Como trabalhamos

O jogo é feito por três participantes:

- **A filha (6 anos):** dá as ideias, pede as mudanças por voz, desenha, grava
  sons, monta fases e testa o jogo.
- **O pai:** opera o computador, cuida do Git e ajuda a traduzir as ideias.
- **O Claude:** escreve e muda os arquivos do jogo.

## Ciclo de uma sessão

1. A filha diz o que quer. Exemplo: "quero que o gato pule mais alto".
2. O Claude faz uma mudança pequena e diz em uma frase o que mudou.
3. Ela joga e vê o resultado.
4. Ela diz se gostou ou o que mudar.

Cada volta deve durar poucos minutos. Uma mudança por vez mantém a atenção
dela e facilita desfazer o que não ficou bom.

## Pedidos por voz

Ela fala e o computador transforma a fala em texto:

- **Windows:** digitação por voz, com as teclas `Win` + `H`.
- **Mac:** ditado do sistema, ativado em Ajustes do Sistema > Teclado.
- **Claude Code:** o modo de voz próprio, se a versão instalada tiver.

O texto ditado chega com erros e sem pontuação. O Claude deve interpretar a
intenção e seguir em frente.

### Exemplos

| Ela diz | O Claude faz |
| --- | --- |
| "o gato tem que correr mais rápido" | Aumenta a velocidade do `Player`. |
| "põe mais peixe lá em cima" | Adiciona coletáveis em plataformas altas da fase atual. |
| "quero uma fase com neve" | Cria uma fase nova com chão branco e fundo azul claro. |
| "ficou muito difícil" | Aproxima as plataformas ou aumenta o pulo. |

## Montar fases

No início, ela monta as fases por voz: descreve o que quer, e o Claude edita
o arquivo da fase. Depois, ela pode abrir a fase no editor do Godot e arrastar
as peças com o mouse.

## Desenhos e sons dela

Esta parte começa no último marco do [roteiro](05-roteiro.md).

**Desenhos**

1. Ela desenha no papel com contorno escuro, ou em um tablet.
2. Fotografe ou escaneie o desenho com boa luz.
3. Remova o fundo e salve como PNG com fundo transparente.
4. Salve em `assets/sprites/`, com nome em inglês e minúsculas
   (`cat_idle.png`).

**Sons**

1. Grave com o celular ou com o microfone do computador.
2. Converta para WAV (efeitos curtos) ou OGG (músicas).
3. Salve em `assets/sounds/` ou `assets/music/`.

## Git

- Nunca trabalhe no branch `master`. Cada sessão usa um branch próprio.
- Faça um commit sempre que o jogo estiver funcionando e ela gostar do
  resultado. Isso permite voltar a uma versão boa.
- No fim da sessão, faça o merge do branch direto em `master`, faça o push de
  `master` e apague o branch. O projeto não usa pull requests.
- Anote as ideias dela na lista do [roteiro](05-roteiro.md), mesmo as que
  ficam para depois.
