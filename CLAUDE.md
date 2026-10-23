# Jogo do gato

Um jogo 2D de plataforma lateral com um gato, feito por um pai e sua filha de
6 anos. Os detalhes estão em [docs/](docs/README.md).

**Estado atual:** o marco 3 do [roteiro](docs/05-roteiro.md) está pronto. O
gato tem corpo arco-íris, patas, rabo e cabeça cor-de-rosa com orelhas, olho
e boca, e asas. Ele anda e pula, com cambalhota, sobre um chão verde. No
ar, bate as asas para subir mais, até três vezes antes de pousar. Cada pulo
faz um "boing" (`assets/sounds/jump.wav`, gerado por código), mais agudo a
cada batida de asa. A fase tem
quatro telas de largura, com uma caixa, uma plataforma e um degrau, e a
câmera segue o gato. No céu, um sol sorridente gira os raios devagar, e três nuvens passam. Três monstrinhos andam pelo chão. Quando o gato
pula em cima de um, ele some num "puf" de estrelinhas e o gato quica. Tocar
um monstrinho de lado não faz nada. Há dezesseis fases. A terceira é uma praia com mar raso no fim. A quarta é o
fundo do mar, onde o gato tem cauda de sereia e nada: sobe com pular, desce
com `move_down` e fica parado na altura quando nada é apertado. A quinta
começa no mar e entra numa sala de computadores. Na sexta, um homem bravo
anda atrás do gato pela sala; se ele alcançar o gato, a fase recomeça. A sétima é uma floresta bem
fácil, com um ratinho num disco voador e, no fim, um ratão com barra de
vida: três pulos em cima dele fazem a bandeira aparecer. A oitava é no céu: o gato
voa livre e desvia de passarinhos; se um encostar nele, a fase recomeça. A nona é o gato descendo do céu, de
nuvem em nuvem, até a grama. A décima é dentro de um avião: esbarrar numa
mala faz a fase recomeçar. Na décima primeira, sem controles, o
avião decola, voa e pousa sozinho, e um homem sorridente pega o gato no
colo. A décima segunda é um parque bem fácil, com um castelo cor-de-rosa e
balões. Na décima terceira, dentro do castelo, duas princesas pegam o gato
no colo. Na décima quarta, no Brasil, a foto com as princesas faz a tela
piscar. Na décima quinta, no parque, um monstro gigante tem cinco de vida;
vencido, a bandeira aparece. Na décima sexta, o gato brinca no parque numa
roda-gigante que gira com ele, num carrossel de cavalinhos, em camas
elásticas, numa montanha-russa, numa torre que sobe e desce e numa pescaria, onde
encostar num peixinho faz ele pular da água. As teclas de 1 a 9 e o 0 pulam direto
para as fases de 1 a 10; com Ctrl, para as fases de 11 a 20. As teclas + e -
vão para a próxima fase e para a anterior. Uma bandeira no fim de
cada uma leva à próxima (marco 8 pronto). O jogo abre numa tela de início
com "Jogo do gato" em letras grandes e algumas fases rodando sozinhas no
fundo, em tom sépia. Toca uma musiquinha de bipes, como nos PCs antigos
(`assets/music/title.wav`, gerada por `tools/music/make_title_music.py`), e
os sons das fases ficam mudos no canal `Sounds`. Qualquer botão começa a
fase 1. No fim da
última fase, a imagem para e fica sépia, aparece "Você venceu!" e sobem os
créditos, "Feito por", "Filha" e "Pai". Depois, pisca "Aperte um botão
para voltar", e um botão volta à tela de início. Do marco 4, falta o peixe para pegar. Em telas de toque sem
controle, quatro botões redondos nos cantos de baixo fazem o gato andar e
pular (início do marco 6). O jogo também roda no iPad. A filha pediu 20 fases. Atualize esta seção a cada marco.

## Quem pede as mudanças

Muitos pedidos vêm da criança, ditados por voz. O texto chega informal, com
erros de transcrição e sem detalhes.

