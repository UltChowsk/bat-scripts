:: config.ini loader
@echo off

set "scriptdir=%~dp0"
if "%scriptdir:~-1%"=="\" set "scriptdir=%scriptdir:~0,-1%"

set "configfile=%scriptdir%\config.ini"

    REM Exit if config.ini doesn't exist
    if not exist "%configfile%" (
        echo [31mError: %configfile% does not exist, exiting.[0m
        exit /b 1
    )

    for /f "usebackq tokens=1* delims==" %%a in ("%configfile%") do (
        if "%%a" neq "" if not "%%a"=="REM" (
            set "key=%%a"
            set "value=%%b"
            set "!key!=!value!"
        )
    )
