function Get-ZscalerDepartment
{
    <#
    .SYNOPSIS
    Gets information about Departments configured within ZIA

    .PARAMETER id
    Retrieve a department by its department ID

    .PARAMETER search
    Search within the "name" and "comments" attributes for the search term. This is a case-insensitive partial string match search.

    .EXAMPLE 
    PS> Get-ZscalerDepartment
    
    id          name               comments
    --          ----               --------
    11211611    IT                 IT
    11172659    Service Admin

    .EXAMPLE
    PS> Get-ZscalerDepartment -id 11211611
    
    id          name    comments
    --          ----    --------
    11211611    IT      IT

    .EXAMPLE
    PS> Get-ZscalerDepartment -search Admin

    isNonEditable       id          name
    -------------       --          ----
    True           11172659    Service Admin
    #>
    
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][string]$search
    )

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/departments" -f $global:ZscalerEnvironment.cloud)

    # construct the rest of the URI
    # first, see if they asked for an ID. If so, short-circuit the rest of the logic
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    } else {
        # no ID Specified. Build query string parameters array
        $parameters = [ordered]@{}
        if ($search) { $parameters.Add("search", $search) }

    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}