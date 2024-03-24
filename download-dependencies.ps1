Write-Host "Installing Windows Terminal..."
winget install 9N0DX20HK701 -s msstore --accept-package-agreements --accept-source-agreements

Write-Host "Installing PowerShell..."
winget install 9MZ1SNWT0N5D -s msstore --accept-package-agreements --accept-source-agreements

Write-Host "Installing oh-my-posh..."
winget install oh-my-posh -s msstore --accept-package-agreements --accept-source-agreements
winget install JanDeDobbeleer.OhMyPosh -s winget --accept-package-agreements --accept-source-agreements

Write-Host "Installing terminal icons..."
Install-Module -Name Terminal-Icons -Repository PSGallery -Force -Scope CurrentUser

Write-Host "Please exit Windows PowerShell and Launch Windows Terminal from Start Menu. Then Run setup-shell-terminal to continue the setup.";

Write-Host  'Press any key to continue..';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Exit