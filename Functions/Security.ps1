function Get-ZscalerWhitelistUrl
{
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Get-ZscalerBlacklistUrl
{
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security/advanced" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}