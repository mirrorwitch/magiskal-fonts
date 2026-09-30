## mirrorwitch's magisckal fonts

Personal Magisk module to update fonts on my manga reading tablet.

This updates the fonts in my Galaxy Tab S3 running LineageOS 18.1 (Android 11).
**The fonts.xml file will not be safe to use in other devices or ROMs than this
combination.** This project is probably not useful for anyone else except maybe
as a basis you can modify to make your own.

Fonts:
 - Noto Emoji monochrome as the emoji font
 - Updated releases of Noto Sans, Noto Serif, Noto CJK, Noto Color Emoji
 - Noto Serif CJK, Noto Sans CJK changed to variable megafont (Super OTC) with
   different weights, replacing Noto Sans CJK Regular

Bugs:
 - I cannot figure out a functional way to fallback to Noto Color Emoji when
   Noto Emoji lacks a glyph

fonts.xml is based on the default provided by LineageOS 18.1 for this device,
with the following differences:

 - Use Noto Sans CJK, Noto Serif CJK variable font with 7 different weights
   configured
 - Prefer monochrome emoji to colour

## Build
 - Run `update.sh` to get latest version of fonts
 - Get manually downloaded fonts (see below) and put them on `mirrorwitch-magisckal-fonts/fonts`
 - Run `make-zip.sh` (or cd into `mirrorwitch-magisckal-fonts` and zip
   everything)
 - Zip file can be installed via Magisk

## Installation via command-line / ADB

```bash
adb push mirrorwitchs-magiskal-fonts.zip /sdcard/
adb root
adb shell magisk --install-module /sdcard/mirrorwitchs-magiskal-fonts.zip
adb shell rm /sdcard/mirrorwitchs-magiskal-fonts.zip
adb reboot
```

## Manually downloaded fonts

 - https://fonts.google.com/noto/specimen/Noto+Emoji