- Escolha a interpretação mais simples e faça. Não faça perguntas técnicas.
- Faça uma mudança pequena e visível por vez.
- Depois de mudar, diga em uma ou duas frases curtas o que mudou e como ver
  isso no jogo. Use palavras que uma criança de 6 anos entende.
- Se o pedido for grande, faça a primeira parte jogável e diga o que falta.
- Anote ideias novas em "Ideias da filha", em `docs/05-roteiro.md`.
- O conteúdo do jogo é para criança: sem violência e sem sustos. O jogador
  não pode precisar ler para jogar.

## Idioma

- Respostas, documentos e commits: português.
- Código, nomes de arquivos, nós e ações: inglês.

## Tecnologia

- Godot 4.7, com GDScript tipado e renderizador Compatibility.
- Plataformas, em ordem de prioridade: Windows, Android, Mac.
- O desenvolvimento acontece principalmente no Windows e também no Mac.
  Verifique o sistema antes de rodar comandos. Não assuma caminhos de um só.

## Comandos

Os comandos são iguais no PowerShell (Windows) e no zsh (Mac), desde que
`godot` esteja no `PATH`. Rode a partir da raiz do repositório.

No Windows, `godot` não escreve no terminal e não espera o Godot terminar.
Nos comandos com `--headless`, e sempre que a saída importa, use
`godot_console` no lugar de `godot`, com os mesmos argumentos.

| Tarefa | Comando |
| --- | --- |
| Abrir o editor | `godot -e --path .` |
| Rodar o jogo | `godot --path .` |
| Rodar com os botões de toque | `godot --path . -- --touch` |
| Importar recursos sem abrir o editor | `godot --headless --path . --import` |
| Exportar para Windows | `godot --headless --path . --export-release "Windows Desktop" build/windows/catgame.exe` |
| Exportar para Android | `godot --headless --path . --export-debug "Android" build/android/catgame.apk` |
| Exportar para iPad (só no Mac) | `godot --headless --path . --export-debug "iOS" build/ios/catgame.xcodeproj` |
| Exportar para a web | `godot --headless --path . --export-release "Web" build/web/index.html` |
| Exportar para Mac | `godot --headless --path . --export-release "macOS" build/macos/catgame.zip` |

Os nomes entre aspas são os nomes das predefinições em `export_presets.cfg`.
Por enquanto, esse arquivo tem as predefinições "Android", "iOS", "Web" e
"Windows Desktop". A do Mac nasce no marco 5. A pasta de destino precisa existir antes da exportação. Para
instalar no Retroid Pocket 3+ ou no iPad, veja [docs/02-ambiente.md](docs/02-ambiente.md).

Para publicar uma versão no GitHub, veja "Publicar uma versão" em
[docs/02-ambiente.md](docs/02-ambiente.md).

Para confirmar que o jogo abre sem erros, rode-o por alguns quadros e leia a
saída: `godot --path . --quit-after 120` (no Windows, com `godot_console`).

## Organização

Resumo de [docs/03-arquitetura.md](docs/03-arquitetura.md):

- `scenes/`: cenas (`.tscn`), com o script (`.gd`) ao lado e com o mesmo nome.
- `assets/`: imagens, sons, músicas e fontes.
- `build/`: jogos exportados, fora do Git.
- Arquivos em `snake_case`, nós em `PascalCase`.

## Regras

- Nunca trabalhe em `master`. Crie um branch antes de qualquer mudança.
- Quando o trabalho do branch estiver pronto, faça o commit, faça o merge
  direto em `master`, faça o push de `master` e apague o branch. Este projeto
  não usa pull requests.
- Não edite a pasta `.godot/` nem os arquivos `.import`. O Godot os gera.
- Fases são dados: cada fase é um `.tscn`. Não monte fases por código.
- Leia entradas por ações (`move_left`, `move_right`, `move_down`, `jump`), nunca por
  teclas.
- Mantenha a parte visual de cada cena em um nó `Visual` separado, para que a
  troca de retângulos por desenhos não mexa na lógica.
- Valores de ajuste, como velocidade e altura do pulo, ficam em variáveis
  `@export`.
- Depois de mudar o jogo, rode-o e confirme que abre sem erros antes de dizer
  que terminou.
