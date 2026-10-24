# Tecnologia

[English](../docs-en/01-technology.md)

## O que o jogo precisa

- Ser um jogo 2D de plataforma lateral (side-scroller): o personagem anda e
  pula, e a tela acompanha.
- Rodar em Windows, Android e Mac, nessa ordem de prioridade.
- No Android, rodar em um celular e em um Retroid Pocket 3+, um videogame
  portátil com Android 11 e botões físicos.
- Ser simples o bastante para uma criança de 6 anos participar.
- Ter todos os arquivos em formato de texto, para o Claude ler e editar.

## Escolha: Godot 4

O Godot é um motor de jogos, isto é, um programa que já traz física, desenho
na tela, som e entrada de teclado e toque. Escolhemos o Godot 4 por quatro
motivos:

- **Exporta para as três plataformas.** O mesmo projeto gera um `.exe` para
  Windows, um `.apk` para Android e um `.app` para Mac, sem código separado.
- **Os arquivos são texto.** As cenas (`.tscn`) e os scripts (`.gd`) são texto
  puro. O Claude consegue criar e mudar fases, personagens e regras.
- **Tem editor visual.** A criança vê a fase na tela e pode arrastar
  plataformas e objetos com o mouse.
- **É gratuito e de código aberto.** Não há licença, conta ou cobrança.

## Alternativas avaliadas

| Opção | Ponto forte | Por que não |
| --- | --- | --- |
| Go + Ebitengine | Usa Go, linguagem já conhecida. | Não tem editor visual. O Android exige um projeto extra. |
| Phaser + Capacitor | Roda no navegador, fácil de testar. | Precisa de empacotadores diferentes para Android e para computador. |
| LÖVE (Lua) | Pequeno e simples. | Não tem editor visual. O empacotamento para Android é manual. |

## Escolhas dentro do Godot

- **Versão:** 4.7.x. Todos os computadores devem usar a mesma versão menor
  (4.7), porque o Godot regrava arquivos do projeto ao abrir em outra versão.
- **Linguagem:** GDScript, a linguagem própria do Godot, com tipos declarados.
  A alternativa C# exige mais instalação e complica a exportação.
- **Renderizador:** Compatibility. O renderizador é a parte que desenha na
  tela. O Compatibility é o mais leve e funciona em celulares Android antigos.
  Um jogo 2D simples não precisa dos outros.
