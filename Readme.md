# zscaler-powershell

### Zscaler Powershell Modules
This module is intended to be a starting point when interacting with the Zscaler APIs

### Quickstart 
- Set your environment
    - `Set-ZscalerEnvironment -cloud "<your_cloud>" -apikey "<your_apikey>" -username "<api_username>" -password "<api_password>"`
- Authenticate and get a session
    - `Get-ZscalerAPISession`
- Make API Requests!

### Setting up your environment
- To instantiate your environment, you can use the `Get-ZscalerEnvironmentFromFile` command like this:

 ```
    Get-ZscalerEnvironmentFromFile ./.Zscaler/config
``` 
 
 Where the argument is the path to your config file. The config file needs to look like this, with values filled in specific to your Zscaler cloud and account:
 ```
    cloud = zscalerthree
    username = username-goes-here
    password = password-goes-here
    apikey = apikey-goes-here
```

### Authentication
##### Getting an API session
- To authenticate to the Zscaler API, run `Get-ZscalerAPISession` after having successfully created your environment in the previous step. If there is no output to this command, it was successful. This command calls a PUT method on the /authenticatedSession REST endpoint: https://help.zscaler.com/zia/api#/API%20Authentication/postAuthenticatedSessionInfo 

##### Ending API Session
- To remove your authentication token and "log out" of the API session, run `Remove-ZscalerAPISession`. This command calls a DELETE method on the /authenticatedSession REST endpoint https://help.zscaler.com/zia/api#/API Authentication/setAuthenticatedSessionInfo

### Activating Changes
- If you have made any changes to the configuration, you'll need to activate them just like in the WebUI Admin console.

##### Check if changes are pending
- To check if changes are pending, use the `Get-ZscalerActivationStatus` command. This calls the `/status` REST endpoint: https://help.zscaler.com/zia/api#/Activation/getOrganizationActivationStatus

##### Activate pending changes
- To activate any pending changes, use the `Set-ZscalerActivateChanges` command. This calls the `/status/activate` REST endpoint: https://help.zscaler.com/zia/api#/Activation/activateOrganizationalChanges

### Location Management

### Full list of commands
```
Add-ZscalerUrlFilteringRule
Get-ZscalerActivationStatus
Get-ZscalerAPISession
Get-ZscalerBlacklistUrl
Get-ZscalerDepartment
Get-ZscalerEnvironmentFromFile
Get-ZscalerGreTunnelInfo
Get-ZscalerGroup
Get-ZscalerLocation
Get-ZscalerSessionCookie
Get-ZscalerSSLExemptedUrl
Get-ZscalerSublocation
Get-ZscalerUrlCategory
Get-ZscalerUrlFilteringRule
Get-ZscalerUrlLookup
Get-ZscalerUser
Get-ZscalerWhitelistUrl
Remove-ZscalerAPISession
Remove-ZscalerUrlFilteringRule
Set-ZscalerActivateChanges
Set-ZscalerEnvironment
Set-ZscalerSSLExemptedUrl
Set-ZscalerWhitelistUrl
Update-ZscalerUrlCategory
```



