@echo off
setlocal EnableDelayedExpansion

set JAR_NAME=myapp.jar
set LOG_FILE=app.log
set PID_FILE=app.pid

echo Starting app...

:: Ghi lệnh vào 1 file tạm để tránh lỗi redirect
echo @echo off > run-temp.bat
echo java -jar !JAR_NAME! ^> !LOG_FILE! 2^>^&1 >> run-temp.bat

:: Chạy tiến trình detached khỏi Jenkins
start "" /min cmd /c run-temp.bat

:: Chờ tiến trình khởi động
timeout /t 2 >nul

:: Ghi PID mới nhất của java (chỉ nếu có 1 tiến trình đang chạy)
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
    echo %%i > !PID_FILE!
    goto Done
)

:Done
echo App started with PID in !PID_FILE!

endlocal
