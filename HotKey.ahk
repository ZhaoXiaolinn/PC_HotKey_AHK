#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

;Change the script's thread run priority
Process Priority, , High
SetKeyDelay -1
Tuan_Spec:

GroupAdd, VIMG, ahk_class Vim
iniPath = Settings.ini
;;;;;;;;;;;;;;;;;;;;;;;;;Read APP Path	;;;;;;;;;;;;;;;;;;;;;;;;;
vim_path = D:\Think\AppSys\Vim\vim74\gvim.exe
vim_extList = "ahk py txt md "


RegRead QQ_Path, HKLM, SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{052CFB79-9D62-42E3-8A15-DE66C2C97C3E}, InstallLocation
if ERRORLEVEL
{
	QQ_Path = ""
}
else QQ_Path = %QQ_Path%QQProtect\Bin\QQProtect.exe

RegRead Vim_Path,HKEY_LOCAL_MACHINE,SOFTWARE\Classes\Wow6432Node\TypeLib\{AC726707-2977-11D1-B2F3-006008040780}\1.0\HELPDIR
if ERRORLEVEL
{
	Vim_Path = ""
}
else Vim_Path = %Vim_Path%gvim.exe

;;; Can't read
;;;RegRead ,HKLM, SOFTWARE\Vim\GVim, path
;;;;;;;;;;;;;;;;;;;;;;;;;Read End	;;;;;;;;;;;;;;;;;;;;;;;;;


/*
$F10::
	SetTitleMatchMode 2
	IfWinExist ahk_class SciTEWindow
	{
		ControlSend, ahk_parent,f10; 暂停/开始
	}
	return
*/

::/ishare::ishare.iask.sina.com.cn{enter}

#f::run "E:\ASYNC\TOOL\Everything.exe"
::/btw::By the way

;;;;;;;;;;快速打开程序(快捷键);;;;;;;;;;;;;;;;;;;;;;;;; 

;用google搜索 
!g:: 
Send ^c 
Run http://www.google.com/search?q=%clipboard% 
return 
;用百度搜索 
!b:: 
Send ^c 
Run http://www.baidu.com/s?wd=%clipboard% 
return 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;通用键的映射;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;对windows下的一些常用键进行映射,与苹果下的一些习惯一样(苹果下的快捷键有些非常合理:) 
;!f::Send ^f ;查找 
;!q:: !F4 ;退出 
;!w::Send ^w ;关闭网页窗口 
;!s::Send ^s ;保存 
;!n::Send ^n ;新建 
;!z::Send ^z 
;选择文字 
!,::Send ^+{Left} 
!.::Send ^+{Right} 

return 

!y:: Send +{Home} ;选择当前位置到行首的文字 
!p:: Send +{End} ;选择当前位置到行末的文字 

;选择一行 
!a:: 
	Send {Home} 
	Send +{End} 
	return 

;鼠标的左右键实现任务切换,对thinkpad trackpoint 特别有用 
~LButton & RButton::AltTab 
~RButton & LButton::ShiftAltTab

;!A::WinHide ahk_class Shell_TrayWnd
;!Q::WinShow ahk_class Shell_TrayWnd

!T::
WinGet, active_id, ID, A
WinGetClass, class, A
WinSet AlwaysOnTop, Toggle,ahk_id %active_id%
if %ERRORLEVEL%
	Run Winctl.exe Top %active_id%,,Hide
return

^T::
WinGet, active_id, ID, A
Run Winctl.exe Top %active_id%,,Hide
return


!H::
WinGet, active_id, ID, A
Run Winctl.exe Hide %active_id%,,Hide
return

!U::
Run WinCtl.exe UnHide,,Hide
return

/*
!V::
;WinGet, active_id, ID, A
;GroupAdd, VIMG, ahk_ID  active_id
IfWinNotExist ahk_class Vim
{
	if not Vim_Path		
	{
		IniRead Vim_Path,%IniPath%,Settings,Vim_Path
		if(Vim_Path = "ERROR")
		{
			Msgbox "Your configuration Tuan.ini Read fail.Please check the existence of the ini file"
			return
		}
	}		
	run %Vim_Path%
}

GroupActivate VIMG,R


return
*/
!v::
; null= 
;多谢 helfee 的提醒，删除线部分是多余的。
send ^c
sleep,100
;clipboard=%clipboard% ;%null%
filePath = %clipboard%
clipboard = 
if not FileExist(filePath)
	return
SplitPath, filePath, name,,ext
if not InStr(name,".")
	return
if not InStr(vim_extList,ext)
	return
run %vim_path% %filePath%
; 这句还是废话一下：windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了。
return

!X::
WinGet, active_id, ID, A
WinKill AHK_ID %active_id%
return

^!U::
Send {AltDown}R{AltUp}
Msgbox "A"
;Run WinCtl.exe UnHide,,Hide
return


