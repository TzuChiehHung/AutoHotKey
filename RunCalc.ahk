#c::
SC121::
IfWinExist ahk_class CalcFrame
	WinActivate
else
	Run Calc
return