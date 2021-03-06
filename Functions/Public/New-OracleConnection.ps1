function New-OracleConnection {
    [CmdletBinding()]
    [OutputType([Oracle.ManagedDataAccess.Client.OracleConnection])]
    Param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$UserId = "SYS AS SYSDBA",
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Password = "Streamserve16",
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$DataSource = "localhost/ORCLPDB1.localdomain"
    )
    Process {
        Import-OracleManagedDataAccessAssembly
        $ConnectionString = "User Id=$UserId;Password=$Password;Data Source=$DataSource"
        Write-Verbose "Creating new Oracle database connection with connection string ($ConnectionString)"
        [Oracle.ManagedDataAccess.Client.OracleConnection]::new($ConnectionString)
    }
}
