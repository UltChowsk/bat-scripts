:: Terminal History
@echo off
setlocal enabledelayedexpansion

call _load_config

echo !info!Opening terminal history...!normal!

powershell -Command "ii (Get-PSReadLineOption).HistorySavePath"

endlocal