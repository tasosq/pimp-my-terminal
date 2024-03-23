Write-Host "Initializing oh-my-posh..."
oh-my-posh init pwsh | Invoke-Expression

Write-Host "Fetch oh-my-posh themes:"
Get-PoshThemes

Write-Host "Installing fonts.."
$Source = ".\fonts\*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
$TempFolder = "C:\Windows\Temp\Fonts"
$Theme = "gruvbox.omp.json"

New-Item $TempFolder -Type Directory -Force | Out-Null

# Install Fonts
Get-ChildItem -Path $Source -Include '*.ttf', '*.ttc', '*.otf' -Recurse | ForEach-Object {
    $FontDestination = Join-Path -Path $Destination -ChildPath $_.Name
    if (-not (Test-Path $FontDestination)) {
        Copy-Item $_.FullName -Destination $Destination -Force
    }
}

# Create new $PROFILE. If $PROFILE exists already, it is moved as a back-up and replaced by the new one
if (Test-Path $PROFILE) {
    $BackupDirectory = [System.IO.Path]::Combine($env:USERPROFILE, "ProfileBackups")
    if (!(Test-Path $BackupDirectory)) {
        New-Item -ItemType Directory -Path $BackupDirectory -Force
    }

    $DateTime = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupFileName = [System.IO.Path]::GetFileNameWithoutExtension($PROFILE) + "_backup_$DateTime" + [System.IO.Path]::GetExtension($PROFILE)
    $BackupPath = [System.IO.Path]::Combine($BackupDirectory, $BackupFileName)

    Move-Item -Path $PROFILE -Destination $BackupPath -Force
    Write-Host "Backed up existing PowerShell Profile to $BackupPath"
}

New-Item -Path $PROFILE -Type File -Force
Write-Host "Created a new PowerShell Profile"

Add-Content -Path $PROFILE "oh-my-posh init pwsh --config '$env:POSH_THEMES_PATH\$Theme' | Invoke-Expression"

Write-Host "Updating Windows Terminal Config...";

$PowerShellPathToJSON = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

$PowerShellSettings = Get-Content $PowerShellPathToJSON -raw | ConvertFrom-Json
$PowerShellProfileId = "";
$customfont = @"
{
    face : 'RobotoMono Nerd Font Mono'
}
"@

$PowerShellSettings.profiles.list | % {
    if ($_.name -eq 'PowerShell') {
        $_ | Add-Member -Name "colorScheme" -Value "One Half Dark" -MemberType NoteProperty -Force
        $_ | Add-Member -Name "font" -Value (ConvertFrom-Json $customfont) -MemberType NoteProperty -Force
        $_ | Add-Member -Name "useAcrylic " -Value $False -MemberType NoteProperty -Force
        $_ | Add-Member -Name "opacity" -Value 92 -MemberType NoteProperty -Force
        $PowerShellProfileId = $_.guid
    }
}

$PowerShellSettings.defaultProfile = $PowerShellProfileId;

$PowerShellSettings | ConvertTo-Json -depth 5 | set-content $PowerShellPathToJSON

Write-Host "Settings have been applied. Exit Terminal and launch it again.";

Write-Host  'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
exit