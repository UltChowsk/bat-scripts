:: nslookup wrapper
@echo off
setlocal

if "%~1"=="" (
    goto :EOF
)

set args=%*

nslookup %args%

endlocal