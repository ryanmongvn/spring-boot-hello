@echo off
set JAR_NAME=myapp.jar
set LOG_FILE=app.log

echo Killing old Java process...
for /f "tokens=2 delims=," %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
    taskkill /PID %%i /F >nul 2>&1
)

echo Starting %JAR_NAME%
start /B java -jar %JAR_NAME% > %LOG_FILE% 2>&1
