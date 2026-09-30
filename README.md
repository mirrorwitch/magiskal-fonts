## mirrorwitch's magisckal fonts

Personal Magisk module to update fonts on my manga reading tablet.

This updates the fonts in my Galaxy Tab S3 running LineageOS 18.1 (Android 11).
**The fonts.xml file will not be safe to use in other devices or ROMs than this
combination.** This project is probably not useful for anyone else except maybe
as a basis you can modify to make your own.

Features:
 - Noto Emoji monochrome as the prefereed emoji font.
 - Noto Sans CJK, Noto Serif CJK changed for variable font with 7 different
   weights configured.
 - Updated releases of Noto Sans, Noto Serif, Noto CJK, Noto Color Emoji.
 - Supports CJK up to Unicode 13, emoji up to Unicode 18.
 - New style fonts available for theming: Bitter (slab serif), Shantell (comic)

Bugs:
 - I cannot figure out a functional way to fallback to Noto Color Emoji when
   Noto Emoji lacks a glyph


## Build
 - Run `update.sh` to get latest version of fonts
 - Get manually downloaded fonts (see below) and put them with the others on
   `mirrorwitch-magisckal-fonts/system/fonts`
 - Run `make-zip.sh` (or cd into `mirrorwitch-magisckal-fonts`
   and zip everything)
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
