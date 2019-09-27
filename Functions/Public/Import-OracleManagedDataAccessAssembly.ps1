function Import-OracleManagedDataAccessAssembly {
    [CmdletBinding()]
    Param(
        [string]$OraclePackageName = "Oracle.ManagedDataAccess.Core"
    )
    if (([System.Management.Automation.PSTypeName]'Oracle.ManagedDataAccess.Client.OracleConnection').Type) {
        Write-Verbose "Skipping loading the Oracle dll as it's already loaded"
        return
    }
    $OraclePackage = Get-Package $OraclePackageName -ErrorAction SilentlyContinue
    if ($null -eq $OraclePackage) {
        Write-Host "$OraclePackageName package is not installed. Installing..."
        if ($null -eq (Get-Command Install-Package -ErrorAction SilentlyContinue)) {
            throw "Package manager not installed. Cannot install $OraclePackageName"
        }
        $OraclePackage = Install-Package $OraclePackageName
        Write-Host "Installed $OraclePackageName version $($OraclePackage)"
    }
    [string]$PackageDirectory = Split-Path -Path $OraclePackage.Source -Parent
    $DLLFile = Get-ChildItem $PackageDirectory -Recurse -File -Include "Oracle.ManagedDataAccess.dll" | Select-Object -First 1
    if ($null -eq $DLLFile) {
        throw "Could not find the Oracle.ManagedDataAccess.dll file to load in the package directory $PackageDirectory"
    }
    Add-Type -Path $DLLFile
}
