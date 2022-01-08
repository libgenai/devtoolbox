# DevTools

<img src="https://user-images.githubusercontent.com/19304/147850849-b72566e9-86f5-4349-ae7f-7e8b07088cea.png"/>

Online utilities for formatting, encoding/decoding etc are dangerous to use (many of them steal secrets from your data) and are in fact prohibited at many workplaces. This offline desktop app is a collection of many such utilities:

 - Base64 Encoding/Decoding
 - JSON Formatting / Validating / Extracting
 - JSON <-> YAML Conversion
 - QR Image <-> Text Conversion
 - JWT Inspection
 - More coming soon

This app is written in Flutter and therefore, works on MacOS, Linux, Windows and even Web if your org would like to host it internally as a webapp. But do not expect this to work on Android and iOS.

Make sure to read [the LICENSE](/LICENSE.md) and [the CLA](/CLA.md).

### How to build:

MacOS:

1. ensure your flutter base is up-to-date : `devtools requires SDK version >=2.15.1 <3.0.0, version solving failed.`

`flutter update`

2. ensure desktop building is enabled otherwise you will get an error `"build macos" is not currently supported. To enable, run "flutter config --enable-macos-desktop".`

`flutter config --enable-macos-desktop`

3. Build the app using 
`flutter build macos --release` 
this will generate the .app file in `build/macos/Build/Products/Release/devtools.app`.

Convert the app to DMG using create-dmg tool
4. ensure the create-dmg tool is installed
`brew install create-dmg`

5. Create a DMG file
`test -f DevTools.dmg && rm DevTools.dmg && create-dmg --app-drop-link 400 100 --icon-size 50 --window-size 600 400 --window-pos 400 400 DevTools.dmg build/macos/Build/Products/Release/devtools.app`

### UI Widget Library

We use [macos_ui](https://github.com/GroovinChip/macos_ui). You can find [examples of all their widgets here](https://github.com/GroovinChip/macos_ui/tree/dev/example/lib/pages).