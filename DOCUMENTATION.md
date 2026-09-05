# Documentation of Registry Editor Tool  

## General

This tool allows you to **change registry keys** relating to certain *Windows settings* and *features*, allowing you to *easily turn them on or off or change their behaviour*.  

A registry key is **a small piece of data that tells Windows (or a certain program) how to operate**. This may include things such as *startup files*, *configuration settings* or *more*. These keys are very versatile for configuring Windows to your liking. Normally, you would have to use the registry editor or the command prompt to change registry keys, which is slow and prone to user error. However this program allows you to change some common registry keys quickly and safely.

At any screen, press **the key marked in between brackets** to **select the function** that you want to run.

> [!IMPORTANT]
>
>  If you do not own the computer, it is recommended to ask your **system administrator** for **permission** before using REGCHG, or ask to do the relevant changes in *Group Policy Editor (GPEdit.msc)*
>
> If you are unsure that any of the following functions may affect your computer in a way that you do not expect, please **back up the registry**, as it will allow you to *restore your computer back to its original state* in case of failure.

> [!TIP]
>
> If this program appears to have *frozen*, please make sure that the program **is not waiting for you to press a key** (indicated by "Press any key to continue . . ." on the screen). If pressing a key does nothing, hold the Control (`CTRL`) key, then press `C`, and then answer `Y` to any prompts, then restart the program. 

Liability is clarified in the [LICENSE](github.com/laninternet/regchg/LICENSE) file.

## System Requirements

REGCHG requires a computer with **Windows Vista (6.0.6001)** or over, with **admin privileges available at *any time***. Unless stated, *all functions* are compatible with Windows Vista or over.

## Questions

