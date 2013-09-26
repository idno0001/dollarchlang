; dollarchlang.ahk
; This AutoHotKeyScript changes the behaviour of the $ key for TeXstudio for
; the Persian keyboard layout.

; It is a very simple script that relies on the assumption that the user
; *only* has a single Persian keyboard layout and a single British English
; keyboard layout installed.

; To detect the keyboard layout, this script uses code from
; http://www.autohotkey.com/board/topic/43043-get-current-keyboard-layout/ 

; Keyboard layouts - defaults are Persian (Standard) and British English.
; Change these to suit your needs. Some useful keyboard codes:
; Persian (`Persian'): 0x4290429
; American English:    0x4090409
NON_ROMAN_KEYBOARD = 0xF03A0429
ROMAN_KEYBOARD = 0x8090809

; Active for QWidget windows, which is what TeXstudio is identified as.
; To add support for other programs, use Window Spy that comes with
; AutoHotKey to identify the ahk_class, and change the next line to
; #If WinActive("ahk_class QWidget") || WinActive("ahk_class <new_ahk_class>")
#If WinActive("ahk_class QWidget")
$$::
{
  ; Get current keyboard layout ID.
  SetFormat, Integer, H
  WinGet, WinID,, A
  ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
  InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
  
  ; Currently in Persian - change keyboard layout and print a dollar.
  if InputLocaleID = %NON_ROMAN_KEYBOARD%
    Send {Alt Down}{Shift Down}{Shift Up}{Alt Up}$
  ; Currently in British English - insert a dollar and change keyboard layout.
  else if InputLocaleID = %ROMAN_KEYBOARD%
    Send ${Alt Down}{Shift Down}{Shift Up}{Alt Up}
  ; (Debugging purposes only) Neither keyboard layout - print the current 
  ; keyboard layout to help the user modify the script to suit his/her needs.
  else
    Send %InputLocaleID%
  Return
}

