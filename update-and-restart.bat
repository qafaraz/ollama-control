@echo off
echo Updating model...

ollama pull llama3

echo.
echo Restarting Ollama...

taskkill /F /IM ollama.exe
ping 127.0.0.1 -n 3 >nul
start cmd /k "ollama serve"

echo Done.
pause