@echo off
echo ========================================
echo   Stopping Valhalla Servers
echo ========================================
echo.

echo Closing server CMD windows...
REM Find and close CMD windows with Valhalla in the title
powershell -Command "Get-Process cmd -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*Valhalla*' } | ForEach-Object { Write-Host \"Closing: $($_.MainWindowTitle)\"; Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue }" 2>NUL
REM Also find CMD processes that are parents of Valhalla.exe processes
powershell -Command "$valhallaPids = (Get-Process Valhalla -ErrorAction SilentlyContinue).Id; if ($valhallaPids) { Get-Process cmd -ErrorAction SilentlyContinue | ForEach-Object { $cmdPid = $_.Id; $isParent = Get-CimInstance Win32_Process -Filter \"ParentProcessId = $cmdPid\" -ErrorAction SilentlyContinue | Where-Object { $valhallaPids -contains [int]$_.ProcessId }; if ($isParent) { Write-Host \"Closing CMD parent window (PID: $cmdPid)\"; Stop-Process -Id $cmdPid -Force -ErrorAction SilentlyContinue } } }" 2>NUL

echo.
echo Searching for running Valhalla processes...
tasklist /FI "IMAGENAME eq Valhalla.exe" 2>NUL | find /I /N "Valhalla.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo Found running Valhalla processes
    echo.
    taskkill /F /IM Valhalla.exe
    if %ERRORLEVEL% EQU 0 (
        echo [OK] All Valhalla servers stopped
    ) else (
        echo [ERROR] Failed to stop some processes
    )
) else (
    echo [INFO] No Valhalla processes found running
)

echo.
echo Final cleanup - closing any remaining server CMD windows...
REM One more pass to close any CMD windows that might have been orphaned
powershell -Command "Get-Process cmd -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*Valhalla*' } | Stop-Process -Force -ErrorAction SilentlyContinue" 2>NUL
powershell -Command "Get-Process cmd -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -match 'Login Server|World Server|Channel|Cash Shop' } | Stop-Process -Force -ErrorAction SilentlyContinue" 2>NUL

echo.
timeout /t 2 /nobreak >nul
exit
