@echo off
set PID_FILE=app.pid

if exist %PID_FILE% (
    for /f %%i in (%PID_FILE%) do (
        echo Stopping app with PID %%i...
        taskkill /F /PID %%i
    )
    del %PID_FILE%
) else (
    echo PID file not found. App may not be running.
)
