function Get-ZscalerActivationStatus
{

    # parameters
    param(
        [Parameter(Mandatory=$false)][bool]$force
    )

    # function not working yet
    if (!$force) {
        write-host "This function does not yet work. Please wait for a future version."
        return    
    }
    

     # set the URI
    $uri = ("https://admin.{0}.net/api/v1/status" -f $global:ZscalerEnvironment.cloud)

    $result = Invoke-RestMethod -Uri $uri -WebSession $global:ZscalerEnvironment.websession -ContentType 'application/json'
    return $result
     
}

function Set-ZscalerActivateChanges
{
            # parameters
    param(
        [Parameter(Mandatory=$false)][bool]$force
    )

    # function not working yet
    if (!$force) {
        write-host "This function does not yet work. Please wait for a future version."
        return    
    }

    # function not working yet
    write-host "This function does not yet work. Please wait for a future version."
    return
    
    # set the URI
    $uri = ("https://admin.{0}.net/api/v1/status/activate" -f $global:ZscalerEnvironment.cloud)

    return Invoke-WebRequest -Uri $uri -WebSession $global:ZscalerEnvironment.websession -ContentType 'application/json' -Method Post
}
