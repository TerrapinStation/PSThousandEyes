Function Test-TEConfig {
    <#

    .SYNOPSIS
    Used to check your configuration and validate access to ThousandEyes API. 

    .DESCRIPTION
    Used to check your configuration and validate access to ThousandEyes API.  Can be used to test access before running more complicated.

    .EXAMPLE
    Test-TEConfig

    #>


    try{
        $Result = Invoke-TeRequest -Command 'status'
        $Result = New-Object PSObject -Property @{
            'TE API Test' = 'Succeeded'
        }

        return $Result

    }catch{
        $Result = New-Object PSObject -Property @{
            'TE API Test' = 'Failed'
        }
    }
}