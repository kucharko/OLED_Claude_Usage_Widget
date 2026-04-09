@echo off
title OLED Claude Usage Monitor - Installer
color 0A

echo.
echo  ============================================
echo   OLED Claude Usage Monitor Widget - Setup
echo  ============================================
echo.

:: Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo  [!] Node.js is not installed.
    echo      Download it from: https://nodejs.org/
    echo      Install the LTS version, then run this script again.
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node -v') do set NODE_VER=%%i
echo  [OK] Node.js found: %NODE_VER%

:: Check npm
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo  [!] npm is not installed. It should come with Node.js.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm -v') do set NPM_VER=%%i
echo  [OK] npm found: %NPM_VER%
echo.

:: Install dependencies
echo  [1/3] Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo.
    echo  [!] npm install failed. Check errors above.
    pause
    exit /b 1
)
echo  [OK] Dependencies installed.
echo.

:: Ask user what they want
echo  Choose an option:
echo.
echo    1 - Run the app now (development mode)
echo    2 - Build Windows installer (.exe)
echo    3 - Both (build + run)
echo    4 - Exit
echo.
set /p CHOICE="  Your choice (1-4): "

if "%CHOICE%"=="1" goto run
if "%CHOICE%"=="2" goto build
if "%CHOICE%"=="3" goto both
if "%CHOICE%"=="4" goto done
goto done

:run
echo.
echo  [2/3] Starting OLED Claude Usage Monitor...
call npm start
goto done

:build
echo.
echo  [2/3] Building Windows installer...
echo         This may take a few minutes.
call npm run build
if %errorlevel% neq 0 (
    echo.
    echo  [!] Build failed. Check errors above.
    pause
    exit /b 1
)
echo.
echo  [OK] Build complete!
echo      Check the "dist" folder for:
echo        - Setup .exe (installer)
echo        - Portable .exe (no install needed)
echo.
explorer dist
goto done

:both
echo.
echo  [2/3] Building Windows installer...
call npm run build
if %errorlevel% neq 0 (
    echo.
    echo  [!] Build failed. Check errors above.
    pause
    exit /b 1
)
echo  [OK] Build complete! Check the "dist" folder.
echo.
echo  [3/3] Starting OLED Claude Usage Monitor...
call npm start
goto done

:done
echo.
echo  Done.
echo.
pause
