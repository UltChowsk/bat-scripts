:: Set Kube Config
@echo off
setlocal enabledelayedexpansion

call _load_config

set /a counter=0

for %%f in ("%UserProfile%\.kube\*.config") do (
    set /a counter+=1
    set "file[!counter!]=%%~nxf"
    if "%~1"=="" (
    echo !counter!^) %%~nf
)
)

if %counter%==0 (
    echo No alternative kube .config files found in %UserProfile%\.kube\.
    goto end
)

if "%~1"=="-l" (
    call _get_current_kube_context
echo !info!Current kube config: !CONTEXT!!normal!
set /a counter=0

for %%f in ("%UserProfile%\.kube\*.config") do (
    set /a counter+=1
    set "file[!counter!]=%%~nxf"
    echo !counter!^) %%~nf
)
echo !normal!
goto end
)
if "%~1"=="" (
echo !normal!
set /p choice=Kube config to make active: 
) else (
    set choice=%~1
)
if not defined file[!choice!] (
    echo !warn!Invalid selection.!normal!
    goto end
)

call _get_current_kube_context

ren "%UserProfile%\.kube\config" "!CONTEXT!.config"
echo !info!Current kube config renamed to: !CONTEXT!.config.!normal!


ren %UserProfile%\.kube\!file[%choice%]! config
echo !info!!file[%choice%]! set as active kube config.!normal!

:end
endlocal