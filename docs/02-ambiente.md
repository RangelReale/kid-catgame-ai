# Ambiente

Este documento lista o que instalar para trabalhar no jogo. O Windows é o
caminho padrão. O Mac é a alternativa.

No Windows, o Git, o Godot 4.7.2, o Claude Code, o SDK Android e os modelos
de exportação já estão instalados. No Mac, o Godot ainda não foi instalado.

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
   da Microsoft, e `JAVA_HOME` aponta para ele. O Godot 4.7.2 exporta e
   assina o `.apk` com o JDK 21 sem erros.
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

### 3. iPad

O jogo para iPad só pode ser gerado no Mac. Ele precisa do Xcode em
`/Applications/Xcode.app` e de uma conta de desenvolvedor da Apple. O Team ID
da conta (`5XV6P36QZR`) já está na predefinição "iOS".

O `xcode-select` deste Mac aponta para as Command Line Tools. Por isso os
comandos abaixo usam `DEVELOPER_DIR` para achar o Xcode.

O iPad precisa estar pareado com o Mac, pelo cabo ou por Wi-Fi. Para ver os
aparelhos e o identificador (UDID) de cada um:

```sh
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcrun devicectl list devices
```

Para gerar, instalar e abrir o jogo:

```sh
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
mkdir -p build/ios
godot --headless --path . --export-debug "iOS" build/ios/catgame.xcodeproj
xcodebuild -project build/ios/catgame.xcodeproj -scheme catgame \
  -configuration Debug -destination 'platform=iOS,id=<UDID>' \
  -derivedDataPath build/ios/dd -allowProvisioningUpdates build
xcrun devicectl device install app --device <UDID> \
  build/ios/dd/Build/Products/Debug-iphoneos/catgame.app
xcrun devicectl device process launch --device <UDID> com.rangelreale.catgame
```

O iPad precisa estar desbloqueado para o jogo abrir. A predefinição só gera o
projeto do Xcode (`export_project_only`); o `xcodebuild` compila e assina.

## Comum aos dois sistemas

### Modelos de exportação

Os modelos de exportação (export templates) são os arquivos que o Godot usa
para gerar o jogo de cada plataforma. Baixe uma vez por computador, em
**Editor > Manage Export Templates > Download and Install**.

Sem o editor, baixe `Godot_v4.7.2-stable_export_templates.tpz` em
<https://github.com/godotengine/godot-builds/releases>. O arquivo é um `.zip`.
Copie o conteúdo da pasta `templates/` dele para
`%APPDATA%\Godot\export_templates.7.2.stable\` (Windows) ou
`~/Library/Application Support/Godot/export_templates/4.7.2.stable/` (Mac).

### Quem exporta o quê

| Exportar para | No Windows | No Mac |
| --- | --- | --- |
| Windows | Sim | Sim |
| Android | Sim | Sim |
| Mac | Sim, mas sem assinatura | Sim |
| iPad | Não | Sim |

Um aplicativo de Mac sem assinatura mostra um aviso de segurança ao abrir.
Por isso a versão final para Mac deve ser exportada no Mac.

### Publicar uma versão

O workflow `Release` (`.github/workflows/release.yml`) cria uma versão no
GitHub com um instalador para Windows, um APK para Android e um zip para a
web. Ele só roda à mão:

1. No GitHub, abra **Actions > Release > Run workflow**.
2. Escreva a versão sem o `v`, por exemplo `0.3`.
3. O workflow cria a tag `v0.3` no commit de `master` e anexa à versão os
   arquivos `catgame-0.3-setup.exe`, `catgame-0.3.apk` e
   `catgame-0.3-web.zip`.

Pelo terminal: `gh workflow run release.yml -f version=0.3`.

O instalador é feito com o NSIS (`tools/installer/catgame.nsi`). Ele instala
o jogo na pasta do usuário, sem pedir permissão de administrador, e cria
atalhos no menu Iniciar e na área de trabalho.

O APK é assinado com a chave de release do Android. A chave fica nos segredos
do repositório no GitHub: `ANDROID_KEYSTORE_BASE64` (o arquivo em base64),
`ANDROID_KEYSTORE_ALIAS` e `ANDROID_KEYSTORE_PASSWORD`. A cópia original fica
no computador do pai, em `%USERPROFILE%\Documents\keys\android\`, com a
senha em `catgame-release.txt`. Guarde uma cópia de segurança dessa pasta.
Sem a chave, uma versão nova não instala por cima da antiga.

Um APK assinado com a chave de release não instala por cima de um APK de
depuração. Desinstale a versão de depuração antes.

O zip da web tem o `index.html` e os arquivos do jogo. Ele roda em qualquer
hospedagem de arquivos estáticos, como o itch.io ou o Netlify, porque a
predefinição "Web" não usa threads. Abrir o `index.html` direto do disco não
funciona: o navegador bloqueia o jogo. Para jogar no computador, rode um
servidor local na pasta descompactada, por exemplo `python -m http.server`, e
abra `http://localhost:8000`. O som só toca depois do primeiro clique na
página. Em telas de toque, o primeiro toque põe o jogo em tela cheia e
deitado; o script fica em `html/head_include`, na predefinição "Web". O
iPhone não deixa páginas entrarem em tela cheia. No navegador, Ctrl com um número troca de aba, então os atalhos das
fases 11 a 20 não funcionam.

### Testar no celular Android

1. No celular, ative as **Opções do desenvolvedor** e a **Depuração USB**.
2. Ligue o celular ao computador por cabo USB e aceite o aviso no celular.
3. Confirme que o computador vê o celular: `adb devices`.
4. No editor do Godot, clique no botão **Remote Deploy** (ícone de celular,
   no canto superior direito). O jogo é instalado e aberto no celular.

### Testar no Retroid Pocket 3+

Siga os mesmos passos do celular. A predefinição "Android" em
`export_presets.cfg` já marca a arquitetura `arm64-v8a`, a única do aparelho.
A exportação sem Gradle usa o Min SDK do modelo, menor que 30 (Android 11, a
versão do aparelho).

O jogo abre no aparelho com o Godot 4.7.2 e o renderizador Compatibility
(OpenGL ES 3.2 na GPU Mali-G52).

Não ligue a **Depuração por Wi-Fi** nas Opções do desenvolvedor: o aparelho
reinicia sozinho ao abrir essa tela. Para usar o adb sem cabo, ligue o cabo
uma vez e rode:

```powershell
adb tcpip 5555
adb connect <IP do aparelho>:5555
```

O IP aparece em **Configurações > Wi-Fi**, ou com
`adb shell ip -f inet addr show wlan0`. O modo sem fio acaba quando o aparelho
reinicia.

Para instalar e abrir o jogo pela linha de comando:

```powershell
adb install -r build/android/catgame.apk
adb shell monkey -p com.rangelreale.catgame -c android.intent.category.LAUNCHER 1
```

No Windows, o `adb` fica em `%LOCALAPPDATA%\Android\Sdk\platform-tools`,
fora do `PATH`.
