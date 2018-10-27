;move active window
#Left::MoveWindow(-5, 0)
#Right::MoveWindow(5, 0)
#Up::MoveWindow(0, -5)
#Down::MoveWindow(0, 5)
MoveWindow(dx, dy){
        WinGetPos, WinPosX, WinPosY, , , A
        WinMove, A, , WinPosX+dx, WinPosY+dy
        return
}