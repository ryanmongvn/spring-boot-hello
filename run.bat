@echo off
set JAR_NAME=myapp.jar
set PID_FILE=app.pid

:: Chạy app detached bằng cách gọi lại cmd
start "" cmd /c "start /min java -jar %JAR_NAME%"

:: Chờ 2 giây cho tiến trình khởi chạy
ping -n 3 127.0.0.1 > nul

:: Lưu PID mới nhất của java
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
    echo %%i > %PID_FILE%
    goto Done
)

:Done
echo App started and detached.
