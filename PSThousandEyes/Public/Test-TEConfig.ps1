Function Test-TEConfig {
    <#
    .SYNOPSIS
    Used to check your configuration. 
    .DESCRIPTION
    Used to check your configuration. Calls an API to test the token. 
    .EXAMPLE
    Test-TEConfig
    #>
    $TEConfig = ImportConfig
    $Email = $TEConfig.Email
    $Token = DecryptString -Token $TEConfig.Token
    $authorization = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Email + ":" + $Token))
    Remove-Variable Token
    $headers = @{"accept"= "application/json"; "content-type"= "application/json"; "authorization"= "Basic " + $authorization}
    $response = Invoke-WebRequest https://api.thousandeyes.com/agents.json -Headers $headers
    $response.content
}