Any questions or doubt should be reported as an [issue](https://github.com/laninternet/regchg/issues). Use the relevant issue template please.

For feature requests, ensure that your changes follow the contributing guidelines. Then, please submit a [pull request](https://github.com/laninternet/regchg/pulls) and wait for approval. 

## Functions 

### 1) Disable Bing Internet Search Results in Windows Search

By default, when you type in Windows Search, it will automatically search your term that you entered in Bing, and provide results. This feature makes Search slower, uses more system ressources and is often inaccurate. Using this function will disable this functionality, and Windows will no longer search using Bing, providing a smoother experience.

The registry keys used are:
- `HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer\DisableSearchBoxSuggestions`
- `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled`

This function is only compatible with Windows 8 or over.

### 2) Enabling Verbose Boot Messages

By default, Windows does not show precise boot, login or logout messages, showing messages such as:
- `Please wait`
- `Restarting`
- `Signing out`

Using this function, it will replace the messages with messages such as:
- `Please wait for the User Profile Service`
- `Stopping Service: Windows Update Optimisation`
- `Preparing Windows`

This function is useful, especially for slower computers as you can see which part of the operation is taking the most time, as well as what is actually happening during these processes.

The registry keys used are:
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\VerboseStatus`

### 3) Uninstall Edge

Microsoft does not provide an uninstaller for Edge, therefore for users who want to uninstall this application, the application must be force-killed, then forcefully removed. This has the side effect of Windows thinking the program still exists.

This option should only be used if you are certain that no applications that you are using depend on any Microsoft Edge features, the most common being MSEdge WebView2 Engine which relies on Edge Core. REGCHG will warn you before uninstalling Edge. If you decide to change your mind later, simply download [Microsoft Edge](https://www.microsoft.com/en-us/edge/download) and let the installer run. After the installation process, restart your computer.

Any errors that may arise should be ignored as certain computer configuration may have different files, and REGCHG tries to be compatible to as many Windows computers as possible.

The operations used are:
- Takeown: `C:\PROGRA~2\MICROSOFT`
- Kill processes: `"msedge.exe", "MicrosoftEdgeUpdate.exe", "MSEdgeWebView2.exe"`
- Remove directory: `C:\PROGRA~2\MICROSOFT`
- Delete: `%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk`
- Delete: `C:\Users\Public\Desktop\Microsoft Edge.lnk`
- Delete: `%USERPROFILE%\Desktop\Microsoft Edge.lnk`
- Delete: `C:\Users\Public\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk`
- Delete: `%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk`

This function only applies to Windows versions with Microsoft Edge preinstalled, and does not apply to older versions of Windows with Internet Explorer preinstalled.

### 4) Restore Windows 10 Right-Click Menu 

In Windows 11, Microsoft has pushed a simplified version of the right click menu, which hides some options. This function restored the Windows 10 Right-click menu, which allows you to see all options without clicking "See more options".

The registry keys used are:
- `HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32`

This function is only compatible with Windows 11 or above.

### 5 and 6) "Everything" functions

Both of these functions will execute functions 1, 2, 4, 7 and 8, with option 5 only executing option 3. See the corresponding options for more information.

Lan Internet recommends the use of these functions for a brand-new PC build.

> [!NOTE]
>
> Using functions 6 and 5 will disable password expiry for all users. Use individual functions if you do not want this.

### 7) Copilot Removal

By default, Microsoft Copilot AI is present in many parts of the OS (Edge, Notepad, etc), and collects data on what you do on the computer, for the interest of Microsoft. This function disables Copilot in Windows, and prevents it from analysing your data. 

The registry keys used are:
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot\TurnOffWindowsCopilot`
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI\DisableAIDataAnalysis`

### 8 and 9) Disable Password Expiry functions

Passwords for user accounts expire by default every 90 days. This may be annoying to some people, and REGCHG provides a way to disable that functionality. 
If there is no red text or error messages, this means that the operation was successful.

The command used for disabling password expiry for one user is:
- `powershell /c Set-LocalUser -Name '%username%' -PasswordNeverExpires $true`
The command used for disabling password expiry to the entire computer is:
- `powershell /c "Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true"`

### 0) Quit Program

This option quits the program.

### M) MAS (Microsoft Activation Scripts) Windows Activator

This is a Windows Activator that allows you to activate Windows and Office through several methods. This function requires an internet connection (preferably with 256MB of available data connection, if you are using a metered or limited internet plan)

> [!IMPORTANT] 
> 
> This is a third-party program, that Lan Internet is not affiliated to in any way, shape or form. Please refer to the [`massgravel/microsoft-activation-scripts`](github.com/massgravel/Microsoft-Activation-Scripts) for additional information about this program. Liability is clarified in the [LICENSE](https://github.com/laninternet/regchg/LICENSE) file. 

The command used to run MAS is:
- `powershell /c "iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)"`

This function may not be compatible with Windows 8.1 or below. Refer to the third-party program's repository for more information. 

### S) Windows Shell Utility

On startup, Windows loads the Shell. The Shell will be the main user interface for the user. For most users, it will be EXPLORER.EXE, however if you want to setup your system as a POS or kiosk, you may want to replace the default shell with something else. This function allows you to change the Shell program.

> [!TIP]
> 
> You may also specify any command line arguments you want, which will be executed with the program that you have specified. Such examples include:
> - `C:\Windows\py.exe C:\\WinAIO\\G-AIO.py`
> - `C:\WINDOWS\SYSTEM32\CMD.EXE /C pause`
> - `D:\downloads\idunno.exe --help`
> - `C:\Windows\Notepad.exe`

> [!IMPORTANT]
>
>  You must specify the FULL FILE PATH (with the drive letter included, see the examples above) to your application and make sure that the file is USABLE (not read/write protected). If you do not respect this rule, Windows will NOT be able to find your application and will display a black screen upon startup (you will have to start the `Task Manager` and start this program again, and reconfigure it which is doable but annoying so it is best to avoid these troubles now)

The registry key used is:
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell`

### F) Fix Blank Explorer Warning Pop-up on startup

You may see a pop-up like the one below on startup whenever you start your computer. This is an error that Windows shows to let you know there was an error in loading a startup program. However it is not very clear on what it is. This functions aims to remove this pop-up by reverting some registry keys.

{Insert Image Here}

> [!NOTE]
>
> The fix for this involves deleting a registry key. However since the name of the registry key has changed across Windows Versions, and REGCHG is designed to operate on the widest range of computers, you may see errors. For this function of this program, as long as at least one command completed successfully (or you see "The operation has completed successfully" at least once), this means that the fix has succeeded. If the system says "ERROR: The system was unable to find the specified registry key or value.", it can be safely ignored.

The registry keys used are:
- `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\Load`


### R) Reinstall Wwindows Root/SSL Certificates

Certificates allow your computer to connect to the open world securely. Sometimes, these certificates get corrupted, and may break certain applications or programs. This functions aims to fix this problem by reinstalling Windows Root/SSL Certificates.

The commands used are:
- `certutil -generateSSTFromWU roots.sst`
- `powershell -Command "Import-Certificate -FilePath 'roots.sst' -CertStoreLocation 'Cert:\LocalMachine\Root'"`

### E) Wind tgows Explorer Utilities

This function opens the Windows Explorer Utilities, which allow you to configure certain aspects of the main file manager, EXPLORER.EXE. 

> [!IMPORTANT]
>
> Set your Windows Version correctly using Option 5 of this program before doing any operation with Explorer Utilities. It is important that the version number you enter is corresponding to your current Windows version, as different registry keys are used on different Windows versions. Entering the wrong version will cause the wrong registry keys to be applied, which could cause serious system errors! To check your windows version, simply run `winver` to see your Windows Version

Functions 1-4 (add/remove folder) allow you to configure the navigation pane (or in simpler terms the left sidebar) 

> [!NOTE]
>
> Some functions may not do anything or may perform the wrong operation. If that is the case, check that your Windows version is set correctly. If you were using option 3 or 4, try the other option. This problem may arise when using "NTDEV Tiny Windows" Builds

The registry keys used for Functoins 1-4 are:
- `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{CORRESPONDING_FOLDER_GUID}`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{CORRESPONDING_FOLDER_GUID}`

If REGCHG is configured as Windows 11, the `"HideIfEndabled"=dword:{value}` will be used in the same registry keys as the above.

### A) Enable Administrator Accounts

This option enables the built-in Administrator account, which may be required in order to perform certain Windows tasks and/or use certain programs.

The command used is:
- `net user Administrator /active:yes`

### C) Change Hostname (Computer Name)

Your computer has a name that it broadcasts alongisde its IP (192.168.xx.xx) on the network, which makes it easier to identify a PC on the network. This name can be changed to anything. 

> [!NOTE]
>
> Please note that special characters such as $, * or £, as well as linguistic characters such as é, è or à may cause problems, therefore it is recomended not to use them.

The registry keys used are:
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ComputerName`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameter\NV Hostname`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Hostname`

### W) Change Workgroup (Network Sector)

Windows computers (as well as some others) have a Workgroup associated to them. If you have multiple computers on the same network, you can change the workgroup associated to some computers.

As an example, let `WORKGR` and `WORKGROUP` be 2 different workgroups on the same networks. Computers in the `WORKGR` workgroup are able to see other computers in the `WORKGR` workgroup. They cannot see computers in the `WORKGROUP` workgroup. The same is true for computers in `WORKGROUP`


