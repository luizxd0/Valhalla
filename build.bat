@echo off
echo ========================================
echo   Building Valhalla Server
echo ========================================
echo.

REM Check if Go is installed
where go >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Go is not installed or not in PATH
    echo Please install Go from https://golang.org/dl/
    pause
    exit /b 1
)

echo [1/3] Checking Go installation...
go version
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to get Go version
    pause
    exit /b 1
)
echo.

echo [2/3] Downloading dependencies...
go mod download
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to download dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies downloaded
echo.

echo [3/3] Building Valhalla server...
go build -o Valhalla.exe
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

if exist Valhalla.exe (
    echo [OK] Build successful!
    echo [OK] Created: Valhalla.exe
    echo.
) else (
    echo [ERROR] Valhalla.exe was not created
    pause
    exit /b 1
)

echo ========================================
echo   Build Complete!
echo ========================================
pause
