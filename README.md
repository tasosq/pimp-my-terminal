# My Windows Terminal Setup

This repo includes two installation scripts to streamline the installation & setup of:

- Windows Terminal
- PowerShell
- [Oh-my-posh](https://ohmyposh.dev/)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)
- [Chocolatey](https://chocolatey.org/)

## Showcase

![image](https://github.com/tasosq/pimp-my-terminal/assets/105006739/a512f3df-1749-49c5-a828-bbe57cfc0091)

## Usage

### 1. Open your current shell as an Administrator

### 2. Clone the repo.

```
git clone https://github.com/tasosq/pimp-my-terminal.git
```

### 3. Set the Execution Policy to Bypass so that you can run the scripts.

```
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

### 4. Run the `download-dependencies.ps1` script through your existing terminal.

This script installs Windows Terminal, PowerShell, Oh-my-posh , Terminal-Icons & Chocolatey.

### 5. Next, open the newly installed Windows Terminal (as an Admin) & run the `setup-shell-terminal.ps1` script.

The script will prompt you to pick an oh-my-posh theme, after outputting all of them to the terminal for you to choose.

### That's it! You now have a much better looking terminal!
