:: grep
@echo off
setlocal enabledelayedexpansion

call _load_config

REM Check for pattern argument
if "%~1"=="" (
    echo !info!Usage: command ^| grep pattern!normal!
    exit /b 1
)

REM Pass stdin to PowerShell and run Select-String
powershell -NoProfile -Command "$input | Select-String -Pattern '%~1'"

endlocal