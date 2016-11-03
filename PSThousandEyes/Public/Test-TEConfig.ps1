Function Test-TEConfig {
    <#
    .SYNOPSIS
    Used to check your configuration. 
    .DESCRIPTION
    Used to check your configuration. Calls an API to test the token. 
    .EXAMPLE
    Test-TEConfig
    #>

    $Result = Invoke-TeRequest -Command 'agents'
    $Result
}