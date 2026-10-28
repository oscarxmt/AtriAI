Write-host "[+] Preparing Uninstall..."

$Arti_Installer_Path = "$env:LOCALAPPDATA\Atri_Installer"
if (Test-Path $Arti_Installer_Path -PathType Container -eq "false") {
    Write-Host "[-] Could not find Atri path.... QUITTING..."
    exit
}

Write-Host "[+] Uninstalling Atri..."
Remove-Item -Path $Arti_Installer_Path -Recurse -Force

if (Test-Path $Arti_Installer_Path -PathType Container) {
    Write-Host "[+] Atri has been successfully uninstalled."
    exit
}
else {
    Write-Host "[+] An error occurred while uninstalling Atri. Please check the path $Arti_Installer_Path permissions and try again."
    exit
}