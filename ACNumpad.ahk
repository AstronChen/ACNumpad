;--------------------------------Ahk2Exe Script Compiler Directives---------------------------------
;@Ahk2Exe-AddResource icon/logo.ico
;@Ahk2Exe-AddResource icon/off.ico
;@Ahk2Exe-AddResource icon/on.ico
;@Ahk2Exe-SetMainIcon icon/logo.ico
;@Ahk2Exe-ExeName ACNumpad
;@Ahk2Exe-SetInternalName ACNumpad
;@Ahk2Exe-SetName ACNumpad
;@Ahk2Exe-SetOrigFilename ACNumpad.exe
;@Ahk2Exe-SetProductName ACNumpad
;@Ahk2Exe-SetProductVersion 1.1
;@Ahk2Exe-SetFileVersion 1.1
;@Ahk2Exe-SetCompanyName Astron Chen
;@Ahk2Exe-SetDescription ACNumpad
;@Ahk2Exe-SetCopyright Astron Chen
;---------------------------------------------------------------------------------------------------




;============================================Program===============================================
#SingleInstance ; Allow only one instance of this script to be running.
Persistent
#Include ACNumpad.ahk


;Set initial state.
SetNumLockState 1 ;
Suspend 1
TraySetIcon("ACNumpad.exe", 7, 1)


;--------------------------------------------------------------------------------------------------
;Toggle suspend. Never be suspended.
#SuspendExempt

;Toggle ACNumpad suspend with 'RAlt + Comma' or click on tray icon.
>!,::
    {
        ToggleSuspend()
    }

    ;Function: Toggle suspend.
    ToggleSuspend(*)
    {
        Suspend -1
        TrayFeedback()
    }

    ;Function: Show tray feedback.
    TrayFeedback()
    {
        If (A_IsSuspended = 1)
        {
            TraySetIcon("ACNumpad.exe", 7, 1) ;When ACNumpad is suspended, use off.ico.
            TrayTip "OFF", "ACNumpad", "Iconi Mute" ;ACNumpad suspended notification.
            DelayHideTrayTip()
        }
        Else
        {
            TraySetIcon("ACNumpad.exe", 8, 1) ;When ACNumpad is activated, use on.ico.
            TrayTip "ON", "ACNumpad", "Iconi Mute" ;ACNumpad activated notification.
            DelayHideTrayTip()
        }
    }

    ;Function: Hide traytip after 1000ms.
    DelayHideTrayTip()
    {
        Sleep 1000
        HideTrayTip()
    }

    ;Function: HideTrayTip.
    HideTrayTip()
    {
        TrayTip ;Try hide traytip.
        if SubStr(A_OSVersion,1,3) = "10." ;Hide tray tip correcttly under Win10\11.
        {
            A_IconHidden := 1
            A_IconHidden := 0
        }
    }

;--------------------------------------------------------------------------------------------------
;Customize tray menu.
A_TrayMenu.Delete ;Delete AutoHotkey default tray menu.
A_TrayMenu.Add "&Toggle Suspend", ToggleSuspend ;Add"Toggle Suspend"
A_TrayMenu.Add "&About", About ;Add"About"
A_TrayMenu.Add "&Quit", Quit ;Add"Toggle Suspend"

    About(*)
    {
        AboutBox := Gui(, "About")
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "Name`: ACNumpad")
        AboutBox.Add("Text",, "Author`: Astron Chen")
        AboutBox.Add("Link",, 'Website: <a href="https://github.com/Astron853/ACNumpad/releases">Release Page</a>')
        AboutBox.Add("Text",, "Version`: 1.1")
        AboutBox.Add("Text",, "Release Date: 2022-5-9")
        AboutBox.Add("Link",, 'Base on <a href="www.autohotkey.com">Autohotkey</a> v2 beta3')
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "The tool will run as suspended. Your keyboard will act as it be.")
        AboutBox.Add("Text",, "Use 'Right Alt + ,' to toggle ACNumpad suspend.")
        AboutBox.Add("Text",, "When you toggle ACNumpad on, key J and arounded keys will act as numpad.")
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "7 = Num7`t8 = Num8`t9 = Num9`t0 = Num+")
        AboutBox.Add("Text",, "  u = Num4`t  i = Num5`t  o = Num6`t  p = Num-")
        AboutBox.Add("Text",, "    j = Num1`t    k = Num2`t    l = Num3`t`    `; = Num*")
        AboutBox.Add("Text",, "      m = Num0`t      `t      `t      . = Num.`t      \ = Num\")
        AboutBox.Add("Text",, "")
        AboutBox.Add("Text",, "")

        AboutBox.Show("NoActivate") ;Keep the window.
    }

    Quit(*)
    {
        ExitApp
        Persistent
    }

;--------------------------------------------------------------------------------------------------
;Keys remapping. Can be suspended.
#SuspendExempt 0

j::Numpad1
k::Numpad2
l::Numpad3
u::Numpad4
i::Numpad5
o::Numpad6
7::Numpad7
8::Numpad8
9::Numpad9
m::Numpad0
.::NumpadDot
0::NumpadAdd
p::NumpadSub
`;::NumpadMult
\::NumpadDiv
Enter::NumpadEnter