function Get-ZscalerActivationStatus
{
     # set the URI
    $uri = ("https://admin.{0}.net/api/v1/status" -f $global:ZscalerEnvironment.cloud)

    $result = Invoke-RestMethod -Uri $uri -WebSession $global:ZscalerEnvironment.websession -ContentType 'application/json'
    return $result
     
}

function Set-ZscalerActivateChanges
{
    # set the URI
    $uri = ("https://admin.{0}.net/api/v1/status/activate" -f $global:ZscalerEnvironment.cloud)

    return Invoke-WebRequest -Uri $uri -WebSession $global:ZscalerEnvironment.websession -ContentType 'application/json' -Method Post
}
