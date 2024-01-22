param name string
param location string
param tags object = {}

resource manid 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: name
  location: location
  tags: tags
}

output uamidClientId string = manid.properties.clientId
output uamidPrincipalId string = manid.properties.principalId