AppsKey_State := 0
AppsKey_Shift_State := 0
RAlt::
if AppsKey_State
{
	send {esc}
	AppsKey_State := 0
	AppsKey_Shift_State := 0
}
else
{
	send {AppsKey}
	AppsKey_State := 1
}
return 

+RAlt:: 
if AppsKey_Shift_State
{
	send {esc}
}
else
{
	send {ShiftDown}{AppsKey}{ShiftUp}
	AppsKey_Shift_State := 1
	AppsKey_State := 1
}
return 

LAlt & Tab:: AltTab	
;+LAlt & Tab:: ShiftAltTab







/************Esc DoubleClick****************
*/
/*
;copy cut paste 的快捷键 
!c::Send ^c 
!x::Send ^x 
!v::Send ^v 

;上页翻页键映射 
!h::Send {PgUp} 
!;::Send {PgDn} 
;HOME END键映射 
!u:: Send {Home} ; 
!o:: Send {End} ; 
;Alt + jkli 实现对方向键的映射,写代码的时候灰常有用 
!j:: Send {left} 
!l:: Send {right} 
!i:: Send {up} 
!k:: Send {down} 

;Delete Backspace的映射 
;!f::Send {Backspace} 
!d::Send {Delete} 
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;通用键的映射;(结束);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;实用功能;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;win键 + PrintScreen键关闭屏幕 
Screen_State := 1
#PrintScreen:: 
	
	if Screen_State 
	{
		KeyWait PrintScreen 
		KeyWait LWin ;释放左Win键才激活下面的命令
		SendMessage,0x112,0xF170,2,,Program Manager 
		Screen_State := 0
	}
	else
	{
		SendMessage,0x112,0xF170,-1,,Program Manager 
		Screen_State := 1
	}

	;关闭显示器。0x112:WM_SYSCOMMAND，0xF170:SC_MONITORPOWER。2：关闭，-1：开启显示器 
	Return 

 
;双击鼠标右键在窗口最大化与正常状态之间切换 
WinStatus:=0 
RButton:: 
	KeyWait, RButton ;松开鼠标右键后才继续执行下面的代码 
	keyWait, RButton, D T0.15 ;在 100 毫秒内等待再次按下鼠标右键，可以设置一个自己觉得适合的等待时间。 

	If ErrorLevel 
	Click, Right 
	Else 
	{ 
		if WinStatus=0 
		{ 
			WinMaximize , A 
			WinStatus:=1 
		} 
		else 
		{ 
			WinRestore ,A 
			WinStatus:=0 
		} 
	} 
	Return 
	
	!m:: 
	if WinStatus=0 
	{ 
		WinMaximize , A 
		WinStatus:=1 
	} 
	else 
	{ 
		WinRestore ,A 
		WinStatus:=0 
	} 
	return 

;命令行cmd里可以ctrl v 
#IfWinActive ahk_class ConsoleWindowClass 
^v:: 
MouseClick, Right, %A_CaretX%, %A_CaretY%,,0 
send p 
return 
#IfWinActive
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;实用功能(结束);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



;;;;;;;;;;;;;;;;;;;;;;;;App Function ReDefined by Tuan;;;;;;;;;;;;;;;;;;;;;;;;;

/*
*****************************************
MediaPlayer Control Module
Function:Send the control function without activating the Mediaplayer windows
*****************************************
*/
$Media_Play_Pause::
	SetTitleMatchMode 2
