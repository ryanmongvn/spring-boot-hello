$jar = "myapp.jar"
$log = "app.log"
$pidFile = "app.pid"

# Tạo tiến trình hoàn toàn detached
$process = Start-Process "java" -ArgumentList "-jar $jar" -RedirectStandardOutput $log -RedirectStandardError $log -NoNewWindow -PassThru

# Lưu PID
$process.Id | Out-File -Encoding ascii $pidFile
Write-Host "App started with PID $($process.Id)"
