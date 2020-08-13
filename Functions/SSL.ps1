function Get-ZscalerSSLExemptedUrls
{
    # construct the URI
    $uri = ("https://admin.{0}.net/api/v1/sslSettings/exemptedUrls" -f $global:ZscalerEnvironment.cloud)

    # send the request
    return (Invoke-RestMethod -uri $uri -Method Get -WebSession $global:ZscalerEnvironment.webession).urls
}