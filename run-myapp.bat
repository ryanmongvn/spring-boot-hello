@echo off
set JAR_NAME=myapp.jar
set LOG_FILE=app.log
set PID_FILE=app.pid

echo Starting app...
start /B cmd /c "java -jar %JAR_NAME% > %LOG_FILE% 2>&1 & echo ! > %PID_FILE%"
echo App started.
