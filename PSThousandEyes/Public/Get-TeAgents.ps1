Function Test-TEConfig {
    <#

    .SYNOPSIS
    Lists all available ThousandEyes agents. 

    .DESCRIPTION
    Lists all available ThousandEyes agents.  Both internal and external agents are listed.

    .EXAMPLE
    Test-TEConfig

    #>
    
    try{
        # Validate the API is accessible
        $ApiStatus = Test-TEConfig

        If($ApiStatus.IsTeApiAvailable -eq $false){
            return 'TE API unavailable'
        }
    }catch{
        # An error occurred, pass on the error
        return $_
    }

    try{
        # Get all the agents
        $Result = Invoke-TeRequest -Command 'agents'

        return $Result

    }catch{
        # An error occurred, pass on the error
        return $_
    }
}