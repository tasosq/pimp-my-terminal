# My Windows Terminal Setup

This repo includes two installation scripts to streamline the installation & setup of:

- Windows Terminal
- PowerShell
- [Oh-my-posh](https://ohmyposh.dev/)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)
- [Chocolatey](https://chocolatey.org/)

## Showcase

![image](https://github.com/tasosq/pimp-my-terminal/assets/105006739/f3a60d3c-2482-480c-a90a-8682604b2206)

## Usage

### 1. Open your current shell as an Administrator

### 2. Clone the repo.

```
git clone https://github.com/tasosq/pimp-my-terminal.git
```

### 3. Run the `download-dependencies.ps1` script through your existing terminal.

```
iex -Command "Set-ExecutionPolicy Bypass -Scope Process; .\download-dependencies.ps1"
```

This script installs Windows Terminal, PowerShell, Oh-my-posh , Terminal-Icons, Chocolatey and the SpaceMono Nerd Font.

### 4. Next, open the newly installed Windows Terminal (as an Admin) & run the `setup-shell-terminal.ps1` script.

```
iex -Command "Set-ExecutionPolicy Bypass -Scope Process; .\setup-shell-terminal.ps1"
```

The script will prompt you to pick an oh-my-posh theme, after outputting all of them to the terminal for you to choose.

### That's it! You now have a much better looking terminal!
