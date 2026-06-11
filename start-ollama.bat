@echo off
echo ==========================================
echo           Ollama Control Launcher
echo ==========================================
echo.

:: 1. Check if Ollama CLI is in PATH
where ollama >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Ollama CLI could not be found in your PATH.
    echo Please make sure Ollama is installed.
    pause
    exit /b
)

:: 2. Check if Ollama serve is already running on port 11434
netstat -ano | findstr :11434 >nul 2>&1
if %errorlevel% neq 0 (
    echo Starting Ollama background server [ollama serve]...
    start "" ollama serve
    ping 127.0.0.1 -n 4 >nul
) else (
    echo Ollama background server is already running.
)

:: 3. Find and start Ollama GUI (app.exe)
echo Locating Ollama App...
set "OLLAMA_APP="

if exist "%LocalAppData%\Programs\Ollama\ollama app.exe" (
    set "OLLAMA_APP=%LocalAppData%\Programs\Ollama\ollama app.exe"
) else if exist "%ProgramFiles%\Ollama\ollama app.exe" (
    set "OLLAMA_APP=%ProgramFiles%\Ollama\ollama app.exe"
) else if exist "%SystemDrive%\Program Files\Ollama\ollama app.exe" (
    set "OLLAMA_APP=%SystemDrive%\Program Files\Ollama\ollama app.exe"
) else if exist "%USERPROFILE%\AppData\Local\Programs\Ollama\ollama app.exe" (
    set "OLLAMA_APP=%USERPROFILE%\AppData\Local\Programs\Ollama\ollama app.exe"
)

if not "%OLLAMA_APP%"=="" (
    echo Found Ollama App at: "%OLLAMA_APP%"
    echo Launching Ollama App...
    start "" "%OLLAMA_APP%"
) else (
    echo [WARNING] Ollama GUI App [ollama app.exe] could not be found automatically.
    echo The background server has been started. You can run the app manually.
)

:: 4. Open status page in browser
echo Opening Ollama status page in browser...
ping 127.0.0.1 -n 3 >nul
start "" "http://localhost:11434"

echo Done!
exit