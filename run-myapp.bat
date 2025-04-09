@echo off
setlocal EnableDelayedExpansion

set JAR_NAME=myapp.jar
set LOG_FILE=app.log
set PID_FILE=app.pid

echo Starting app...

:: Dùng file tạm để chạy đúng tách tiến trình
echo java -jar !JAR_NAME! ^> !LOG_FILE! 2^>^&1 > runapp.cmd

start "" cmd /c runapp.cmd

:: Đợi chút cho app khởi chạy
timeout /t 2 >nul

:: Lưu PID
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
    echo %%i > !PID_FILE!
    goto Done
)

:Done
echo App started, PID written to !PID_FILE!
endlocal
