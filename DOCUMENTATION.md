# Documentation of Registry Editor Tool

## General

This tool allows you to change registry keys relating to certain Windows settings and features, allowing you to easily turn them on or off or change their behaviour. 


A registry key is a small piece of data that tells Windows (or a certain program) how to operate. This may include things such as startup files, configuration settings or more. These keys are very versatile for configuring Windows to your liking. Normally, you would have to use the registry editor or the command prompt to change registry keys, which is slow and prone to user error. However this program allows you to change some common registry keys quickly and safely.

At any screen, press the key marked in between brackets to select the function that you want to run.

NOTE: If you do not own the computer, it is recommended to ask your system administrator for permission before using REGCHG, or ask to do the relevant changes in Group Policy Editor (GPEdit.msc)

If you are unsure that any of the following functions may affect your computer in a way that you do not expect, please back up the registry, as it will allow you to restore your computer back to its original state in case of failure.

If this program appears to have frozen, please make sure that the program is not waiting for you to press a key (indicated by "Press any key to continue . . ." on the screen). If pressing a key does nothing, hold the Control (CTRL) key, then press C, and then answer 'Y' to any prompts, then restart the program. 
echo.

Unless stated otherwise, all functions are compatible with Windows Vista or over.

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

### 4) Restore Windows 10 Right-Click Menu 

In Windows 11, Microsoft has pushed a simplified version of the right click menu, which hides some options. This function restored the Windows 10 Right-click menu, which allows you to see all options without clicking "See more options".

The registry keys used are:
- `HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32`

### 5 and 6) "Everything" functions

Both of these functions will execute functions 1, 2, 4, 7 and 8, with option 5 only executing option 3. See the corresponding options for more information.

Lan Internet recommends the use of these functions for a brand-new PC build.

### 7) Copilot Removal

By default, Microsoft Copilot AI is present in many parts of the OS (Edge, Notepad, etc), and collects data on what you do on the computer, for the interest of Microsoft. This function disables Copilot in Windows, and prevents it from analysing your data. 

The registry keys used are:
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot`
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI /v DisableAIDataAnalysis`