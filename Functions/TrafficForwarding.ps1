function Get-ZscalerGreTunnelInfo
{
    <#
    .SYNOPSIS
    Get the list of GRE Tunnels configured in ZIA

    .EXAMPLE
    PS> Get-ZscalerGreTunnelInfo


    ipAddress         : 1.1.1.1
    greEnabled        : True
    greTunnelIP       : 172.17.x.x
    primaryGW         : 165.225.x.x
    secondaryGW       : 165.225.x.x
    tunID             : 12345
    greRangePrimary   : 172.17.x.x - 172.17.x.x
    greRangeSecondary : 172.17.x.x - 172.17.x.x

    ipAddress         : 2.2.2.2
    greEnabled        : True
    greTunnelIP       : 172.17.x.x
    primaryGW         : 165.225.x.x
    secondaryGW       : 165.225.x.x
    tunID             : 22345
    greRangePrimary   : 172.17.x.x - 172.17.x.x
    greRangeSecondary : 172.17.x.x - 172.17.x.x

    .EXAMPLE
    PS> Get-ZscalerGreTunnelInfo |format-table

    ipAddress      greEnabled   greTunnelIP     primaryGW       secondaryGW     tunID   greRangePrimary             greRangeSecondary
    ---------      ----------   -----------     ---------       -----------     -----   ---------------             -----------------
    1.1.1.1        True         172.17.x.x      165.225.x.x     165.225.x.x     12345   172.17.x.x - 172.17.x.x     172.17.x.x - 172.17.x.x
    2.2.2.2        True         172.17.x.x      165.225.x.x     165.225.x.x     22345   172.17.x.x - 172.17.x.x     172.17.x.x - 172.17.x.x
    #>
    # build the uri
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/orgProvisioning/ipGreTunnelInfo" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -ContentType 'application/json'
}