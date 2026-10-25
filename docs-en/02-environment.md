# Environment

[Português](../docs-pt-br/02-ambiente.md)

This document lists what to install to work on the game. Windows is the
default path. Mac is the alternative.

On Windows, Git, Godot 4.7.2, Claude Code, the Android SDK and the export
templates are already installed. On Mac, Godot has not been installed yet.

Some items are marked **Verify**: confirm these items on the first
installation and fix this document.

## Windows (default path)

The commands below run in PowerShell.

### 1. Git

```powershell
winget install Git.Git
```

### 2. Godot

Run this command in a PowerShell opened **as administrator**:

```powershell
winget install --id GodotEngine.GodotEngine --exact --version 4.7.2
```

Godot for Windows has no installer. winget extracts two executables into
`%LOCALAPPDATA%\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_...`:

- `Godot_v4.7.2-stable_win64.exe`: the editor and the game.
- `Godot_v4.7.2-stable_win64_console.exe`: opens the first one and shows its
  output in the terminal.

The alternative to winget is to download the `.zip` from
<https://godotengine.org/download>.

### 3. Godot on the PATH

Claude runs the game from the command line, so the `godot` command must work
in the terminal.

As administrator, winget creates the `godot` and `godot_console` commands in
`%LOCALAPPDATA%\Microsoft\WinGet\Links` and adds that folder to the `PATH`.
The commands are shortcuts (symbolic links) to the two executables above.

Without administrator privileges, winget cannot create the shortcuts, and the
commands do not exist. In that case, uninstall with
`winget uninstall --id GodotEngine.GodotEngine --exact` and install again as
administrator.

Open a new terminal and test:

```powershell
godot_console --version
```

The expected result starts with `4.7.2.stable`.

On Windows, the `godot` command does not write to the terminal and does not
wait for Godot to finish. Use `godot` to open the editor or the game. Use
`godot_console`, with the same arguments, when the output matters:
`--version`, `--headless`, `--import` and `--export-*`.

### 4. Claude Code

```powershell
irm https://claude.ai/install.ps1 | iex
```

**Verify:** the current command at <https://code.claude.com/docs>. Then
clone the repository and run `claude` inside the folder.

### 5. Android (needed only from milestone 6 of the roadmap)

The current Windows machine already has the Android SDK in
`%LOCALAPPDATA%\Android\Sdk`, with `platform-tools`, `build-tools;35.0.0` and
`platforms;android-35`, and the debug key in
`%USERPROFILE%\.android\debug.keystore`. Do not install a second SDK.

Still to do:

1. Set the `ANDROID_HOME` environment variable to
   `%LOCALAPPDATA%\Android\Sdk`.
2. Confirm the JDK (Java development kit). The current Windows machine has
   Microsoft's JDK 21, and `JAVA_HOME` points to it. Godot 4.7.2 exports and
   signs the `.apk` with JDK 21 without errors.
3. **Verify:** whether the SDK versions above are the ones the Godot 4.7
   documentation asks for. To install others:

   ```powershell
   & "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;35.0.0" "platforms;android-35"
   ```

4. In Godot, open **Editor > Editor Settings > Export > Android** and fill in
   the Java path, the SDK path and the debug key path.

On a Windows computer without an SDK, download the Android "command line
tools" from
<https://developer.android.com/studio#command-line-tools-only>, extract them
into `<SDK folder>\cmdline-tools\latest` and run the command from step 3 with
`"platform-tools"` added. To create the debug key:

```powershell
keytool -genkeypair -keyalg RSA -alias androiddebugkey -keypass android -keystore "$env:USERPROFILE\.android\debug.keystore" -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12
```

### Windows caveats

- Paths use `\`. Inside Godot, project paths always use `res://` and `/`, on
  any system.
- Git may change the line endings of files. The `.gitattributes` file fixes
  line endings to LF on both systems.

## Mac (alternative)

### 1. Godot

```sh
brew install --cask godot
godot --version
```

### 2. Android

The current Mac already has the Android SDK in
`/opt/homebrew/share/android-commandlinetools`, exported as `ANDROID_HOME`,
and the key in `~/.android/debug.keystore`. Do not install a second SDK.

In Godot, open **Godot > Editor Settings > Export > Android** and fill in the
Java path, the SDK path and the debug key path.

The current Mac has JDK 21. **Verify:** whether Godot 4.7 accepts JDK 21. If
it requires 17, install it with `brew install openjdk@17` and point Godot to
that JDK.

### 3. iPad

The iPad game can only be built on a Mac. It needs Xcode in
`/Applications/Xcode.app` and an Apple developer account. The account's Team
ID (`5XV6P36QZR`) is already in the "iOS" preset.

This Mac's `xcode-select` points to the Command Line Tools. That is why the
commands below use `DEVELOPER_DIR` to find Xcode.

The iPad must be paired with the Mac, by cable or over Wi-Fi. To see the
devices and the identifier (UDID) of each one:

```sh
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcrun devicectl list devices
```

To build, install and open the game:

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

The iPad must be unlocked for the game to open. The preset only generates
the Xcode project (`export_project_only`); `xcodebuild` compiles and signs.

### 4. Uploading to the App Store

Before each upload, raise `application/version` in the "iOS" preset of
`export_presets.cfg`. The App Store refuses two uploads with the same number.
For a new version of the game, also change `application/short_version`.

