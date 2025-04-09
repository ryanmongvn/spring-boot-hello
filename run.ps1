$jar = "myapp.jar"
$pidFile = "app.pid"

# Chạy app Java không ghi log, không console, detached
$process = Start-Process "java" -ArgumentList "-jar $jar" -NoNewWindow -PassThru

# Lưu PID để stop sau này
$process.Id | Out-File -Encoding ascii $pidFile
Write-Host "App started with PID $($process.Id)"
