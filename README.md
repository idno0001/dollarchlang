dollarchlang
============

Simple AutoHotKey script to switch keyboard layout when the $ key is pressed. This is particularly useful when writing (La)TeX in right-to-left languages, but when (for example) English is needed in a math environment. Currently, this script has been designed to work with TeXstudio and switches between Persian and British English.

Usage
-----
1.  Install [AutoHotKey] [1].
2.  Run the dollarchlang.ahk script.
3.  Modify as necessary (see below).

Adding support for other programs
---------------------------------
This script has been tested with TeXstudio and it will probably also work with TeXmaker without any modifications (this needs to be tested).

To make this script work with another program, say, _ProgramX_, one will need to identify the `ahk_class` of _ProgramX_. AutoHotKey comes with a program called _AutoIt3 Window Spy_ which will identify the `ahk_class` when _ProgramX_ is focussed. In `dollarchlang.ahk`, find the line

    #If WinActive("ahk_class QWidget")

and append `|| WinActive("ahk_class <new_ahk_class>")`. It should now read

    #If WinActive("ahk_class QWidget") || WinActive("ahk_class <new_ahk_class>")

To add support for more programs, just repeat this process.

If you do not want to use TeXstudio, one may append `|| WinActive("ahk_class Notepad")` to use Notepad for testing purposes.

Do not forget to reload the script. (Find the AutoHotKey icon in the system tray, right-click and choose `Reload This Script`.)

Changing keyboard layouts
-------------------------
There are two variables that you can change: `NON_ROMAN_KEYBOARD` and `ROMAN_KEYBOARD` which should contain the keyboard layout codes. By default, these are the codes for Persian and British English, respectively.

To find your own keyboard layout codes, simply open TeXstudio (or any program you added in the above section) and type a `$`. If a dollar symbol is not printed, you will see something like `0x4090409` instead. This is the keyboard code for your _current_ keyboard layout, so change the relevant variable as appropriate. Repeat as necessary for your other keyboard layout.

Again, do not forget to reload the script (see the bottom of the previous section).

Once the correct keyboard layouts have been set, upon typing `$`, the keyboard layout code should no longer be printed.

_Note:_ `0x4090409` is the keyboard layout for US English.

Known issues and drawbacks
--------------------------
* This script is _just_ a script. It is not smart enough to detect whether one is in math mode (when writing something in (La)TeX) or not. If one wishes to write something entirely in English, French or any other language that works well in math mode, simply disable the script by exiting or pausing it.
* It currently only supports two keyboard layouts. If one has more than two keyboard layouts, the script will not work properly. (This is an easy fix and will be fixed shortly.)
* Using double dollars (`$$`) for math environments will not work. Having said that, one should _not_ use `$$ ... $$` anyway; use \[ ... \] instead. See [this question] [2] on TeX.sx.
* Windows-only for now :(

[1]: http://autohotkey.com   "AutoHotKey"
[2]: http://tex.stackexchange.com/questions/503/   "TeX.sx"
