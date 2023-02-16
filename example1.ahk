#SingleInstance, Force

Gui, +LastFound +Resize -Caption -Border -MaximizeBox +AlwaysOnTop
Gui, Color, FFFFFF
Gui, Add, Button, Default w80 gStart, Start
Gui, Add, Button, Default w80 gStop vStop, Stop
Gui, Add, Button, Default w80 gCChrome vChclose, Close Chrome
Gui, Add, Button, Default w80 gClose, Close
Gui, Show, xCenter w256 h128

GuiControl, Disable, Stop
GuiControl, Disable, Chclose

OnMessage(0x200,"Guimove")
Return

Start:
	Toggle := 1
	GuiControl, Disable, Button1
	GuiControl, Enable, Button2
	SetTimer, Progress, -1
Return

Stop:
	Toggle := 0
	GuiControl, Disable, Button2
	GuiControl, Enable, Button1
	SetTimer, Progress, -1
Return

CChrome:
	MsgBox Close Chrome
Return
Progress:
	While Toggle
	{
		MouseGetPos, , , id, control
		coordmode, Mouse, relative
		MouseGetPos, xpos, ypos
		coordmode, Mouse, screen
		MouseGetPos, xxpos, yypos
		ToolTip, ahk_id %id% `nControl: %control%`nX Y relative: %xpos% %ypos%`nX Y Screen: %xxpos% %yypos%
	}
	ToolTip
Return

Close:
GuiEscape:
ExitApp

Guimove(){
	PostMessage, 0xA1, 2,,, A
	WinGetPos, _X, _Y 
	IniWrite, %_X%, % inifile, app, XPos
	IniWrite, %_Y%, % inifile, app, YPos
}
