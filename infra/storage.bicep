param location string
param name string

resource stor 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  kind: 'StorageV2'
  location: location
  name: name
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource storBlob 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: stor
  name: 'default'
}

resource storageAccountName_default_bacpacs 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storBlob
  name: 'bacpacs'
}
