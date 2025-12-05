@echo off
echo ========================================
echo   Stopping Valhalla Servers
echo ========================================
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
pause
