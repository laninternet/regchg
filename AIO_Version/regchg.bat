@echo off
:: This project will probably turn into a giant (but useful) monolith batch file -> all in one version. Separate file version coming soon.
set RESTARTCOMPUTER=
set WINVER= *** PLEASE CONFIGURE YOUR WINDOWS VERSION USING OPTION 5 ***
set CONFIGURED=0
set TITLE=Registry Editor 6
setlocal enabledelayedexpansion
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please wait for admin privileges to be authorised. Admin privileges must be present in order for regchg to run properly.
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)
:START
cls
title %TITLE% - (c) Lan Internet Software
echo *** %TITLE% - (c) Lan Internet Software ***
echo.
echo This program allows you to change certain Windows features and behaviours. 
echo In any doubt of anything, or if this is the first time using this program, consult the DOCUMENTATIONS.md file in the Lan Internet REGCHG repository.
echo.
echo In the "Everything" options, all users will have their password expiry disabled.
echo [1] Disable Bing/Internet Start Menu Search Results
echo [2] Enable Verbose Boot Messages - This will make boot messages more precise (read DOCUMENTATION.md for clarification)
echo [3] Uninstall Edge
echo [4] Restore Windows 10 style Right-click menu in Windows 11. (read DOCUMENTATION.md for clarification)
echo [5] Everything 
echo [6] Everything except Edge Uninstall 
echo [7] Disable Microsoft Copilot (Main Copilot and Data Analysis, read DOCUMENTATION.md for clarification)
echo [8] Disable password expiry for all users
echo [9] Disable password expiry for a user
echo [0] Quit Program
echo [M] MAS Windows Activator (Third-party program not made by Lan Internet Software, requires Internet Connection!)
echo [S] Configure Windows Shell
echo [F] Fix Blank Explorer Warning Pop-up on startup
echo [R] Reinstall Windows Root/SSL Certificates
echo [E] Explorer Utilities
echo [A] Enable Administrator Account
echo [C] Change hostname (Computer name on a network)
echo [W] Change workgroup (Network Sector)
echo.
echo Liability is clarified in the LICENSE of the REGCHG repository (https://github.com/laninternet/regchg)
echo.
choice /c:1234567890MSFREACW /m "Choose an option : "
IF ERRORLEVEL 18 GOTO WORKGR
IF ERRORLEVEL 17 GOTO SETPC
IF ERRORLEVEL 16 GOTO ADMIN
IF ERRORLEVEL 15 GOTO UTILS
IF ERRORLEVEL 14 GOTO INFO
IF ERRORLEVEL 13 GOTO FIX
IF ERRORLEVEL 12 GOTO SHELL
IF ERRORLEVEL 11 GOTO MAS
IF ERRORLEVEL 10 EXIT /B
IF ERRORLEVEL 9 GOTO SINGLEUSER
IF ERRORLEVEL 8 GOTO ALLUSERS
IF ERRORLEVEL 7 GOTO WINDOWSAI
IF ERRORLEVEL 6 GOTO EVERYTHING
IF ERRORLEVEL 5 GOTO AIO
IF ERRORLEVEL 4 GOTO W10
IF ERRORLEVEL 3 GOTO EDGE
IF ERRORLEVEL 2 GOTO VBM
IF ERRORLEVEL 1 GOTO WINSEARCH

:WORKGR
set /p WORG=Enter your desired workgroup name. If the workgroup in question does not exist, this program will create it for you. Note that special characters like $, * or £ may cause problems: 
powershell /c Add-Computer -WorkGroupName "%WORG%"
echo.
set RESTARTCOMPUTER=1
pause
goto END

:SETPC
set /p PCNAME=Enter your new computer name. Note that using special characters like $, * or £ may cause problems. Read the documentation for more information: 
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV Hostname" /t REG_SZ /d %PCNAME% /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /t REG_SZ /d %PCNAME% /f
set RESTARTCOMPUTER=1
echo.
pause
goto END



:ADMIN
net user administrator /active:yes
echo.
pause
goto START

:UTILS
cls 
set RESTARTCOMPUTER=1
echo *** %TITLE% (regchg.bat, running w/Admin Permissions) - (c) Lan Internet Software ***
echo.
echo Windows Explorer Utilities
echo.
echo Current Windows Version: %WINVER%
echo.
echo [1] Add all folders (Documents, Pictures, etc) to Navigation Pane (left sidebar)
echo [2] Remove all folders (Documents, Pictures, etc) to Navigation Pane (left sidebar)
echo [3] Add individual folders (Documents, Pictures, etc) to Navigation Pane (left sidebar)
echo [4] Remove individual folders (Documents, Pictures, etc) to Navigation Pane (left sidebar)
echo [5] Set Windows Version ( *** IMPORTANT *** )
echo [6] Exit Windows Explorer Utilities
echo [7] Display Explorer Utilities Information Screen (Troubleshooting Steps Here)
choice /c:1234567 /m "Choose an option. Remember to use Option 5 to configure your Windows Version: "
IF ERRORLEVEL 7 GOTO UTILINFO
IF ERRORLEVEL 6 GOTO END
IF ERRORLEVEL 5 GOTO WINCONFIG
IF ERRORLEVEL 4 GOTO INDRMV
IF ERRORLEVEL 3 GOTO INDADD
IF ERRORLEVEL 2 GOTO ALLRMV
IF ERRORLEVEL 1 GOTO ALLADD

:INDRMV
IF %CONFIGURED% EQU 0 goto WINCONFIG
echo.
echo [1] 3D Objects
echo [2] Desktop
echo [3] Documents
echo [4] Music
echo [5] Pictures
echo [6] Videos
echo [7] Downloads
echo [8] Return to Utilities Menu
choice /c:12345678 /m "Choose a folder to remove: "
IF ERRORLEVEL 8 GOTO UTILS
IF ERRORLEVEL 7 IF %WINVER% GEQ 11 GOTO W11RMVDOWN
IF ERRORLEVEL 7 IF %WINVER% LEQ 10 GOTO W10RMVDOWN
IF ERRORLEVEL 6 IF %WINVER% GEQ 11 GOTO W11RMVVIDS
IF ERRORLEVEL 6 IF %WINVER% LEQ 10 GOTO W10RMVVIDS
IF ERRORLEVEL 5 IF %WINVER% GEQ 11 GOTO W11RMVPICS
IF ERRORLEVEL 5 IF %WINVER% LEQ 10 GOTO W10RMVPICS
IF ERRORLEVEL 4 IF %WINVER% GEQ 11 GOTO W11RMVMUS
IF ERRORLEVEL 4 IF %WINVER% LEQ 10 GOTO W10RMVMUS
IF ERRORLEVEL 3 IF %WINVER% GEQ 11 GOTO W11RMVDOCS
IF ERRORLEVEL 3 IF %WINVER% LEQ 10 GOTO W10RMVDOCS
IF ERRORLEVEL 2 IF %WINVER% GEQ 11 GOTO W11RMVMUS
IF ERRORLEVEL 2 IF %WINVER% LEQ 10 GOTO W10RMVMUS
IF ERRORLEVEL 1 IF %WINVER% GEQ 11 GOTO W11RMV3DOBJ
IF ERRORLEVEL 1 IF %WINVER% LEQ 10 GOTO W10RMV3DOBJ

:INDADD
IF %CONFIGURED% EQU 0 goto WINCONFIG
echo.
echo [1] 3D Objects
echo [2] Desktop
echo [3] Documents
echo [4] Music
echo [5] Pictures
echo [6] Videos
echo [7] Downloads
echo [8] Return to Utilities Menu
choice /c:12345678 /m "Choose a folder to add: "
IF ERRORLEVEL 8 GOTO UTILS
IF ERRORLEVEL 7 IF %WINVER% GEQ 11 GOTO W11ADDDOWN
IF ERRORLEVEL 7 IF %WINVER% LEQ 10 GOTO W10ADDDOWN
IF ERRORLEVEL 6 IF %WINVER% GEQ 11 GOTO W11ADDVIDS
IF ERRORLEVEL 6 IF %WINVER% LEQ 10 GOTO W10ADDVIDS
IF ERRORLEVEL 5 IF %WINVER% GEQ 11 GOTO W11ADDPICS
IF ERRORLEVEL 5 IF %WINVER% LEQ 10 GOTO W10ADDPICS
IF ERRORLEVEL 4 IF %WINVER% GEQ 11 GOTO W11ADDMUS
IF ERRORLEVEL 4 IF %WINVER% LEQ 10 GOTO W10ADDMUS
IF ERRORLEVEL 3 IF %WINVER% GEQ 11 GOTO W11ADDDOCS
IF ERRORLEVEL 3 IF %WINVER% LEQ 10 GOTO W10ADDDOCS
IF ERRORLEVEL 2 IF %WINVER% GEQ 11 GOTO W11ADDMUS
IF ERRORLEVEL 2 IF %WINVER% LEQ 10 GOTO W10ADDMUS
IF ERRORLEVEL 1 IF %WINVER% GEQ 11 GOTO W11ADD3DOBJ
IF ERRORLEVEL 1 IF %WINVER% LEQ 10 GOTO W10ADD3DOBJ


:ALLADD
IF %CONFIGURED% EQU 0 goto WINCONFIG
IF %WINVER% GEQ 11 GOTO ADDALL11
IF %WINVER% LEQ 10 GOTO ADDALL10

:ADDALL11
::W11ADD3DOBJ
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
::W11ADDDKST
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
::W11ADDDOCS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
::W11ADDDOWN
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
::W11ADDMUS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
::W11ADDPICS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
::W11ADDVIDS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HideIfEnabled /t REG_NONE /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HiddenByDefault /t REG_DWORD /d 0x00000000 /f
pause
goto UTILS 

:ADDALL10
::W10ADD3DOBJ
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
::W10ADDDKST
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
::W10ADDDOCS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
::W10ADDDOWN
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
::W10ADDMUS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
::W10ADDPICS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
::W10ADDVIDS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
pause
goto UTILS 

:ALLRMV
IF %CONFIGURED% EQU 0 goto WINCONFIG
IF %WINVER% GEQ 11 GOTO RMVALL11
IF %WINVER% LEQ 10 GOTO RMVALL10

:RMVALL11
::W11RMV3DOBJ
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
::W11RMVDKST
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
::W11RMVDOCS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
::W11RMVDOWN
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
::W11RMVMUS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
::W11RMVPICS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
::W11RMVVIDS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HideIfEnabled /t REG_DWORD /d 0x022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HiddenByDefault /t REG_DWORD /d 0x00000001 /f
pause
goto UTILS 

:RMVALL10
::W10RMV3DOBJ
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
::W10RMVDKST
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
::W10RMVDOCS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
::W10RMVDOWN
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
::W10RMVMUS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
::W10RMVPICS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
::W10RMVVIDS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
pause
goto UTILS 

:: WIN10 Folder Removals

:W10RMV3DOBJ
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
echo.
pause
goto INDRMV
:W10RMVDKST
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo.
pause
goto INDRMV
:W10RMVDOCS
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo.
pause
goto INDRMV
:W10RMVDOWN
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo.
pause
goto INDRMV
:W10RMVMUS
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo.
pause
goto INDRMV
:W10RMVPICS
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo.
pause
goto INDRMV
:W10RMVVIDS
echo Using the WindowsStd Version
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo.
pause
goto INDRMV

::Win10 Folder Adds

:W10ADD3DOBJ
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
echo.
pause
goto INDADD
:W10ADDDKST
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo.
pause
goto INDADD
:W10ADDDOCS
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo.
pause
goto INDADD
:W10ADDDOWN
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo.
pause
goto INDADD
:W10ADDMUS
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo.
pause
goto INDADD
:W10ADDPICS
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo.
pause
goto INDADD
:W10ADDVIDS
echo Using the WindowsStd Version
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo.
pause
goto INDADD

:: Win11 Folder remove

:W11RMV3DOBJ
echo Using the Windows 11+ Version...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
echo.
pause
goto INDRMV
:W11RMVDKST
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV
:W11RMVDOCS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV
:W11RMVDOWN
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV
:W11RMVMUS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV
:W11RMVPICS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV
:W11RMVVIDS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HideIfEnabled /t REG_DWORD /v 022ab9b9 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HiddenByDefault /t REG_DWORD /v 00000001 /f
echo.
pause
goto INDRMV

:: Win11 Folder add
:W11ADD3DOBJ
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
echo.
pause
goto INDADD
:W11ADDDKST
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD
:W11ADDDOCS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD
:W11ADDDOWN
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD
:W11ADDMUS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD
:W11ADDPICS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD
:W11ADDVIDS
echo Using the Windows 11+ Version...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HideIfEnabled /t REG_DWORD /ve /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v HiddenByDefault /t REG_DWORD /v 00000000 /f
echo.
pause
goto INDADD


:UTILINFO
echo.
echo The "Windows Explorer Utilities" allow you to configure certain aspects of the main file manager, Windows Explorer.
echo IMPORTANT: It is important that you use Option 5 to set your Windows version correctly (7, 8, 10, 11, etc)
echo Options 1-4 (add/remove folder) rely on the following registry keys:
echo HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{CORRESPONDING_FOLDER_GUID}
echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{CORRESPONDING_FOLDER_GUID}
echo "HideIfEnabled"=dword:{corresponding values} in the same registry keys (if using Windows 11)
echo.
echo ** TROUBLESHOOTING **
echo Functions 1-4: If they do not appear to change anything, firstly make sure your Windows Version is set correctly as this tells REGCHG which registry keys are being used. Secondly you may try different Windows versions: some old Windows 11 builds use the old Windows 10 registry keys (may be more common on NTDEV Tiny builds). Lastly other settings may be conflicting with REGCHG, not allowing it to do the proper changes
echo.
echo ** NOTES**
echo For some reason, even though the code is all correct, options 3 and options 4 may be swapped (and thus not corresponding to their functions). It may be due to the use of Tiny Windows builds during testing. If that is the case, please try changing your Windows version to 10 or 11
pause
goto UTILS

:WINCONFIG
echo.
IF %CONFIGURED% EQU 0 echo Please configure your Windows Version to proceed.
echo IMPORTANT: It is important that the version number you enter is corresponding to your current Windows version, as different registry keys are used on different Windows versions. Entering the wrong version will cause the wrong registry keys to be applied, which could cause serious system errors!
echo.
set /p WINVER="Enter your simple Windows version (10, 11, 7, etc): "
set CONFIGURED=1 
echo.
pause
goto UTILS


:INFO
echo.
echo ============================================
echo   Updating Windows Root Certificates...
echo ============================================

:: Generate updated certificate bundle
certutil -generateSSTFromWU roots.sst

echo.
echo ============================================
echo   Importing certificates into Root store...
echo ============================================
set RESTARTCOMPUTER=1
echo.
pause
goto END

:: Import using PowerShell
powershell -Command "Import-Certificate -FilePath 'roots.sst' -CertStoreLocation 'Cert:\LocalMachine\Root'"

echo.
echo ============================================
echo   Certificate update complete.
echo ============================================
cls

:FIX
echo.
echo NOTE: The fix for this involves deleting a registry key. However since the name of the registry key has changed across Windows Versions, and REGCHG is designed to operate on the widest range of computers, you may see errors. For this function of this program, as long as at least one command completed successfully (or you see "The operation has completed successfully" at least once), this means that the fix has succeeded.
echo If the system says "ERROR: The system was unable to find the specified registry key or value.", it can be safely ignored.
echo.
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Run /f 
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Load /f 
echo.
pause
goto END


:SHELL
cls
echo *** %TITLE% - (c) Lan Internet Software ***
echo.
echo Windows Shell Utilities
echo.
echo [1] Set custom executable for Windows Shell
echo [2] Reset shell to C:\WINDOWS\EXPLORER.EXE
echo [3] Return to Main Menu
echo [4] Display Information Screen
choice /c:12 /m "Choose an option: "
IF ERRORLEVEL 4 GOTO INFO
IF ERRORLEVEL 3 GOTO START
IF ERRORLEVEL 2 GOTO RESETSHELL
IF ERRORLEVEL 1 GOTO SHCONFIG

:RESETSHELL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "C:\Windows\EXPLORER.EXE" /f
pause
goto END

:SHCONFIG
echo.
echo You may also specify command line arguments for your application when you will log on if your application supports it and if you want. Examples of valid applications and command line arguments:
echo 1: C:\Windows\py.exe C:\\WinAIO\\G-AIO.py
echo 2: C:\WINDOWS\SYSTEM32\CMD.EXE /C pause
echo 3: D:\downloads\idunno.exe --help
echo 4: C:\Windows\Notepad.exe
echo.
echo NOTE: You must specify the FULL FILE PATH to your application and make sure that the file is USABLE (not read/write protected). If you do not respect this rule, Windows will NOT be able to find your application and will display a black screen upon startup (you will have to start the Task Manager and start this program again, and reconfigure it which is doable but annoying so it is best to avoid these troubles now)
echo.
set /p shell=Enter the path to your executable name and any command line arguments: 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "%shell%" /f
pause
goto END


:MAS
echo.
echo MAS is a third party program made by "Massgravel" (https://github.com/massgravel/Microsoft-Activation-Scripts). MAS will open in a seperate window. Any problems that arise from the use of that program should be reported on Massgravel's repository and not the Lan Internet repository. 
echo.
echo If this program appears frozen after you've exited MAS, hold the CTRL key, then press C (CTRL-C). If it asks "Terminate batch job?", use N. If there is no red text or error messages, this means that the operation was successful! Note that you must press a key to start MAS.
pause
powershell /c "iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)"
REM set std command -> DoH for better compatibility
goto END

:ALLUSERS
echo.
powershell /c "Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true"
echo If there is no red text or error messages, this means that the operation was successful!
pause
goto END

:SINGLEUSER
echo.
set /p username="Enter the name of the user: "
powershell /c Set-LocalUser -Name '%username%' -PasswordNeverExpires $true
echo If there is no red text or error messages, this means that the operation was successful!
pause
goto END


:END
IF !RESTARTCOMPUTER!==1 GOTO ASKRESTART
echo.
choice /m "Exit program?"
IF ERRORLEVEL 2 GOTO START
IF ERRORLEVEL 1 GOTO REALEND

:REALEND
exit /b

:ASKRESTART
echo.            
echo The changes have successfully been made. Your computer must be restarted in order to apply the changes properly. Restart now?
echo If you restart your computer, REGCHG will give you 10 seconds after you say "Yes" before the computer will restart, so it is recommended to save all work in any and all open programs before selecting your choice..
choice
set RESTARTCOMPUTER=0
IF ERRORLEVEL 2 GOTO END
IF ERRORLEVEL 1 GOTO REBOOT

:REBOOT
shutdown /r /t 10 /c "This computer will reboot in 10 seconds. Make sure to save all of your work. Changes will be applied during the reboot - REGCHG.BAT"

:W10
echo.
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
set RESTARTCOMPUTER=1
pause
goto END

:EVERYTHING
echo.
net user administrator /active:yes
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
reg add HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v BingSearchedEnabled /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI /v DisableAIDataAnalysis /d 1 /f
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot /d 1 /f
powershell /c "Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true"
taskkill /f /im explorer.exe
timeout /t 2 /nobreak
set RESTARTCOMPUTER=1
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f
pause
goto END

:AIO
echo.
echo WARNING!!! Many applications rely on Microsoft Edge WebView 2 (and thus Microsoft Edge Core). Deleting Microsoft Edge will permanently destroy those functions until Edge is reinstalled. If you used option 5 by accident, use N at the next choice prompt, and then choose option 6.
echo.
echo This function works by force-removing the Microsoft Edge files, since no-uninstaller is provided. A side effect to this is that Windows still thinks Edge and its corresponding applications are installed.
echo.
echo Continue with delete operation?
choice
IF ERRORLEVEL 2 GOTO START
IF ERRORLEVEL 1 GOTO REALAIO

:REALAIO
echo.
net user administrator /active:yes
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
reg add HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v BingSearchedEnabled /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI /v DisableAIDataAnalysis /d 1 /f
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot /d 1 /f
powershell /c "Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true"
taskkill /f /im explorer.exe
timeout /t 2 /nobreak
set RESTARTCOMPUTER=1
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f
taskkill /f /im msedge.exe
taskkill /f /im MicrosoftEdgeUpdate.exe
::taskkill /f /im msedgewebview2.exe
takeown /f C:\PROGRA~2\Microsoft
::takeown /f C:\PROGRA~2\MicroSoft\EdgeWebView
::takeown /f C:\PROGRA~2\MicroSoft\EdgeWebView\Application
::del /f C:\PROGRA~2\MicroSoft\EdgeWebView\Application
::rd /q /s C:\Progra~2\MicroSoft\EdgeWebView
:: NEVER DELETE WEBVIEW2, MANY APPLICATIONS RELY ON IT
rd /q /s C:\PROGRA~2\Microsoft
del /f "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
del /f "C:\Users\Public\Desktop\Microsoft Edge.lnk"
del /f "%USERPROFILE%\Desktop\Microsoft Edge.lnk"
del /f "C:\Users\Public\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
del /f "%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
pause
goto END

:EDGE
echo.
echo WARNING!!! Many applications rely on Microsoft Edge WebView 2 (and thus Microsoft Edge Core). Deleting Microsoft Edge will permanently destroy those functions until Edge is reinstalled.
echo.
echo This function works by force-removing the Microsoft Edge files, since no-uninstaller is provided. A side effect to this is that Windows still thinks Edge and its corresponding applications are installed.
echo.
echo Continue with delete operation?
choice
IF ERRORLEVEL 2 GOTO START
IF ERRORLEVEL 1 GOTO REALEDGE
:REALEDGE
taskkill /f /im msedge.exe
taskkill /f /im MicrosoftEdgeUpdate.exe
taskkill /f /im msedgewebview2.exe
takeown /f C:\PROGRA~2\Microsoft
::takeown /f C:\PROGRA~2\MicroSoft\EdgeWebView
::takeown /f C:\PROGRA~2\MicroSoft\EdgeWebView\Application
::del /f C:\PROGRA~2\MicroSoft\EdgeWebView\Application
::rd /q /s C:\Progra~2\MicroSoft\EdgeWebView
rd /q /s C:\PROGRA~2\Microsoft
del /f "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
del /f "C:\Users\Public\Desktop\Microsoft Edge.lnk"
del /f "%USERPROFILE%\Desktop\Microsoft Edge.lnk"
del /f "C:\Users\Public\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
del /f "%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
pause
goto END

:VBM
echo.
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f
pause
goto END

:WINSEARCH
echo.
reg add HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v BingSearchedEnabled /t REG_DWORD /d 0 /f
taskkill /f /im explorer.exe
timeout /t 2 /nobreak
set RESTARTCOMPUTER=1
pause
goto END

:WINDOWSAI
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI /v DisableAIDataAnalysis /d 1 /f
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot /d 1 /f
pause
goto END



goto START
