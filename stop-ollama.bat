@echo off
echo Forcefully killing ALL Ollama processes...

taskkill /F /IM "ollama*" /T >nul 2>&1

for /f "tokens=5" %%a in ('netstat -aon ^| findstr :11434') do (
    taskkill /F /PID %%a >nul 2>&1
)

ping 127.0.0.1 -n 3 >nul

echo Checking port 11434 (This should be completely empty)...
netstat -ano | findstr :11434

echo Done.
pause