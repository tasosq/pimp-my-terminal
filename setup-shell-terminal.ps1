Write-Host "Initializing oh-my-posh..."
oh-my-posh init pwsh | Invoke-Expression


# Install Space Font
choco install nerd-fonts-spacemono -y

$PowerShellPathToJSON = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

$PowerShellSettings = Get-Content $PowerShellPathToJSON -raw | ConvertFrom-Json
$PowerShellProfileId = "";
$customfont = @"
{
    face : 'SpaceMono Nerd Font Mono'
}
"@

$PowerShellSettings.profiles.list | % {
    if ($_.name -eq 'PowerShell') {
        $_ | Add-Member -Name "colorScheme" -Value "One Half Dark" -MemberType NoteProperty -Force
        $_ | Add-Member -Name "font" -Value (ConvertFrom-Json $customfont) -MemberType NoteProperty -Force
        $_ | Add-Member -Name "useAcrylic " -Value $False -MemberType NoteProperty -Force
        $_ | Add-Member -Name "opacity" -Value 92 -MemberType NoteProperty -Force
        $_ | Add-Member -Name "padding" -Value 12 -MemberType NoteProperty -Force
        $PowerShellProfileId = $_.guid
    }
}

$PowerShellSettings.defaultProfile = $PowerShellProfileId;

$PowerShellSettings | ConvertTo-Json -depth 5 | set-content $PowerShellPathToJSON
Write-Host "Fetching oh-my-posh themes:"
Get-PoshThemes
$DefaultTheme = "gruvbox"
$Theme = Read-Host -Prompt "Enter your preferred oh-my-posh theme from the above"

Write-Host "Installing fonts.."
$Defaulted = $false;

# Set Default theme to Theme, if the provided one did not exist
if (-not (Test-Path "$env:POSH_THEMES_PATH\$Theme.omp.json")) {
    $Theme = $DefaultTheme;
    $Defaulted = $true;
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

Add-Content -Path $PROFILE "oh-my-posh init pwsh --config '$env:POSH_THEMES_PATH\$Theme.omp.json' | Invoke-Expression"
Add-Content -Path $PROFILE "Import-Module -Name Terminal-Icons"

Write-Host "Updating Windows Terminal Config...";



Write-Host "Settings have been applied.";

#Reload profile for changes to take effect
. $PROFILE

cls

if ($Defaulted -eq $true) {
    Write-host "The oh-my-posh theme you provided could not be found. Defaulted to $DefaultTheme theme.";
}
exit