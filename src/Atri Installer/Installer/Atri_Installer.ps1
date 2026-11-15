$ErrorActionPreference = "Stop"

$ZipPath = Join-Path $TEMP "Atri_Installer.zip"
$InstallZip = Join-Path $LocalAppData "Atri_Installer.zip"
$InstallPath = Join-Path $LocalAppData "Atri_Installer"

try {

    Write-Host "[+] Downloading the latest version of Atri..."
    $Download = & curl.exe -X GET -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0" --fail --location --silent --show-error $LatestReleaseURI --output $ZipPath

    if ($LASTEXITCODE -ne 0) {
        throw "Download failed aw man. curl.exe exit code: $LASTEXITCODE"
    }

    if (!(Test-Path $ZipPath -PathType Leaf)) {
        throw "Downloaded ZIP file does not exist. BRUH"
    }

    if ((Get-Item $ZipPath).Length -eq 0) {
        throw "Downloaded ZIP file is empty check the URI."
    }

    Write-Host "[+] Download completed successfully."
    Write-Host "[+] Validating ZIP archive..."


    # WOO .NET MY LOVE
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $Archive = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
    try {
        if ($Archive.Entries.Count -eq 0) {
            throw "ZIP archive doesn't contain any files."
        }
    }
    finally {
        $Archive.Dispose()
    }

    Write-Host "[+] ZIP archive found."
    Write-Host "[+] Preparing installation..."

    # Moving the zip file :)
    Move-Item -Path $ZipPath -Destination $InstallZip -Force
    Write-Host "[+] Extracting Atri Installer..."

    if (Test-Path $InstallPath) {
        Remove-Item -Path $InstallPath -Recurse -Force
    }
    # unzipping lil freaky
    Expand-Archive -Path $InstallZip -DestinationPath $InstallPath -Force -ErrorAction Stop

    # Verifying unzip
    if (!(Test-Path $InstallPath -PathType Container)) {
        throw "Installation directory was not unzipped."
    }

    $ExtractedFiles = Get-ChildItem -Path $InstallPath -Recurse -File

    if ($ExtractedFiles.Count -eq 0) {
        throw "Extraction completed but no files were found. :("
    }

    Write-Host "[+] Atri Installer has been successfully installed."
    Write-Host "[+] Installation path: $InstallPath"

}
catch {
    Write-Host "[-] Installation failed! FREAK OUT TIME!" -ForegroundColor Red
    Write-Host "[-] Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
finally {

    Write-Host "[+] Cleaning up temporary files..."

    if (Test-Path $ZipPath) {
        Remove-Item -Path $ZipPath -Force -ErrorAction SilentlyContinue
    }

    if (Test-Path $InstallZip) {
        Remove-Item -Path $InstallZip -Force -ErrorAction SilentlyContinue
    }

    Write-Host "[+] Cleanup completed. WOO HOO!"

}
