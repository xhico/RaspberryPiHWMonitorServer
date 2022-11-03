Clear-Host

$files = @("server.py", "gunicorn_config.py", "HWMonitorServer\__init__.py", "HWMonitorServer\config.json", "HWMonitorServer\config.py")
foreach ($file in $files)
{
    Copy-Item .\$file Y:\HWMonitorServer\$file -Force
    Copy-Item .\$file X:\HWMonitorServer\$file -Force
}

$folders = @("main", "stats", "bots", "history", "eye", "static\css", "static\images", "static\js")
foreach ($folder in $folders)
{
    Remove-Item Y:\HWMonitorServer\HWMonitorServer\$folder\* -R -Force
    Copy-Item .\HWMonitorServer\$folder\* Y:\HWMonitorServer\HWMonitorServer\$folder\ -R -Force

    Remove-Item X:\HWMonitorServer\HWMonitorServer\$folder\* -R -Force
    Copy-Item .\HWMonitorServer\$folder\* X:\HWMonitorServer\HWMonitorServer\$folder\ -R -Force
}

Invoke-WebRequest -UseBasicParsing "http://192.168.1.14:33377/main/power" -Method POST -Body "{ 'option':'restart'}"
Invoke-WebRequest -UseBasicParsing "http://192.168.1.15:33377/main/power" -Method POST -Body "{ 'option':'restart'}"

