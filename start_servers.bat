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

echo [OK] All required files found
echo.

REM Ask which servers to start
echo Which servers would you like to start?
echo.
echo 1. All servers (Login + World + Channel 1)
echo 2. Login server only
echo 3. World server only
echo 4. Channel server only
echo 5. Custom selection
echo.
set /p choice="Enter choice (1-5): "

if "%choice%"=="1" goto start_all
if "%choice%"=="2" goto start_login
if "%choice%"=="3" goto start_world
if "%choice%"=="4" goto start_channel
if "%choice%"=="5" goto start_custom
goto invalid_choice

:start_all
echo.
echo Starting all servers...
echo.
start "Valhalla - Login Server" cmd /k "Valhalla.exe -type login -config config_login.toml"
timeout /t 2 /nobreak >nul
start "Valhalla - World Server" cmd /k "Valhalla.exe -type world -config config_world.toml"
timeout /t 2 /nobreak >nul
start "Valhalla - Channel 1" cmd /k "Valhalla.exe -type channel -config config_channel_1.toml -metrics-port 9001"
echo.
echo [OK] All servers started in separate windows
echo.
goto end

:start_login
echo.
echo Starting Login Server...
start "Valhalla - Login Server" cmd /k "Valhalla.exe -type login -config config_login.toml"
echo [OK] Login server started
goto end

:start_world
echo.
echo Starting World Server...
start "Valhalla - World Server" cmd /k "Valhalla.exe -type world -config config_world.toml"
echo [OK] World server started
goto end

:start_channel
echo.
echo Starting Channel Server...
start "Valhalla - Channel 1" cmd /k "Valhalla.exe -type channel -config config_channel_1.toml -metrics-port 9001"
echo [OK] Channel server started
goto end

:start_custom
echo.
echo Custom server selection:
echo.
set /p start_login="Start Login server? (y/n): "
set /p start_world="Start World server? (y/n): "
set /p start_channel="Start Channel server? (y/n): "
set /p start_channel2="Start Channel 2? (y/n): "
set /p start_channel3="Start Channel 3? (y/n): "
set /p start_cashshop="Start Cash Shop server? (y/n): "

if /i "%start_login%"=="y" (
    start "Valhalla - Login Server" cmd /k "Valhalla.exe -type login -config config_login.toml"
    timeout /t 1 /nobreak >nul
)

if /i "%start_world%"=="y" (
    start "Valhalla - World Server" cmd /k "Valhalla.exe -type world -config config_world.toml"
    timeout /t 1 /nobreak >nul
)

if /i "%start_channel%"=="y" (
    start "Valhalla - Channel 1" cmd /k "Valhalla.exe -type channel -config config_channel_1.toml -metrics-port 9001"
    timeout /t 1 /nobreak >nul
)

if /i "%start_channel2%"=="y" (
    if exist config_channel_2.toml (
        start "Valhalla - Channel 2" cmd /k "Valhalla.exe -type channel -config config_channel_2.toml -metrics-port 9002"
        timeout /t 1 /nobreak >nul
    ) else (
        echo [WARNING] config_channel_2.toml not found, skipping Channel 2
    )
)

if /i "%start_channel3%"=="y" (
    if exist config_channel_3.toml (
        start "Valhalla - Channel 3" cmd /k "Valhalla.exe -type channel -config config_channel_3.toml -metrics-port 9003"
        timeout /t 1 /nobreak >nul
    ) else (
        echo [WARNING] config_channel_3.toml not found, skipping Channel 3
    )
)

if /i "%start_cashshop%"=="y" (
    if exist config_cashshop.toml (
        start "Valhalla - Cash Shop" cmd /k "Valhalla.exe -type cashshop -config config_cashshop.toml -metrics-port 9100"
    ) else (
        echo [WARNING] config_cashshop.toml not found, skipping Cash Shop
    )
)

echo.
echo [OK] Selected servers started
goto end

:invalid_choice
echo.
echo [ERROR] Invalid choice
pause
exit /b 1

:end
echo.
echo ========================================
echo   Servers are running in separate windows
echo   Close those windows to stop the servers
echo ========================================
echo.
pause