```sh
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
rm -rf build/ios && mkdir -p build/ios
godot --headless --path . --export-release "iOS" build/ios/catgame.xcodeproj
xcodebuild -project build/ios/catgame.xcodeproj -scheme catgame \
  -configuration Release -destination 'generic/platform=iOS' \
  -archivePath build/ios/catgame.xcarchive -allowProvisioningUpdates \
  CODE_SIGN_IDENTITY="Apple Development" archive
xcodebuild -exportArchive -archivePath build/ios/catgame.xcarchive \
  -exportOptionsPlist tools/app_store/ExportOptions.plist \
  -exportPath build/ios/export -allowProvisioningUpdates
```

`archive` signs for development, and `-exportArchive` signs again for the
store and uploads. After about 15 minutes, the upload shows up in App Store
Connect, in the version's "Build" section. Godot already declares in
`Info.plist` that the game uses no encryption (`ITSAppUsesNonExemptEncryption`).

## Common to both systems

### Export templates

Export templates are the files Godot uses to build the game for each
platform. Download them once per computer, in **Editor > Manage Export
Templates > Download and Install**.

Without the editor, download `Godot_v4.7.2-stable_export_templates.tpz` from
<https://github.com/godotengine/godot-builds/releases>. The file is a `.zip`.
Copy the contents of its `templates/` folder to
`%APPDATA%\Godot\export_templates\4.7.2.stable\` (Windows) or
`~/Library/Application Support/Godot/export_templates/4.7.2.stable/` (Mac).

### Who exports what

| Export to | On Windows | On Mac |
| --- | --- | --- |
| Windows | Yes | Yes |
| Android | Yes | Yes |
| Mac | Yes, but unsigned | Yes |
| iPad | No | Yes |

An unsigned Mac app shows a security warning when opened. That is why the
final Mac version should be exported on the Mac.

### Publishing a release

The `Release` workflow (`.github/workflows/release.yml`) creates a release
on GitHub with a Windows installer, an Android APK and a web zip. It only
runs by hand:

1. On GitHub, open **Actions > Release > Run workflow**.
2. Type the version without the `v`, for example `0.3`.
3. The workflow creates the tag `v0.3` on the `master` commit and attaches
   the files `catgame-0.3-setup.exe`, `catgame-0.3.apk` and
   `catgame-0.3-web.zip` to the release.

From the terminal: `gh workflow run release.yml -f version=0.3`.

The installer is made with NSIS (`tools/installer/catgame.nsi`). It installs
the game in the user's folder, without asking for administrator permission,
and creates shortcuts in the Start menu and on the desktop.

The APK is signed with the Android release key. The key is stored in the
repository's GitHub secrets: `ANDROID_KEYSTORE_BASE64` (the file in base64),
`ANDROID_KEYSTORE_ALIAS` and `ANDROID_KEYSTORE_PASSWORD`. The original copy
of the key and the password are kept outside the repository, on the
father's computer. Keep a backup of them. Without the key, a new version
does not install over the old one.

An APK signed with the release key does not install over a debug APK.
Uninstall the debug version first.

The web zip has the `index.html` and the game files. It runs on any static
file hosting, such as itch.io or Netlify, because the "Web" preset does not
use threads. Opening `index.html` straight from disk does not work: the
browser blocks the game. To play on the computer, run a local server in the
unzipped folder, for example `python -m http.server`, and open
`http://localhost:8000`. Sound only plays after the first click on the page.
On touch screens, the first touch puts the game in full screen and in
landscape; the script is in `html/head_include`, in the "Web" preset. The
iPhone does not let pages go full screen. In the browser, Ctrl with a number
switches tabs, so the shortcuts for levels 11 to 20 do not work.

### Web version on GitHub Pages

The `Pages` workflow (`.github/workflows/pages.yml`) exports the web version
and publishes it at <https://rangelreale.github.io/kid-catgame-ai/>. It runs
on every push to `master`, except when only documents change. To run it by
hand: `gh workflow run pages.yml`. GitHub Pages works because the
repository is public.

### Testing on an Android phone

1. On the phone, enable **Developer options** and **USB debugging**.
2. Connect the phone to the computer with a USB cable and accept the prompt
   on the phone.
3. Confirm the computer sees the phone: `adb devices`.
4. In the Godot editor, click the **Remote Deploy** button (phone icon, in
   the top right corner). The game is installed and opened on the phone.

### Testing on the Retroid Pocket 3+

Follow the same steps as for the phone. The "Android" preset in
`export_presets.cfg` already selects the `arm64-v8a` architecture, the only
one on the device. Exporting without Gradle uses the template's Min SDK,
which is lower than 30 (Android 11, the device's version).

The game opens on the device with Godot 4.7.2 and the Compatibility renderer
(OpenGL ES 3.2 on the Mali-G52 GPU).

Do not turn on **Wireless debugging** in Developer options: the device
restarts by itself when that screen opens. To use adb without a cable,
connect the cable once and run:

```powershell
adb tcpip 5555
adb connect <device IP>:5555
```

The IP appears in **Settings > Wi-Fi**, or with
`adb shell ip -f inet addr show wlan0`. Wireless mode ends when the device
restarts.

To install and open the game from the command line:

```powershell
adb install -r build/android/catgame.apk
adb shell monkey -p com.rangelreale.catgame -c android.intent.category.LAUNCHER 1
```

On Windows, `adb` is in `%LOCALAPPDATA%\Android\Sdk\platform-tools`, outside
the `PATH`.
