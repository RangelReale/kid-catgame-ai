# Jogo do gato

Um jogo 2D de plataforma lateral com um gato, feito por um pai e sua filha de
6 anos. Os detalhes estão em [docs/](docs/README.md).

**Estado atual:** só existem documentos. O projeto Godot ainda não foi criado.
O próximo passo é o marco 1 do [roteiro](docs/05-roteiro.md). Atualize esta
seção e os comandos abaixo quando o projeto existir.

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
| Importar recursos sem abrir o editor | `godot --headless --path . --import` |
| Exportar para Windows | `godot --headless --path . --export-release "Windows Desktop" build/windows/catgame.exe` |
| Exportar para Android | `godot --headless --path . --export-debug "Android" build/android/catgame.apk` |
| Exportar para Mac | `godot --headless --path . --export-release "macOS" build/macos/catgame.zip` |

Os nomes entre aspas são os nomes das predefinições em `export_presets.cfg`.
A pasta de destino precisa existir antes da exportação.

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
- Leia entradas por ações (`move_left`, `move_right`, `jump`), nunca por
  teclas.
- Mantenha a parte visual de cada cena em um nó `Visual` separado, para que a
  troca de retângulos por desenhos não mexa na lógica.
- Valores de ajuste, como velocidade e altura do pulo, ficam em variáveis
  `@export`.
- Depois de mudar o jogo, rode-o e confirme que abre sem erros antes de dizer
  que terminou.
