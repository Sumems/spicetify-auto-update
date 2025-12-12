<#
.SYNOPSIS
    Manages Spicetify Auto-Update Shortcut (Install & Uninstall).

.DESCRIPTION
    This script provides a uniform interface to:
    1. INSTALL: Creates the "Spotify (Spicetify)" Standalone Desktop Shortcut.
    2. UNINSTALL: Removes the Desktop Shortcut (and cleans up any old Startup Tasks).

.NOTES
    File Name      : Manage-SpicetifyAutoUpdate.ps1
    Author         : Sumems
#>

# Ensure Admin Privileges (Auto-Elevation)
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Requesting Administrator privileges..." -ForegroundColor Yellow
    $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
    $ProcessInfo.FileName = "powershell.exe"
    $ProcessInfo.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Definition)`""
    $ProcessInfo.Verb = "runas"
    try {
        [System.Diagnostics.Process]::Start($ProcessInfo)
    } catch {
        Write-Error "Failed to request Administrator privileges. Please run as Administrator manually."
    }
    exit
}


function Install-Automation {
    Write-Host "`n=== INSTALLING SHORTCUT ===" -ForegroundColor Cyan
    
    # Create Desktop Shortcut (Standalone)
    $WshShell = New-Object -ComObject WScript.Shell
    $DesktopPath = $WshShell.SpecialFolders.Item("Desktop")
    $ShortcutPath = Join-Path -Path $DesktopPath -ChildPath "Spotify (Spicetify).lnk"
    
    $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
    $SpicetifyExe = "$env:LOCALAPPDATA\spicetify\spicetify.exe"
    $SpotifyExe = "$env:APPDATA\Spotify\Spotify.exe"
    
    # Standalone Command: Update Spicetify then Start Spotify
    $CmdArgs = "& '$SpicetifyExe' update; Start-Process '$SpotifyExe'"
    
    $Shortcut.TargetPath = "powershell.exe"
    $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"$CmdArgs`""
    
    if (Test-Path $SpotifyExe) { $Shortcut.IconLocation = "$SpotifyExe,0" }
    $Shortcut.Description = "Launch Spotify with Spicetify Auto-Update"
    $Shortcut.Save()
    Write-Host "[OK] Desktop Shortcut Created: Spotify (Spicetify)" -ForegroundColor Green

    # Copy to Start Menu
    $StartMenuPath = [Environment]::GetFolderPath("Programs")
    $StartMenuShortcutPath = Join-Path -Path $StartMenuPath -ChildPath "Spotify (Spicetify).lnk"
    Copy-Item -Path $ShortcutPath -Destination $StartMenuShortcutPath -Force
    Write-Host "[OK] Start Menu Shortcut Created." -ForegroundColor Green
    
    Write-Host "`nInstallation Complete! You can now safely delete this script folder if you wish." -ForegroundColor Yellow
}


function Uninstall-Automation {
    Write-Host "`n=== UNINSTALLING AUTOMATION ===" -ForegroundColor Magenta

    # 1. Remove Scheduled Task
    $TaskName = "SpicetifyAutoUpdate"
    try {
        if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
            Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction Stop
            Write-Host "[OK] Startup Task Removed." -ForegroundColor Green
        } else {
            Write-Warning "[INFO] Startup Task not found."
        }
    } catch {
        Write-Error "[FAIL] Could not remove Startup Task: $_"
    }

    # 2. Remove Desktop Shortcut
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $ShortcutPath = Join-Path -Path $DesktopPath -ChildPath "Spotify (Spicetify).lnk"
    
    if (Test-Path $ShortcutPath) {
        Remove-Item -Path $ShortcutPath -Force
        Write-Host "[OK] Desktop Shortcut Removed." -ForegroundColor Green
    } else {
        Write-Warning "[INFO] Desktop Shortcut not found."
    }

    # 3. Remove Start Menu Shortcut
    $StartMenuPath = [Environment]::GetFolderPath("Programs")
    $StartMenuShortcutPath = Join-Path -Path $StartMenuPath -ChildPath "Spotify (Spicetify).lnk"

    if (Test-Path $StartMenuShortcutPath) {
        Remove-Item -Path $StartMenuShortcutPath -Force
        Write-Host "[OK] Start Menu Shortcut Removed." -ForegroundColor Green
    } else {
        Write-Warning "[INFO] Start Menu Shortcut not found."
    }
    
    Write-Host "`nUninstallation Complete." -ForegroundColor Yellow
}

# Interactive Menu
Clear-Host
Write-Host "Spicetify Shortcut Manager" -ForegroundColor Cyan
Write-Host "==========================="
Write-Host "1. Install Shortcut (Standalone)"
Write-Host "2. Uninstall Shortcut (Cleanup)"
Write-Host "3. Exit"
Write-Host "==========================="

$choice = Read-Host "Choose an option (1-3)"

switch ($choice) {
    '1' { Install-Automation }
    '2' { Uninstall-Automation }
    default { Write-Host "Exiting..." }
}

Write-Host "`nPress any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
