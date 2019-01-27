; Get Monitor and Window Dimensions

SysGet, MonitorCount, MonitorCount

Loop, %MonitorCount%
{
	SysGet, Monitor%A_Index%, MonitorWorkArea, %A_Index%
}

ModArray:= Object()

Type:= 3

ModArray[1]:= 1
ModArray[2]:= 2
ModArray[3]:= 0

;------------------------------------------
;Get Monitor

GetMonitor(MonitorCount, ByRef MonitorLeft, ByRef MonitorTop, ByRef MonitorWidth, ByRef MonitorHeight, ByRef WinX, ByRef WinY, ByRef WinW, ByRef WinH)
{
	 CurrentMonitor:= 0

	WinGetPos, WinX, WinY, WinW, WinH, A

	WinCenterX:= WinX + WinW/2
	WinCenterY:= WinY + WinH/2

	Loop, %MonitorCount%
	{
		if (    (WinCenterX >= Monitor%A_Index%Left) and (WinCenterX <= Monitor%A_Index%Right )
		    and (WinCenterY >= Monitor%A_Index%Top ) and (WinCentreY <= Monitor%A_Index%Bottom))
		{
			CurrentMonitor = %A_Index%

			MonitorLeft   := Monitor%CurrentMonitor%Left
			MonitorTop    := Monitor%CurrentMonitor%Top
			MonitorWidth  := Monitor%CurrentMonitor%Right  - Monitor%CurrentMonitor%Left
			MonitorHeight := Monitor%CurrentMonitor%Bottom - Monitor%CurrentMonitor%Top
	
			break
		}
	}

	if (CurrentMonitor = 0)
	{
		MouseGetPos, MouseX, MouseY
		
			Loop, %MonitorCount%
		{
			if (    (MouseX >= Monitor%A_Index%Left) and (MouseX <= Monitor%A_Index%Right )
				and (MouseY >= Monitor%A_Index%Top ) and (MouseY <= Monitor%A_Index%Bottom))
			{
				CurrentMonitor = %A_Index%

				MonitorLeft   := Monitor%CurrentMonitor%Left
				MonitorTop    := Monitor%CurrentMonitor%Top
				MonitorWidth  := Monitor%CurrentMonitor%Right  - Monitor%CurrentMonitor%Left
				MonitorHeight := Monitor%CurrentMonitor%Bottom - Monitor%CurrentMonitor%Top
	
				break
			}
		}
	}

return
}

;------------------------------------------
; Scan State

ScanState(HK, WinX, WinY, WinW, WinH)
{
	
	if (WinX = X%HK%1 and WinY = Y%HK%1 and WinW = W%HK%1 and WinH = H%HK%1)
	{
		HotkeyCount:= 1
	}
	else if (WinX = X%HK%2 and WinY = Y%HK%2 and WinW = W%HK%2 and WinH = H%HK%2)
	{
		HotkeyCount:= 2
	}
	else
	{
		HotkeyCount:= 0
	}
	return HotkeyCount
}


;------------------------------------------
; Move Window

MoveWindow(MonitorCount, NumKey, Type, ModArray)
{
	GetMonitor(MonitorCount, MonitorLeft, MonitorTop, MonitorWidth, MonitorHeight, WinX, WinY, WinW, WinH)

	GridSetup(MonitorLeft,MonitorTop,MonitorWidth,MonitorHeight)

	HotkeyCount:= ScanState(NumKey, WinX, WinY, WinW, WinH)
	HotKeyCount:= HotKeyCount+1

	Loop, %Type%
	{
		if Mod(HotKeyCount,Type) = ModArray[A_index]
		{
			X:= X%NumKey%%A_index%
			Y:= Y%NumKey%%A_index%
			W:= W%NumKey%%A_index%
			H:= H%NumKey%%A_index%
		}
	}

	WinMove, A, , %X%, %Y%, %W%, %H%
}

;------------------------------------------
; Grid Setup

