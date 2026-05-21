:: Sets up AWS credentials and config files
@echo off
setlocal DisableDelayedExpansion

for /f "delims=" %%A in ('powershell -Command  ^
    "$p = Read-Host 'AWS Access Key' -AsSecureString; "^
    "$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p); "^
    "$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); "^
    "Write-Output $Plain"
    ') do set "access_key=%%A"

set access_key=%access_key:"=%

echo %access_key% | find "=" > nul
if %errorlevel% equ 0 (
    for /f "tokens=2 delims==" %%a in ("%access_key%") do set aws_access_key=%%a
) else (
    set aws_access_key=%access_key%
)


for /f "delims=" %%A in ('powershell -Command  ^
    "$p = Read-Host 'AWS Secret Key' -AsSecureString; "^
    "$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p); "^
    "$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); "^
    "Write-Output $Plain"
    ') do set "secret_key=%%A"

set secret_key=%secret_key:"=%

echo %secret_key% | find "=" > nul
if %errorlevel% equ 0 (
    for /f "tokens=2 delims==" %%a in ("%secret_key%") do set aws_secret_key=%%a
) else (
    set aws_secret_key=%secret_key%
)


for /f "delims=" %%A in ('powershell -Command  ^
    "$p = Read-Host 'AWS Session Token' -AsSecureString; "^
    "$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p); "^
    "$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); "^
    "Write-Output $Plain"
    ') do set "session_token=%%A"

set session_token=%session_token:"=%

echo %session_token% | find "=" > nul
if %errorlevel% equ 0 (
    for /f "tokens=2 delims==" %%a in ("%session_token%") do set aws_session_token=%%a
) else (
    set aws_session_token=%session_token%
)

set /p aws_region=Enter AWS region (default: us-east-1): 

if "%aws_region%"=="" (
    set "aws_region=us-east-1"
) else (
    set "aws_region=%aws_region%"
)

set credfile=%UserProfile%\.aws\credentials
set configfile=%UserProfile%\.aws\config

echo [default] > %credfile%
echo aws_access_key_id=%aws_access_key% >> %credfile%
echo aws_secret_access_key=%aws_secret_key% >> %credfile%
echo aws_session_token=%aws_session_token% >> %credfile%

echo [default] > %configfile%
echo region=%aws_region% >> %configfile%

powershell -Command "Set-Clipboard " "

endlocal