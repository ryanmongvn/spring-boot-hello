@echo off
set JAR_NAME=myapp.jar
set LOG_FILE=app.log
set PID_FILE=app.pid

echo Starting app...

powershell -Command "Start-Process 'java' '-jar %JAR_NAME%' -NoNewWindow -PassThru | Select-Object -ExpandProperty Id > '%PID_FILE%'"

echo App started with PID in %PID_FILE%.
