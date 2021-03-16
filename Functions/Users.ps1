Function Get-ZscalerUser
{
    <#
    .SYNOPSIS
    Gets user information from ZIA. If called with no parameters, will attempt to return the first 100 users configured.

    .PARAMETER id
    Gets the user with the specified User ID. User ID is an internal field and is not the username that is used for authentication.

    .PARAMETER name
    Searches for users with a case-insensitive partial string match of their name field. Can be combined with dept and group for a more refined search.

    .PARAMETER dept
    Searches for users with a case-insensitive partial string match of their department field. Can be combined with name and group for a more refined search.

    .PARAMETER group
    Searches for users with a case-insensitive partial string match of their groups. Can be combined with name and dept for a more refined search.

    .PARAMETER page
    By default, users are listed in "pages" of 100 users at a time. Use this option to request a subsequent page.

    .PARAMETER pageSize
    Override the default page size of 100. This is the maximum number of records that will be returned with any search operation.

    .EXAMPLE
    PS> Get-ZscalerUser
    id         : 11172660
    name       : DEFAULT ADMIN
    email      : admin@11172657.zscalerthree.net
    groups     : {@{id=11172658; name=Service Admin}}
    department : @{id=11172659; name=Service Admin}
    adminUser  : True

    id         : 11221784
    name       : Michael J. Wheeler
    email      : mwheeler@mwheeler.net
    groups     : {@{id=11221783; name=Splunk_Users}}
    department : @{id=11211611; name=IT}
    adminUser  : False

    .EXAMPLE
    PS> Get-ZscalerUser -id 11221784 |format-table

    id          name               email                 groups                              department              adminUser
    --          ----               -----                 ------                              ----------              ---------
    11221784    Michael J. Wheeler mwheeler@mwheeler.net {@{id=11221783; name=Splunk_Users}} @{id=11211611; name=IT}     False

    .EXAMPLE
    PS> Get-ZscalerUser -name wheel -group Splunk

    id         : 11221784
    name       : Michael J. Wheeler
    email      : mwheeler@mwheeler.net
    groups     : {@{id=11221783; name=Splunk_Users}}
    department : @{id=11211611; name=IT}
    adminUser  : False

    .EXAMPLE
    PS> Get-ZscalerUser -group spl -page 1 -pagesize 1000


    id         : 11221784
    name       : Michael J. Wheeler
    email      : mwheeler@mwheeler.net
    groups     : {@{id=11221783; name=Splunk_Users}}
    department : @{id=11211611; name=IT}
    adminUser  : False

    
    #>
    
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][string]$name,
        [Parameter(Mandatory=$false)][string]$dept,
        [Parameter(Mandatory=$false)][string]$group,
        [Parameter(Mandatory=$false)][int]$page,
        [Parameter(Mandatory=$false)][int]$pageSize
    )

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/users" -f $global:ZscalerEnvironment.cloud)

    # construct the rest of the URI
    # first, see if they asked for an ID. If so, short-circuit the rest of the logic
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    } else {
        # no ID Specified. Build query string parameters array
        $parameters = [ordered]@{}
        if ($name) { $parameters.Add("name", $name) }
        if ($dept) { $parameters.Add("dept", $dept) }
        if ($group) { $parameters.Add("group", $group) }
        if ($page) { $parameters.Add("page", $page) }
        if ($pageSize) { $parameters.Add("pageSize", $pagesize) }
    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

Function Remove-ZscalerUsersBulk {
    
    # parameters
    param(
        [Parameter(Mandatory=$true)][string[]]$ids
    )

    # build the parameter list
    $parameters = [ordered]@{}
    $parameters.Add("ids", $ids)

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/users/bulkDelete" -f $global:ZscalerEnvironment.cloud)

    # send the request
    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $parameters) -ContentType 'application/json'

}