$log = @()
$log += '=== PROCESOS ==='
$log += (tasklist | Select-String -Pattern 'mysqld|httpd') -join "`n"
$log += ''
$log += '=== PUERTO 3306 ==='
$log += (netstat -ano | Select-String ':3306') -join "`n"
$log += ''
$log += '=== ARCHIVOS DATA (top 25 por tamano) ==='
$log += (Get-ChildItem 'C:\xampp\mysql\data' | Sort-Object Length -Descending | Select-Object -First 25 Name,Length,LastWriteTime | Format-Table -AutoSize | Out-String)
$log += '=== ERROR LOG ULTIMAS 30 LINEAS ==='
$log += (Get-Content 'C:\xampp\mysql\data\mysql_error.log' -Tail 30) -join "`n"
Set-Content -Path 'C:\xampp\mysql_diag.txt' -Value $log -Encoding UTF8
