@echo off
echo ========================================
echo   MapleStory v28 Client Setup Helper
echo ========================================
echo.
echo This script helps you set up the game client.
echo.
echo NOTE: You need to download the client separately.
echo The client is NOT built - it's downloaded and patched.
echo.

:menu
echo.
echo Choose an option:
echo.
echo 1. Download pre-patched client (Recommended)
echo 2. Setup client hook DLL (if you have a client)
echo 3. Check if client is configured correctly
echo 4. Show connection information
echo 5. Exit
echo.
set /p choice="Enter choice (1-5): "

if "%choice%"=="1" goto download_client
if "%choice%"=="2" goto setup_hook
if "%choice%"=="3" goto check_client
if "%choice%"=="4" goto show_info
if "%choice%"=="5" goto end
goto invalid

:download_client
echo.
echo ========================================
echo   Pre-Patched Client Download
echo ========================================
echo.
echo Download link:
echo https://github.com/user-attachments/files/19866472/v28_noaes_patched_res_noie_mp.zip
echo.
echo This client is already configured for Valhalla:
echo   - No encryption (noaes)
echo   - Pre-patched for localhost
echo   - Windowed mode enabled
echo   - IE check removed
echo.
echo Instructions:
echo   1. Download the ZIP file from the link above
echo   2. Extract it to a folder (e.g., C:\MapleStory\v28\)
echo   3. Run the game executable
echo   4. It will connect to 127.0.0.1:8484 automatically
echo.
pause
goto menu

:setup_hook
echo.
echo ========================================
echo   Client Hook DLL Setup
echo ========================================
echo.
echo If you have an existing MapleStory v28 client:
echo.
echo 1. Download the client hook DLL from:
echo    https://github.com/Hucaru/maplestory-client-hook
echo.
echo 2. Place the DLL in your MapleStory client folder
echo    (same folder as the game .exe file)
echo.
set /p client_path="Enter your MapleStory client folder path: "
if "%client_path%"=="" (
    echo [ERROR] No path provided
    pause
    goto menu
)

if not exist "%client_path%" (
    echo [ERROR] Path does not exist: %client_path%
    pause
    goto menu
)

echo.
echo Client folder: %client_path%
echo.
echo Next steps:
echo   1. Download the hook DLL from GitHub
echo   2. Copy the DLL to: %client_path%
echo   3. Launch the game - the DLL will hook automatically
echo.
pause
goto menu

:check_client
echo.
echo ========================================
echo   Client Configuration Check
echo ========================================
echo.
set /p client_path="Enter your MapleStory client folder path: "
if "%client_path%"=="" (
    echo [ERROR] No path provided
    pause
    goto menu
)

if not exist "%client_path%" (
    echo [ERROR] Path does not exist: %client_path%
    pause
    goto menu
)

echo.
echo Checking client folder: %client_path%
echo.

REM Check for game executable
dir /b "%client_path%\*.exe" 2>nul | findstr /i "maple" >nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Found game executable
) else (
    echo [WARNING] Could not find game executable
)

REM Check for Data.wz
if exist "%client_path%\Data.wz" (
    echo [OK] Found Data.wz file
) else (
    echo [WARNING] Data.wz not found - client may not work
)

REM Check for hook DLL
if exist "%client_path%\*.dll" (
    echo [INFO] Found DLL file(s) - may be client hook
) else (
    echo [INFO] No DLL files found - using pre-patched client or no hook
)

echo.
echo Client check complete!
echo.
pause
goto menu

:show_info
echo.
echo ========================================
echo   Server Connection Information
echo ========================================
echo.
echo Your Valhalla server connection details:
echo.
echo   Login Server:  127.0.0.1:8484  (Client connects here)
echo   World Server:  127.0.0.1:8584   (Internal)
echo   Channel 1:     127.0.0.1:8685   (Internal)
echo   Channel 2:     127.0.0.1:8686   (Internal)
echo   Channel 3:     127.0.0.1:8687   (Internal)
echo   Cash Shop:    127.0.0.1:8600   (Internal)
echo.
echo The client only needs to connect to the Login Server.
echo Make sure your login server is running on port 8484!
echo.
echo To start servers, run: start_servers.bat
echo.
pause
goto menu

:invalid
echo.
echo [ERROR] Invalid choice
pause
goto menu

:end
echo.
echo Exiting...
exit /b 0
