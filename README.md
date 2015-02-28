# dollarchlang

Simple AutoHotKey script to switch keyboard layout when the `$` key is pressed. This is particularly useful when writing (La)TeX in right-to-left languages, but when (for example) English is needed in a math environment. Currently, this script has been designed to work with TeXstudio and switches between Persian and British English.

## Usage
1.  Install [AutoHotKey] [1].
3.  Modify the `dollarchlang.ahk` script as necessary.
2.  Run the `dollarchlang.ahk` script.

## Modifying the script
Unless you are using British English and Persian keyboard layouts with TeXstudio only, you will need to make changes to the script:

1. Open `dollarchlang.ahk` in a text editor.<sup>1</sup>
2. Make your changes (see below).
3. Reload the script: find the AutoHotKey icon in the system tray, right-click and choose `Reload This Script`.

### Adding support for other programs
This script has been tested with TeXstudio and it will probably also work with TeXmaker without any modifications (untested).

To make this script work with another program, say, _ProgramX_, you will need to identify the `ahk_class` of _ProgramX_. AutoHotKey comes with a program called _AutoIt3 Window Spy_ which will identify the `ahk_class` when _ProgramX_ is focussed. In `dollarchlang.ahk`, find the line

    #If WinActive("ahk_class QWidget") || WinActive("ahk_class Qt5QWindowIcon")

and append `|| WinActive("ahk_class <new_ahk_class>")`. It should now read

    #If WinActive("ahk_class QWidget") || WinActive("ahk_class Qt5QWindowIcon") || WinActive("ahk_class <new_ahk_class>")

To add support for more programs, just repeat this process.

If you do not want to use TeXstudio, you may append `|| WinActive("ahk_class Notepad")` to use Notepad for testing purposes.

### Changing keyboard layouts
For general usage, there are two variables that you can change: `NON_ROMAN_KEYBOARD` and `ROMAN_KEYBOARD` which should contain the keyboard layout codes. To change these codes, update the following lines in `dollarchlang.ahk` with your keyboard layout code (see below):

    NON_ROMAN_KEYBOARD = 0429
    ROMAN_KEYBOARD = 0809

By default, these are the codes for Persian and British English, respectively. Some common codes are:

    Persian:          0429
    Arabic:           2401
    American English: 0409
    British English:  0809

#### Finding your keyboard layout codes
To find your own keyboard layout codes:

1. Change the line that says `DEBUG_MODE := false` to `DEBUG_MODE := true`. This turns on `DEBUG_MODE`.
2. Reload the script.
3. In TeXstudio (or any program you added in the above section), type a `$`. This will print a number, e.g. `0409`. This is the keyboard code for your _current_ keyboard layout, so change the relevant variable as appropriate.

Remember to reverse step 1 to disable `DEBUG_MODE`.

## More than two keyboard layouts
If you have more than two keyboard layouts, typing a `$` will cycle between the two selected layouts `NON_ROMAN_KEYBOARD` and `ROMAN_KEYBOARD`.

## Known issues and drawbacks
* This script is _just_ a script. It is not smart enough to detect whether you are in math mode (when writing something in (La)TeX) or not. If you wishes to write something entirely in English, French or any other language that works well in math mode, simply disable the script by exiting or pausing it.
* Using double dollars (`$$`) for math environments will not work. Having said that, one should _not_ use `$$ ... $$` anyway; use `\[ ... \]` instead. See [this question] [2] on TeX.sx.
* `\[ ... \]` is not supported, nor are the other math environments. This is difficult to overcome because the character `\` is not recognised in the Persian keyboard layout.
* Windows-only for now :(

<sup>1</sup> [Notepad++] [3] is a decent text editor on Windows.

[1]: http://autohotkey.com   "AutoHotKey"
[2]: http://tex.stackexchange.com/questions/503/   "TeX.sx"
[3]: http://notepad-plus-plus.org/download/v6.7.4.html   "Notepad++"
