; dollarchlang.ahk
; This AutoHotKeyScript changes the behaviour of the $ key for TeXstudio for
; the Persian keyboard layout.

; It is a very simple script that relies on the assumption that the user
; *only* has a single Persian keyboard layout and a single British English
; keyboard layout installed.

; To detect the keyboard layout, this script uses code from
; http://www.autohotkey.com/board/topic/43043-get-current-keyboard-layout/ 

; Only the last 4 digits of your keyboard layout code are required. For
; example, some Persian keyboard layouts are:
; Persian (`Persian'):                  0x4290429
; Persian (`Standard'):                 0xF03A0429
; Persian (`Iranian Standard Persian'): 0xF0C10429
; where the respective keyboard codes begin with 0x. We only need the 0429
; part of the keyboard code.  
; 
; The  default layouts are Persian and British English. Change these to suit
; your needs. Some useful keyboard codes:
; Persian:          0429
; Arabic:           2401
; American English: 0409
; British English:  0809
NON_ROMAN_KEYBOARD = 0429
ROMAN_KEYBOARD = 0809

; Set DEBUG_MODE := true to make $ print out the current keyboard layout code.
DEBUG_MODE := false

; Get current keyboard layout ID.
get_keyboard_layout()
{
  SetFormat, Integer, H
  WinGet, WinID,, A
  threadID := DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
  inputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
  StringRight, inputLocaleID, InputLocaleID, 4
  Return inputLocaleID
}

; Active for QWidget or Qy5QWindowIcon windows, which is what TeXstudio is
; identified (old or new). To add support for other programs, use Window Spy
; that comes with AutoHotKey to identify the ahk_class, and add
; || WinActive("ahk_class <new_ahk_class>")
; to the following #If statement.
#If WinActive("ahk_class QWidget") || WinActive("ahk_class Qt5QWindowIcon")
$$::
{
  layout := get_keyboard_layout()
  if !DEBUG_MODE
  {
    ; Currently in the LTR layout - insert a dollar and change keyboard layout.
    if layout = %ROMAN_KEYBOARD%
    {
      Send ${Alt Down}{Shift Down}{Shift Up}{Alt Up}
    }
    ; Currently in the RTL layout. Change layout and print a dollar.
    else if layout = %NON_ROMAN_KEYBOARD%
    {
      Send {Alt Down}{Shift Down}{Shift Up}{Alt Up}
      Send {$}
    }
    ; Ignore other keyboard layouts.
    newLayout := get_keyboard_layout()
    while (newLayout != NON_ROMAN_KEYBOARD && newLayout != ROMAN_KEYBOARD)
    {
      Send {Alt Down}{Shift Down}{Shift Up}{Alt Up}
      newLayout := get_keyboard_layout()
    }
  }
  else ; if DEBUG_MODE
  {
    layout := get_keyboard_layout()
    Send %layout%
  }
  Return
}

