@echo off
setlocal EnableDelayedExpansion

set JAR_NAME=myapp.jar
set LOG_FILE=app.log
set PID_FILE=app.pid

echo Starting app...

:: Chạy hoàn toàn detached khỏi Jenkins shell
start "" /B cmd /c "java -jar %JAR_NAME% > %LOG_FILE% 2>&1"

:: Đợi tiến trình được khởi tạo
timeout /t 2 >nul

:: Lấy PID java mới nhất (nếu chỉ có 1 app java đang chạy thì OK)
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
    echo %%i > %PID_FILE%
    goto Done
)

:Done
echo PID saved to %PID_FILE%
endlocal
