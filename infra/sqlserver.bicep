param name string
param location string
param tags object = {}
@secure()
param saPassword string
param azureADOnlyAuthentication bool = false

@allowed([
  'Application'
  'Group' 
  'User'
])
param administratorPrincipalType string = 'User'
param administratorPrincipalId string = ''

resource sqlserver 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: saPassword
    administrators: (administratorPrincipalId != '') ? {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: azureADOnlyAuthentication
      login: 'sqlaadadmin'
      principalType: administratorPrincipalType
      sid: administratorPrincipalId
      tenantId: tenant().tenantId
    } : null
    primaryUserAssignedIdentityId: 'string'
    publicNetworkAccess: 'Enabled'
  }
  
}

resource fw 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = {
  name: 'AllowAzureServices'
  parent: sqlserver
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}
