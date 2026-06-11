# Ollama Control for Windows

Ollama Control is a suite of lightweight and robust Windows batch scripts designed to manage, monitor, and automate the local Ollama LLM server and application.

## Purpose and Problem Solver

Ollama is a popular tool for running Large Language Models locally. However, its implementation on Windows presents several challenges that these scripts are designed to solve:

1. **Persistent Memory Consumption (VRAM/RAM):** Once launched, Ollama keeps models loaded in your GPU VRAM or system RAM. This can severely degrade system performance when playing video games, rendering 3D graphics, or running other memory-intensive tasks.
2. **Hidden Background Processes:** Ollama runs both as a GUI tray application and a background server process. Closing the GUI does not always release the background server or free the active model from memory.
3. **API Port Binding Issues:** Sometimes Ollama's API port (11434) remains bound by zombie processes, preventing new instances from launching properly.
4. **Hardcoded User Paths:** Standard startup shortcuts often rely on fixed user directories, making them break when shared or moved between different Windows users.

This project addresses these issues by providing one-click scripts to gracefully start, completely stop (reclaiming all VRAM/RAM), check the status of, and update/restart Ollama.

## Prerequisites

Ensure Ollama is installed on your Windows machine before running these scripts:

1. Download the Windows installer from the official website: https://ollama.com/download/windows
2. Run the OllamaSetup.exe installer.
3. Verify the installation by running `ollama --version` in your command prompt.

## Key Features

- **No Emojis or Bloat:** Clean, text-based terminal outputs.
- **Dynamic Path Detection:** Automatically resolves directories using environment variables such as %LocalAppData%, %ProgramFiles%, and %USERPROFILE%.
- **Complete Resource Cleanup:** Forcefully terminates all related Ollama tasks and releases port 11434, ensuring your GPU memory is completely freed.
- **Port-Aware Startup:** Checks if the port is active before launching the CLI or GUI, preventing duplicate instance conflicts.

## Scripts Included

- **`start-ollama.bat`**: Detects if the CLI is in the system PATH, verifies if the API server is active on port 11434 (starts it if not), launches the system tray application, and opens the status page in your default browser.
- **`stop-ollama.bat`**: Forcefully kills all process trees starting with "ollama" and terminates any remaining process listening on port 11434 to free system resources.
- **`status-ollama.bat`**: Scans the active Windows process list to report whether the Ollama server is running.
- **`update-and-restart.bat`**: Pulls updates for your specified model, kills the running instance, and launches a fresh server.

## Installation and Setup

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/qafaraz/ollama-control.git
   cd ollama-control
   ```

2. Run any script by double-clicking it:
   - Run `start-ollama.bat` to launch Ollama.
   - Run `stop-ollama.bat` to completely shut down Ollama and reclaim resources.
   - Run `status-ollama.bat` to see if it is running.
   - Run `update-and-restart.bat` to pull the latest model and reload.

## Customizing the Update Script

By default, the update script pulls the `llama3` model. If you use a different model:

1. Open `update-and-restart.bat` in a text editor.
2. Locate the line `ollama pull llama3`.
3. Replace `llama3` with your model name (e.g. `gemma2` or `mistral`).
4. Save the file.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
