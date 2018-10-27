#n::
IfWinExist ahk_class Notepad
	WinActivate
else
	Run Notepad
return