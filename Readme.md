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
##### Windows
```
    Get-ZscalerEnvironmentFromFile .\.Zscaler\config
``` 

##### Mac OSX
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

NAME
    Add-ZscalerUrlFilteringRule
    
SYNTAX
    Add-ZscalerUrlFilteringRule [-name] <string> [-order] <int> [[-rank] <int>] [-state] <string> [-action] <string> [-protocols] <string[]> [-requestMethods] <string[]> [-urlCategories] <string[]> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerActivationStatus
    
SYNTAX
    Get-ZscalerActivationStatus 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerAPISession
    
SYNTAX
    Get-ZscalerAPISession 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerBlacklistUrl
    
SYNTAX
    Get-ZscalerBlacklistUrl 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerDepartment
    
SYNTAX
    Get-ZscalerDepartment [[-id] <string>] [[-search] <string>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerEnvironmentFromFile
    
SYNTAX
    Get-ZscalerEnvironmentFromFile [-FileName] <string> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerGreTunnelInfo
    
SYNTAX
    Get-ZscalerGreTunnelInfo 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerGroup
    
SYNTAX
    Get-ZscalerGroup [[-id] <string>] [[-search] <string>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerLocation
    
SYNTAX
    Get-ZscalerLocation [[-id] <string>] [[-search] <string>] [[-brief] <bool>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerSessionCookie
    
SYNTAX
    Get-ZscalerSessionCookie 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerSSLExemptedUrl
    
SYNTAX
    Get-ZscalerSSLExemptedUrl 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerSublocation
    
SYNTAX
    Get-ZscalerSublocation [-id] <string> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerUrlCategory
    
SYNTAX
    Get-ZscalerUrlCategory [[-customOnly] <bool>] [[-id] <string>] [[-brief] <bool>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerUrlFilteringRule
    
SYNTAX
    Get-ZscalerUrlFilteringRule [[-id] <string>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerUrlLookup
    
SYNTAX
    Get-ZscalerUrlLookup [[-domains] <string[]>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerUser
    
SYNTAX
    Get-ZscalerUser [[-id] <string>] [[-name] <string>] [[-dept] <string>] [[-group] <string>] [[-page] <int>] [[-pageSize] <int>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Get-ZscalerWhitelistUrl
    
SYNTAX
    Get-ZscalerWhitelistUrl 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Remove-ZscalerAPISession
    
SYNTAX
    Remove-ZscalerAPISession 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Remove-ZscalerUrlFilteringRule
    
SYNTAX
    Remove-ZscalerUrlFilteringRule [-id] <string> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Set-ZscalerActivateChanges
    
SYNTAX
    Set-ZscalerActivateChanges 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Set-ZscalerEnvironment
    
SYNTAX
    Set-ZscalerEnvironment [[-cloud] <string>] [[-apikey] <string>] [[-username] <string>] [[-password] <string>] 
    

ALIASES
    None
    

REMARKS
    None

NAME
    Set-ZscalerSSLExemptedUrl
    
SYNTAX
    Set-ZscalerSSLExemptedUrl [-action] <string> [-urls] <string[]> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Set-ZscalerWhitelistUrl
    
SYNTAX
    Set-ZscalerWhitelistUrl [[-force] <bool>] [[-urls] <string[]>] [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None

NAME
    Update-ZscalerUrlCategory
    
SYNTAX
    Update-ZscalerUrlCategory [-id] <string> [-action] <string> [-configuredName] <string> [-urls] <string[]> [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    None
```



