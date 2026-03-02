:: wget, but it works
@echo off
setlocal

if "%~1"=="" (
    goto :EOF
)

set entry=%1

powershell -Command "$url = '%entry%'; $fileName = [System.IO.Path]::GetFileName($url); $savePath = Join-Path (Get-Location) $fileName; Invoke-WebRequest -Uri $url -OutFile $savePath"

endlocal