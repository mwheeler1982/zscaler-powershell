function Get-ZscalerActivationStatus
{
    $parameters = [ordered]@{}
    
     # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/status" -f $global:ZscalerEnvironment.cloud)

    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Set-ZscalerActivateChanges
{
    $parameters = [ordered]@{}

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/status/activate" -f $global:ZscalerEnvironment.cloud)

    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}
