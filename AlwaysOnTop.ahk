;toggle alwaysontop & transparency
;#F1::SetTransparency(64)
;#F2::SetTransparency(128)
;#F3::SetTransparency(192)
;#`::WinSet, AlwaysOnTop, toggle, A

#`::
 	WinGetTitle, Title, A
        if title not contains [�m��]
        {
        WinSet, AlwaysOnTop, On, A
        WinSetTitle, %Title%, , %Title% [�m��]
        }
        else
        {
        WinSet, AlwaysOnTop, Off, A
        WinGetTitle, Title, A
        StringReplace, NewTitle, Title, [�m��], , All
        WinSetTitle, %Title%, , %NewTitle%
        }
return

;SetTransparency(trans){
;        WinGet, Transparency, Transparent, A
;        If Transparency
;                WinSet, Transparent, Off, A
;        else
;                WinSet, Transparent, %trans%, A
;;        WinSet, AlwaysOnTop, toggle, A
;        return
;	}