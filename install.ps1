[CmdletBinding()]
Param(
    [Switch] $IncludePowerShellGitRepos
)

$configPath = (Join-Path $PSScriptRoot '.config')
$script:RootPath = Split-Path $PSScriptRoot -Parent

# Set up symlinks
Get-ChildItem -Path $configPath -Directory | ForEach-Object {
    #! Must be admin
    # $ConfigScriptRoot = ([System.IO.Path]::Combine($HOME, '.config', $_.Name))
    # New-Item -Path $ConfigScriptRoot -ItemType SymbolicLink -Value $_.FullName -ErrorAction SilentlyContinue
    If ($_.Name -eq 'PowerShell') {
        $IncludeRepoSplat = @{
            IncludePowerShellGitRepos = $IncludePowerShellGitRepos.IsPresent
        }
        . ([System.IO.Path]::Combine($configPath, "$($_.FullName)", "install.ps1")) @IncludeRepoSplat
    } Else {
        . ([System.IO.Path]::Combine($configPath, "$($_.FullName)", 'install.ps1'))
    }
}


