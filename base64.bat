:: base64 encode and decode
@echo off
setlocal enabledelayedexpansion

call _load_config

setlocal disabledelayedexpansion

set decode=0

if "%1"=="-d" (
    set decode=1
    shift
)

set "input="

:rebuild_loop
if "%1"=="" goto done_rebuild
if defined input (
    set "input=%input% %1"
) else (
    set "input=%1"
)
shift
goto rebuild_loop

:done_rebuild

if not defined input (
    for /f "usebackq delims=" %%a in (`more`) do (
        set "input=%%a"
        goto :gotInput
    )
)

:gotInput
if %decode%==1 (
    REM depending on the input, the = gets dropped so we try and add it.
    powershell -NoProfile -Command ^
        "try { [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%input%')) } "^
        "catch { try { [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%input%=')) } "^
        "catch { try { [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%input%==')) } "^
        "catch { '%error%Unable to decode provided input.%normal%' } } }"
) else (
    powershell -NoProfile -Command ^
        "[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('%input%'))"
)
