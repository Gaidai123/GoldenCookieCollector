; Settings to work fast and search through active window's client area.
CoordMode, Pixel, Client
CoordMode, Mouse, Client
SetMouseDelay, 5
SetDefaultMouseSpeed, 0
SetBatchLines -1

; Greetings and basic information.
hello:
MsgBox, 4, ,Добро пожаловать в собиратель печенек.`n`nСкрипт запомнит позиуцию вашей мыши после нажатия и начнёт кликать через 5 секунд.`n`nОткройте игру, нажмите "Yes" в этом окне, и нажмите на большую печеньку.`n`nВы готовы?  `n`nMade by Gaidai
IfMsgBox yes
	goto, start
else IfMsgBox no
	ExitApp

; Delay between clicking "Yes" and starting to work.
start:
	{
		sleep, 3000
		global cookie_X
		global cookie_Y
		MouseGetPos, cookie_X, cookie_Y
		MsgBox, X %cookie_X% Y %cookie_Y%
		goto, cookie
	}

; Clicking main cookie.
cookie:
	Loop, 50
		{
			Click, %cookie_X% %cookie_Y%
		}

; Searching golden cookies.
golden:
	ImageSearch, golden_X, golden_Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *32 gimg.png
	if(golden_X <> "")
	{
		MouseMove, %golden_X%, %golden_Y%
		Click
		goto, golden
	}

garden: 
	ImageSearch, garden_X, garden_Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *30 garden.png
	if(garden_X <> "")
	{
		MouseMove, %garden_X%, %garden_Y%
		Click, 830, 310
		garden_X := garden_X + 16
		garden_Y := garden_Y + 16
		tmp := garden_X
		i:=0
		j:=0
		Send {Shift down}
		While(i<6)
			{
				While(j<6)
					{
						sleep, 250
						Click, %garden_X%, %garden_Y%
						garden_X := garden_X + 40
						j:=j+1
					}
				i:=i+1
				j:=0
				garden_X := tmp	
				garden_Y := garden_Y + 40
			}
		Send {Shift up}
		Click, 830, 310
		goto, garden
	}
	else
		goto, cookie

; Hotkeys.
^p::Pause
^e::ExitApp