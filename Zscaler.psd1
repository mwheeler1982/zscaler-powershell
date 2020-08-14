@{
    ModuleVersion = '1.0'
    GUID = '14670d1f-ac06-4e3d-aea7-991c14d8cbbd'
    NestedModules = @(
        '.\Functions\Authentication.ps1',
        '.\Functions\Users.ps1',
        '.\Functions\SSL.ps1',
        '.\Functions\Activation.ps1'
    )
    FunctionsToExport = @('*')
}