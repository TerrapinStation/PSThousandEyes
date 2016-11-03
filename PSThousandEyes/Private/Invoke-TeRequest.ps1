Function Invoke-TeRequest{
    param(
        [Parameter(Mandatory=$true)]
        [string]$Command,
        [object]$Arguments   
    )

    $Headers = BuildHeader

    $CompleteCommand = "https://api.thousandeyes.com/$Command.json"
    #Write-Output "Running $CompleteCommand"

    try{
        If($Arguments){
            $JsonArguments = $Arguments | ConvertTo-Json
            $Results = Invoke-RestMethod $CompleteCommand -Headers $Headers -Body $JsonArguments -Method Put -ContentType 'application/json'
        }Else{
            $Results = Invoke-RestMethod $CompleteCommand -Headers $Headers
        }
    }catch{
        throw $_
    }

    $NoteProperties = $Results | Get-Member -MemberType NoteProperty

    If($NoteProperties.Count -eq 1){
        # Single result set, no need to bury it.
        return $Results.($NoteProperties[0].Name)

    }ElseIf($NoteProperties.Count -gt 1){
        # Multiple result sets (haven't seen this used yet, but just in case), just return stuff
        return $Results

    }Else{
        # No data
    }

}