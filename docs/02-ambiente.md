# Ambiente

Este documento lista o que instalar para trabalhar no jogo. O Windows é o
caminho padrão. O Mac é a alternativa.

Nada aqui foi instalado ainda. Alguns itens estão marcados com **Verificar**:
confirme esses itens na primeira instalação e corrija este documento.

## Windows (caminho padrão)

Os comandos abaixo rodam no PowerShell.

### 1. Git

```powershell
winget install Git.Git
```

### 2. Godot

```powershell
winget install GodotEngine.GodotEngine
```

**Verificar:** o identificador do pacote e a versão instalada (precisa ser
4.7.x). A alternativa é baixar o `.exe` em <https://godotengine.org/download>.
O Godot para Windows é um único executável, sem instalador.

### 3. Godot no PATH

O Claude roda o jogo pela linha de comando, então o comando `godot` precisa
funcionar no terminal. Abra um terminal novo e teste:

```powershell
godot --version
```

Se o comando não existir, renomeie o executável baixado para `godot.exe`,
coloque-o em uma pasta fixa (por exemplo `C:\Tools\Godot`) e adicione essa
pasta à variável de ambiente `PATH`.

### 4. Claude Code

```powershell
irm https://claude.ai/install.ps1 | iex
```

**Verificar:** o comando atual em <https://code.claude.com/docs>. Depois,
clone o repositório e rode `claude` dentro da pasta.

### 5. Android (necessário só a partir do marco 6 do roteiro)

1. Instale o JDK (kit de desenvolvimento Java):
   `winget install EclipseAdoptium.Temurin.17.JDK`.
   **Verificar:** a versão do Java que o Godot 4.7 exige. As versões 4.x
   anteriores exigem o JDK 17.
2. Baixe as "command line tools" do Android em
   <https://developer.android.com/studio#command-line-tools-only> e extraia
   em `C:\Android\cmdline-tools\latest`.
3. Defina a variável de ambiente `ANDROID_HOME` como `C:\Android`.
4. Instale os pacotes do SDK:

   ```powershell
   & "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" "build-tools;35.0.0" "platforms;android-35"
   ```

   **Verificar:** as versões que a documentação do Godot 4.7 pede.
5. Crie a chave de depuração, se `%USERPROFILE%\.android\debug.keystore` não
   existir:

   ```powershell
   keytool -genkeypair -keyalg RSA -alias androiddebugkey -keypass android -keystore "$env:USERPROFILE\.android\debug.keystore" -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12
   ```

6. No Godot, abra **Editor > Editor Settings > Export > Android** e preencha
   o caminho do Java, o caminho do SDK (`C:\Android`) e o caminho da chave de
   depuração.

### Cuidados no Windows

- Os caminhos usam `\`. Dentro do Godot, os caminhos do projeto sempre usam
  `res://` e `/`, em qualquer sistema.
- O Git pode trocar os finais de linha dos arquivos. Um arquivo
  `.gitattributes` vai fixar isso no marco 1 do roteiro.

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
