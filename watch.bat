:: watch, but bad
@echo off
if "%~1"=="" (
    echo Usage: %~nx0 command_to_run
    echo Example: %~nx0 ping 127.0.0.1
    exit /b 1
)

REM Rebuild command string
set "CMD=%*"

REM Escape special characters for use in CMD string
setlocal EnableDelayedExpansion
set "CMD_LINE="
for %%A in (%*) do (
    set CMD_LINE=!CMD_LINE! %%A
)

REM Launch a new CMD window with inline loop using FOR /L
start "LoopWindow" cmd /k "for /L %%i in (0,1,2147483647) do (%CMD_LINE% & timeout /t 2 >nul)"