;	IfWinExist foobar2000
	IfWinExist ahk_class {97E27FAA-C0B3-4b8e-A693-ED7881E99FC1}
	{
		ControlSend, ahk_parent,c
		; 暂停/开始
	}
	Else IfWinExist AHK_class kwmusicmaindlg
	{
		ControlSend, ahk_parent,f5
		; 暂停/开始
	}
	Else
	{
		RegRead foobar_Path, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\foobar2000.exe
		if ErrorLevel
		{
			If Not FileExist(iniPath)
			{
				ini=%ini%[Settings]
		 		ini=%ini%`nfoobar_Path=D:\PApp\foobar2000\foobar2000.exe`n `; 设置快捷方式所在位置，一个“.”表示快捷方
				FileAppend, %ini%, Settings.ini
				ini=		
			}
			INIread foobar_Path,%IniPath%,Settings,foobar_Path
			if(foobar_Path = "ERROR")
			{
				Msgbox "Your configuration Tuan.ini Read fail.Please check the existence of the ini file"
				return
			}
		}
		
		Run %foobar_Path%,,,foobar_PID
		WinWaitActive AHK_pid %foobar_PID%
		;Last time the program is close unpropery
		IfWinExist foobar2000,Start foobar2000 normally
		{
			WinActivate
			ControlClick Start foobar2000 normally
			;Control Check,,Button2;
			if ErrorLevel 
			{
				MsgBox Restart the app Failed
			}
			Send {Space}
		;	ControlSend, ahk_parent,c
			; 暂停/开始
		}
		WinWaitActive foobar2000 v
		Send {Media_Play_Pause}
;		WinHide AHK_pid %foobar_PID%
	}
	Return
/*
*****************************************
QQ Shortcut
*****************************************
*/
/*
~$^!M::
IfWinExist ahk_class TXGuiFoundation
{
;	WinActivate
;	WinGetActiveStats, Title, Width, Height, X, Y
;	if X > 1024
;	{
;		WinMove 1024,15
;	}
;	MouseClick Right,60,270
}
else
{
	run %QQ_Path%
	WinWait QQ2013
	Send {Space}
	WinMove 1024,726
	WinActivate
}
Return
*/

/*
*******************************
Kill one QQ each time
*******************************

#IfWinExist AHK_class TXGuiFoundation
k & q::
	WinClose AHK_class TXGuiFoundation
	WinWaitClose 
	Return
$k::Send k
#IfWinExist
*/
/*
*****************************************
Esc DoulbeClick 
Function: Kill the Activated Windows
*****************************************

$Esc::
DelayBetweenKeys = 200 
; Adjust this value if it doesn't work.
if A_PriorHotkey = %A_ThisHotkey%
{
	if A_TimeSincePriorHotkey < %DelayBetweenKeys%
	{
		Send {AltDown}{F4}{AltUp}
		return
	}
}
else 	
	Send {Esc}
return

*******************************
Kill a program 
*******************************
*/
#IfWinActive AHK_Class Shell_TrayWnd
#IfWinExist AHK_class TXGuiFoundation
~q::
if GetKeyState("k")
{	
	WinClose AHK_class TXGuiFoundation
	WinWaitClose 
}
Return
#IfWinExist
#IfWinActive

/*
*****************************************
Name:		WhellUp&Down
Function:	Adjust Volume
*****************************************
*/

#IfWinActive ahk_class Shell_TrayWnd ;
WheelUp::
	SoundGet, vol_Master, Master
	Progress, b w200,,,My Title
	Progress, %vol_Master%
	vol_Master1 :=Round(vol_Master) "%"
	ToolTip ,%vol_Master1%,830,-447
	SetTimer, vOff,2000
return

WheelDown::
	SoundSet -5
	SoundGet, vol_Master, Master
	Progress, b w200,,,My Title
	Progress, %vol_Master%
	vol_Master1 :=Round(vol_Master) "%"
	ToolTip ,%vol_Master1%,830,-447
	SetTimer, vOff,2000
return

vOff:
	SetTimer, vOff, off
	Progress, Off
	tooltip
return
#IfWinActive
/*
;Kill this script itself
^!K::
	DetectHiddenWindows On ;允许探测到一个隐藏的脚本主窗口。
	SetTitleMatchMode 2 ;避免了需要给下面的文件指定完全路径。
	WinClose Tuan.ahk - AutoHotkey ;按脚本的名称更新这里的标题(区分大小写)。
	Return
;按 Ctrl+Alt+P 来暂停。再按一次则恢复
^!p::Pause 
*/

/*
if not A_IsAdmin
{ 
	DllCall("shell32\ShellExecuteA", uint, 0, str, "RunAs", str, A_AhkPath , str, """" . A_ScriptFullPath . """", str, A_WorkingDir, int, 1) 
	ExitApp
}
*/

/*
^!R::
	Reload

	PostMessage, 0x111, 65305,,, Tuan.ahk - AutoHotkey ;挂起。
	PostMessage, 0x111, 65306,,, Tuan.ahk - AutoHotkey ;暂停。
	Return
*/
/*
;Kill all QQ Program
k & q::
	IfWinExist QQ2013
	{
		QQ_Exist = 1
	}
	While(QQ_Exist = 1)
	{
		WinClose AHK_class TXGuiFoundation
		if ErrorLevel
		{
			MsgBox Invalid
			Control Check,,Button1
			return
		}
		WinWaitClose 
		IfWinExist QQ2013
		{
			QQ_Exist = 1
		}
		Else QQ_Exist = 0
	}
	Return
*/

/*
;Vim Key Binding
#if ( A_Cursor = "IBeam" or A_CaretX >= 100 )
{
	^j::send {down}

	^h::send {left}

	^k::send {up}

	^l::send {right}

	^0::send {home}

	^!k::send {pgup}

	^o::send {end}{enter}

	^!o::send {home}{enter}{up}

	!x::send {del}

	^!X::send +{end}{del 2}

	!d::send +^{left}{del}

	;^!d::send {home}{shift down}{end}{shift up}{del 2}

	return
}
#if
*/

