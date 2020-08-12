Function Get-ZscalerUsers
{
    $cloud = $global:ZscalerEnvironment.cloud
    $websession = $global:ZscalerEnvironment.webession

    # set the URI
    $uri = ("https://admin.{0}.net/api/v1/users" -f $cloud)
    return Invoke-RestMethod -uri $uri -Method Get -WebSession $websession
}