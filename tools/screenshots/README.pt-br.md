# Capturas de tela da App Store

[English](README.md)

O script `screenshots.gd` gera as capturas de tela da página do jogo na App
Store. Ele mostra a tela de início, em português e em inglês, e cinco
fases: a primeira, o fundo do mar, o ratão, o céu e a roda-gigante. O
jogo é desenhado no tamanho exato que a App Store pede, qualquer que seja a
tela do computador.

| Aparelho | Tamanho |
| --- | --- |
| iPhone de 6,9" | 2868 x 1320 |
| iPad de 13" | 2752 x 2064 |

Rode a partir da raiz do repositório. No Windows, use `godot_console` no
lugar de `godot`. O Godot abre uma janela por alguns segundos:

```sh
godot --path . --fixed-fps 60 -s tools/screenshots/screenshots.gd
```

As imagens ficam em `build/screenshots/`. A lista `SHOTS` diz qual fase
entra, onde o gato começa e quanto tempo ele joga antes da foto. A lista
`SIZES` tem os tamanhos.
