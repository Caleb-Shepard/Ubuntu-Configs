;; Caleb Shepard's ergonomic ahk profile, for vim users

#MaxHotkeysPerInterval 200

^F5::reload
+F5::edit
CapsLock::Ctrl
LAlt::Esc
LCtrl::LAlt

;; Situational bindings
;; LWin::Esc
RAlt::LWin

;; Natural Scrolling
WheelUp::WheelDown
WheelDown::WheelUp

#!v:: ;change keydelay
;; this didn't come with comments, have zero idea what anything does :D
VarSetCapacity(FILTERKEYS, 2)
NumPut(24, FILTERKEYS, 0, "UInt") ;cbSize
NumPut(1, FILTERKEYS, 4, "UInt") ;dwFlag
NumPut(250, FILTERKEYS, 12, "UInt") ;iDelayMSec
NumPut(10, FILTERKEYS, 16, "UInt") ;RepeatMSec
DllCall("SystemParametersInfo", "UInt", 0x0033, "UInt", 0, "Ptr", &FILTERKEYS, "Uint", 0)
return