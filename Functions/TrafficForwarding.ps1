function Get-ZscalerGreTunnelInfo
{
    # build the uri
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/orgProvisioning/ipGreTunnelInfo" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -ContentType 'application/json'
}