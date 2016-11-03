Function BuildHeader {
    <#
    .Synopsis
        Grabs token information and builds a header.

    .DESCRIPTION
        Grabs token information and builds a header.

    .EXAMPLE
        BuildHeader
    #>

    $TEConfig = ImportConfig
    $Email = $TEConfig.Email
    $Token = DecryptString -Token $TEConfig.Token
    $Authorization = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Email + ":" + $Token))
    Remove-Variable Token

    $Header = @{"accept"= "application/json"; "content-type"= "application/json"; "authorization"= "Basic " + $Authorization}

    return $Header
}