GridSetup(MonitorLeft,MonitorTop,MonitorWidth,MonitorHeight)
{
	global
	; BottomLeft(1)
	X11:= MonitorLeft
	Y11:= MonitorTop + Round(MonitorHeight/2)
	W11:= Round(MonitorWidth/2)
	H11:= Round(MonitorHeight/2)

	X12:= MonitorLeft
	Y12:= MonitorTop + Round(MonitorHeight/2)
	W12:= Round(MonitorWidth/3)
	H12:= Round(MonitorHeight/2)

	X13:= MonitorLeft
	Y13:= MonitorTop + Round(MonitorHeight/2)
	W13:= Round(MonitorWidth*2/3)
	H13:= Round(MonitorHeight/2)

	; Bottom(2)
	X21:= MonitorLeft
	Y21:= MonitorTop + Round(MonitorHeight/2)
	W21:= MonitorWidth
	H21:= Round(MonitorHeight/2)

	X22:= MonitorLeft + Round(MonitorWidth/4)
	Y22:= MonitorTop + Round(MonitorHeight/2)
	W22:= Round(MonitorWidth/2)
	H22:= Round(MonitorHeight/2)

	X23:= MonitorLeft + Round(MonitorWidth/3)
	Y23:= MonitorTop + Round(MonitorHeight/2)
	W23:= Round(MonitorWidth/3)
	H23:= Round(MonitorHeight/2)

	; BottomRight(3)
	X31:= MonitorLeft + Round(MonitorWidth/2)
	Y31:= MonitorTop + Round(MonitorHeight/2)
	W31:= Round(MonitorWidth/2)
	H31:= Round(MonitorHeight/2)

	X32:= MonitorLeft + Round(MonitorWidth*2/3)
	Y32:= MonitorTop + Round(MonitorHeight/2)
	W32:= Round(MonitorWidth/3)
	H32:= Round(MonitorHeight/2)

	X33:= MonitorLeft + Round(MonitorWidth/3)
	Y33:= MonitorTop + Round(MonitorHeight/2)
	W33:= Round(MonitorWidth*2/3)
	H33:= Round(MonitorHeight/2)

	; MiddleLeft(4)
	X41:= MonitorLeft
	Y41:= MonitorTop
	W41:= Round(MonitorWidth/2)
	H41:= MonitorHeight

	X42:= MonitorLeft
	Y42:= MonitorTop
	W42:= Round(MonitorWidth/3)
	H42:= MonitorHeight

	X43:= MonitorLeft
	Y43:= MonitorTop
	W43:= Round(MonitorWidth*2/3)
	H43:= MonitorHeight

	; Middle(5)
	X51:= MonitorLeft + Round(MonitorWidth/4)
	Y51:= MonitorTop
	W51:= Round(MonitorWidth/2)
	H51:= MonitorHeight

	X52:= MonitorLeft + Round(MonitorWidth/3)
	Y52:= MonitorTop
	W52:= Round(MonitorWidth/3)
	H52:= MonitorHeight

	X53:= MonitorLeft + Round(MonitorWidth/6)
	Y53:= MonitorTop
	W53:= Round(MonitorWidth*2/3)
	H53:= MonitorHeight

	; MiddleRight(6)
	X61:= MonitorLeft + Round(MonitorWidth/2)
	Y61:= MonitorTop
	W61:= Round(MonitorWidth/2)
	H61:= MonitorHeight

	X62:= MonitorLeft + Round(MonitorWidth*2/3)
	Y62:= MonitorTop
	W62:= Round(MonitorWidth/3)
	H62:= MonitorHeight

	X63:= MonitorLeft + Round(MonitorWidth/3)
	Y63:= MonitorTop
	W63:= Round(MonitorWidth*2/3)
	H63:= MonitorHeight

	; TopLeft(7)
	X71:= MonitorLeft
	Y71:= MonitorTop
	W71:= Round(MonitorWidth/2)
	H71:= Round(MonitorHeight/2)

	X72:= MonitorLeft
	Y72:= MonitorTop
	W72:= Round(MonitorWidth/3)
	H72:= Round(MonitorHeight/2)

	X73:= MonitorLeft
	Y73:= MonitorTop
	W73:= Round(MonitorWidth*2/3)
	H73:= Round(MonitorHeight/2)

	; Top(8)
	X81:= MonitorLeft
	Y81:= MonitorTop
	W81:= MonitorWidth
	H81:= Round(MonitorHeight/2)

	X82:= MonitorLeft + Round(MonitorWidth/4)
	Y82:= MonitorTop
	W82:= Round(MonitorWidth/2)
	H82:= Round(MonitorHeight/2)

	X83:= MonitorLeft + Round(MonitorWidth/3)
	Y83:= MonitorTop
	W83:= Round(MonitorWidth/3)
	H83:= Round(MonitorHeight/2)

	; TopRight(9)
	X91:= MonitorLeft + Round(MonitorWidth/2)
	Y91:= MonitorTop
	W91:= Round(MonitorWidth/2)
	H91:= Round(MonitorHeight/2)

	X92:= MonitorLeft + Round(MonitorWidth*2/3)
	Y92:= MonitorTop
	W92:= Round(MonitorWidth/3)
	H92:= Round(MonitorHeight/2)

	X93:= MonitorLeft + Round(MonitorWidth/3)
	Y93:= MonitorTop
	W93:= Round(MonitorWidth*2/3)
	H93:= Round(MonitorHeight/2)
}
;------------------------------------------

#Numpad1::
NumKey:= 1
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad2::
NumKey:= 2
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad3::
NumKey:= 3
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad4::
NumKey:= 4
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad5::
NumKey:= 5
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad6::
NumKey:= 6 
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad7::
NumKey:= 7
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return


#Numpad8::
NumKey:= 8
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return

#Numpad9::
NumKey:= 9
MoveWindow(MonitorCount, NumKey, Type, ModArray)
return

