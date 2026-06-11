@echo off
echo Checking Ollama status...

tasklist | findstr ollama

if %errorlevel%==0 (
    echo Ollama is RUNNING
) else (
    echo Ollama is NOT running
)

pause