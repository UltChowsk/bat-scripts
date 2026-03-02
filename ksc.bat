:: kubectl set context
@echo off
setlocal

if "%~1"=="" (
    goto :EOF
)

set namespace=%1

kubectl config set-context --current --namespace  %namespace%"

endlocal