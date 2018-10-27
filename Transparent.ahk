#wheelup::
WinGet, tran, Transparent, a
if tran not between 0 and 255
	{
	tran = 255
	}
tran := tran+16
if tran >= 255
        {
        tran = off
        }
WinSet, Transparent, %tran%, a  
return

#WheelDown::    
WinGet, tran, Transparent, a
if tran not between 0 and 255
	{
	tran = 255
	}
tran := tran-16
if tran <= 0
        {
        tran = 0
        }
WinSet, Transparent, %tran%, a  
return