:: Shows all commands that this repo provides
@echo off
setlocal enabledelayedexpansion

call _load_config

set "scriptdir=%~dp0"

echo !info!--------!normal!

for %%f in ("%scriptdir%\*.bat") do (
    
    REM Skip files starting with _
    set "filename=%%~nxf"
    set "firstchar=!filename:~0,1!"

    if not "!firstchar!"=="_" (
    <"%%f" set /p desc=
    for /f "tokens=1* delims=:" %%a in ("!desc!") do (
            set desc=%%a
        )
    echo !info!%%~nf!normal! -!desc!
    )
)

echo !info!--------!normal!
:end
endlocal