:: kubectl wrapper
@echo off
setlocal

if "%~1"=="" (
    goto :EOF
)

set args=%*

kubectl %args%

endlocal