:: Gets the current .kube config context
@echo off

if exist "%UserProfile%\.kube\config" (
    for /f "usebackq tokens=1,* delims=:" %%A in ("%UserProfile%\.kube\config") do (
        set "key=%%A"
        set "value=%%B"
        if /i "!key!"=="current-context" (
            set CONTEXT=!value:~1!
        )
    )

    REM Check if CONTEXT contains /
    set "CHECK=!CONTEXT:/=!"

    if not "!CHECK!"=="!CONTEXT!" (
        for /f "tokens=1* delims=/" %%A in ("!CONTEXT!") do (
            set "CONTEXT=%%B"
        )
    )

    set "CHECK=!CONTEXT:@=!"

    if not "!CHECK!"=="!CONTEXT!" (
        for /f "tokens=1* delims=@" %%A in ("!CONTEXT!") do (
            set "CONTEXT=%%B"
        )
    )
)