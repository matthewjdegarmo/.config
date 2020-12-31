$configPath = $PSScriptRoot

# Set up symlinks
Get-ChildItem -Path $configPath -Directory | ForEach-Object {
    New-Item -Path ([System.IO.Path]::Combine($HOME, '.config', $_.Name)) -ItemType SymbolicLink -Value $_.FullName
}

$IsPSDependInstalled = Get-Module PSDepend -ListAvailable
If (-Not($IsPSDependInstalled)) {
    Install-Module PSDepend -Force
}
Invoke-PSDepend -Force (Join-Path $PSScriptRoot 'requirements.psd1')
