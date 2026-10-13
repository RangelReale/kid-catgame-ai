# Ambiente

Este documento lista o que instalar para trabalhar no jogo. O Windows é o
caminho padrão. O Mac é a alternativa.

No Windows, o Git, o Godot 4.7.2 e o Claude Code já estão instalados. O
Android e os modelos de exportação ainda não foram configurados. No Mac, o
Godot ainda não foi instalado.

Alguns itens estão marcados com **Verificar**: confirme esses itens na
primeira instalação e corrija este documento.

## Windows (caminho padrão)

Os comandos abaixo rodam no PowerShell.

### 1. Git

```powershell
winget install Git.Git
```

### 2. Godot

Rode este comando em um PowerShell aberto **como administrador**:

```powershell
winget install --id GodotEngine.GodotEngine --exact --version 4.7.2
```

O Godot para Windows não tem instalador. O winget extrai dois executáveis em
`%LOCALAPPDATA%\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_...`:

- `Godot_v4.7.2-stable_win64.exe`: o editor e o jogo.
- `Godot_v4.7.2-stable_win64_console.exe`: abre o primeiro e mostra a saída
  dele no terminal.

A alternativa ao winget é baixar o `.zip` em
<https://godotengine.org/download>.

### 3. Godot no PATH

O Claude roda o jogo pela linha de comando, então o comando `godot` precisa
funcionar no terminal.

Como administrador, o winget cria os comandos `godot` e `godot_console` em
`%LOCALAPPDATA%\Microsoft\WinGet\Links` e adiciona essa pasta ao `PATH`. Os
comandos são atalhos (links simbólicos) para os dois executáveis acima.

Sem privilégios de administrador, o winget não consegue criar os atalhos, e
os comandos não existem. Nesse caso, desinstale com
`winget uninstall --id GodotEngine.GodotEngine --exact` e instale de novo como
administrador.

Abra um terminal novo e teste:

```powershell
godot_console --version
```

O resultado esperado começa com `4.7.2.stable`.

No Windows, o comando `godot` não escreve no terminal e não espera o Godot
terminar. Use `godot` para abrir o editor ou o jogo. Use `godot_console`, com
os mesmos argumentos, quando a saída importa: `--version`, `--headless`,
`--import` e `--export-*`.

### 4. Claude Code

```powershell
irm https://claude.ai/install.ps1 | iex
```

**Verificar:** o comando atual em <https://code.claude.com/docs>. Depois,
clone o repositório e rode `claude` dentro da pasta.

### 5. Android (necessário só a partir do marco 6 do roteiro)

O Windows atual já tem o SDK Android em `%LOCALAPPDATA%\Android\Sdk`, com
`platform-tools`, `build-tools;35.0.0` e `platforms;android-35`, e a chave de
depuração em `%USERPROFILE%\.android\debug.keystore`. Não instale um segundo
SDK.

Falta fazer:

1. Defina a variável de ambiente `ANDROID_HOME` como
   `%LOCALAPPDATA%\Android\Sdk`.
2. Confirme o JDK (kit de desenvolvimento Java). O Windows atual tem o JDK 21
   da Microsoft, e `JAVA_HOME` aponta para ele. **Verificar:** se o Godot 4.7
   aceita o JDK 21. As versões 4.x anteriores exigem o JDK 17. Se ele exigir
   o 17, instale com `winget install EclipseAdoptium.Temurin.17.JDK` e aponte
   o Godot para esse JDK.
3. **Verificar:** se as versões do SDK acima são as que a documentação do
   Godot 4.7 pede. Para instalar outras:

   ```powershell
   & "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;35.0.0" "platforms;android-35"
   ```

4. No Godot, abra **Editor > Editor Settings > Export > Android** e preencha
   o caminho do Java, o caminho do SDK e o caminho da chave de depuração.

Em um computador Windows sem SDK, baixe as "command line tools" do Android em
<https://developer.android.com/studio#command-line-tools-only>, extraia em
`<pasta do SDK>\cmdline-tools\latest` e rode o comando do passo 3 com
`"platform-tools"` a mais. Para criar a chave de depuração:

```powershell
keytool -genkeypair -keyalg RSA -alias androiddebugkey -keypass android -keystore "$env:USERPROFILE\.android\debug.keystore" -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12
```

### Cuidados no Windows

- Os caminhos usam `\`. Dentro do Godot, os caminhos do projeto sempre usam
  `res://` e `/`, em qualquer sistema.
- O Git pode trocar os finais de linha dos arquivos. O arquivo
  `.gitattributes` fixa o final de linha em LF nos dois sistemas.

## Mac (alternativa)

### 1. Godot

```sh
brew install --cask godot
godot --version
```

### 2. Android

O Mac atual já tem o SDK Android em
`/opt/homebrew/share/android-commandlinetools`, exportado como `ANDROID_HOME`,
e a chave em `~/.android/debug.keystore`. Não instale um segundo SDK.

No Godot, abra **Godot > Editor Settings > Export > Android** e preencha o
caminho do Java, o caminho do SDK e o caminho da chave de depuração.

O Mac atual tem o JDK 21. **Verificar:** se o Godot 4.7 aceita o JDK 21. Se
ele exigir o 17, instale com `brew install openjdk@17` e aponte o Godot para
esse JDK.

## Comum aos dois sistemas

### Modelos de exportação

Os modelos de exportação (export templates) são os arquivos que o Godot usa
para gerar o jogo de cada plataforma. Baixe uma vez por computador, em
**Editor > Manage Export Templates > Download and Install**.

### Quem exporta o quê

| Exportar para | No Windows | No Mac |
| --- | --- | --- |
| Windows | Sim | Sim |
| Android | Sim | Sim |
| Mac | Sim, mas sem assinatura | Sim |

Um aplicativo de Mac sem assinatura mostra um aviso de segurança ao abrir.
Por isso a versão final para Mac deve ser exportada no Mac.

### Testar no celular Android

1. No celular, ative as **Opções do desenvolvedor** e a **Depuração USB**.
2. Ligue o celular ao computador por cabo USB e aceite o aviso no celular.
3. Confirme que o computador vê o celular: `adb devices`.
4. No editor do Godot, clique no botão **Remote Deploy** (ícone de celular,
   no canto superior direito). O jogo é instalado e aberto no celular.

### Testar no Retroid Pocket 3+

Siga os mesmos passos do celular. A predefinição de exportação "Android"
precisa de duas coisas para o `.apk` instalar nele:

- A arquitetura `arm64-v8a` marcada.
- O campo **Min SDK** igual ou menor que 30, porque o aparelho usa
  Android 11 (API 30).

**Verificar:** se o jogo abre no aparelho. O Godot 4.7 ainda não foi testado
no chip dele (Unisoc T618, GPU Mali-G52).
