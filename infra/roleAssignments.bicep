param principalId string
param roles string[]
@allowed([
  'Device'
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'
])
param principalType string = 'User'

resource role 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for role in roles: {
  name: guid(principalId, principalType, role)
  properties: {
    principalId: principalId
    principalType: principalType
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', role)
  }
}]
