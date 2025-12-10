@echo off
setlocal enabledelayedexpansion

echo ========================================
echo   Starting Valhalla Servers
echo ========================================
echo.

REM Check if Valhalla.exe exists
if not exist Valhalla.exe (
    echo [ERROR] Valhalla.exe not found!
    echo Please run build.bat first to build the server.
    pause
    exit /b 1
)

REM Check if config files exist
if not exist config_login.toml (
    echo [ERROR] config_login.toml not found!
    pause
    exit /b 1
)

if not exist config_world.toml (
    echo [ERROR] config_world.toml not found!
    pause
    exit /b 1
)

if not exist config_channel_1.toml (
    echo [ERROR] config_channel_1.toml not found!
    pause
    exit /b 1
)

if not exist config_cashshop.toml (
    echo [ERROR] config_cashshop.toml not found!
    pause
    exit /b 1
)

echo [OK] All required files found
echo.

REM Start all servers automatically
echo Starting all servers...
echo.
start "Valhalla - Login Server" cmd /k "Valhalla.exe -type login -config config_login.toml"
timeout /t 2 /nobreak >nul
start "Valhalla - World Server" cmd /k "Valhalla.exe -type world -config config_world.toml"
timeout /t 2 /nobreak >nul
start "Valhalla - Channel 1" cmd /k "Valhalla.exe -type channel -config config_channel_1.toml -metrics-port 9001"
timeout /t 2 /nobreak >nul
start "Valhalla - Cash Shop" cmd /k "Valhalla.exe -type cashshop -config config_cashshop.toml -metrics-port 9100"
echo.
echo [OK] All servers started in separate windows
echo.
goto end


:end
echo.
echo ========================================
echo   Servers are running in separate windows
echo   Close those windows to stop the servers
echo ========================================
echo.
timeout /t 2 /nobreak >nul
exit
