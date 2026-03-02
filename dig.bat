:: dig
@echo off
setlocal

if "%~1"=="" (
    goto :EOF
)

set entry=%*

powershell -Command "Resolve-DNSName %entry%"

endlocal