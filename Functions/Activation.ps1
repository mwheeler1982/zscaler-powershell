function Get-ZscalerActivationStatus
{
    <#
    .SYNOPSIS

    Determine if there are pending changes to be activated

    .EXAMPLE

    PS> Get-ZscalerActivationStatus
    status
    ------
    ACTIVE

    .EXAMPLE

    PS> Get-ZscalerActivationStatus
    status
    ------
    PENDING
    #>
    $parameters = [ordered]@{}
    
     # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/status" -f $global:ZscalerEnvironment.cloud)

    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Set-ZscalerActivateChanges
{
    <#
    .SYNOPSIS

    Activate pending changes within the Zscaler management console

    .EXAMPLE

    PS> Set-ZscalerActivateChanges
    status
    ------
    ACTIVE
    #>
    $parameters = [ordered]@{}

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/status/activate" -f $global:ZscalerEnvironment.cloud)

    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}
