@echo off
setlocal enabledelayedexpansion

:menu
cls
echo 1. Remove a mod
echo 2. Add a mod
echo 3. Exit
set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" (
    call :removeMod
) else if "%choice%"=="2" (
    call :addMod
) else if "%choice%"=="3" (
    exit
) else (
    echo Invalid choice
    timeout /t 3
    goto menu
)

:removeMod
cls
echo Listing mods in "C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\plugins":
echo -----------------------------------------------
set count=1
for /d %%i in ("C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\plugins\*") do (
    echo !count!. [Folder] %%~nxi
    set mods[!count!]=%%~fi
    set /a count+=1
)
for %%i in ("C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\plugins\*") do (
    if not "%%~ni"=="*" (
        echo !count!. [File] %%~nxi
        set mods[!count!]=%%~fi
        set /a count+=1
    )
)

set /p modChoice=Enter the number of the mod to remove (or 0 to cancel): 

if "%modChoice%"=="0" goto menu

if exist "!mods[%modChoice%]!" (
    move "!mods[%modChoice%]!" "C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\Unused\"
    echo Mod removed successfully!
) else (
    echo Invalid choice
)

timeout /t 3
goto menu

:addMod
cls
echo Listing mods in "C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\Unused":
echo -----------------------------------------------
set count=1
for /d %%i in ("C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\Unused\*") do (
    echo !count!. [Folder] %%~nxi
    set unusedMods[!count!]=%%~fi
    set /a count+=1
)
for %%i in ("C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\Unused\*") do (
    if not "%%~ni"=="*" (
        echo !count!. [File] %%~nxi
        set unusedMods[!count!]=%%~fi
        set /a count+=1
    )
)

set /p unusedModChoice=Enter the number of the mod to add (or 0 to cancel): 

if "%unusedModChoice%"=="0" goto menu

if exist "!unusedMods[%unusedModChoice%]!" (
    move "!unusedMods[%unusedModChoice%]!" "C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag\BepInEx\plugins\"
    echo Mod added successfully!
) else (
    echo Invalid choice
)

timeout /t 3
goto menu

:: The following lines are hidden from casual view to protect the author information
:: Batch File: GorillaTagModManager.bat
:: Description: A simple batch file to manage mods for Gorilla Tag by enabling or disabling them.
:: Author: OpenAI ChatGPT