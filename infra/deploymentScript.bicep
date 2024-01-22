param name string
param location string
@secure()
param saPassword string
param storageAccountName string
param sqlServerName string
param userAssignedIdentityName string
param resourceGroupName string = resourceGroup().name
param databaseName string = 'wwi'
param bacpacUrl string = 'https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Standard.bacpac'
param timestamp string = utcNow()
var identity = resourceId('Microsoft.ManagedIdentity/userAssignedIdentities/', userAssignedIdentityName)

resource stor 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

var storageAccountKey = stor.listKeys().keys[0].value

resource script 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  kind: 'AzureCLI'
  location: location
  name: name
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identity}': {}
    }
  }
  properties: {
    azCliVersion: '2.9.1'
    retentionInterval: 'PT1H'
    environmentVariables: [
      {
        name: 'administratorLogin'
        value: 'sqladmin'
      }
      {
        name: 'administratorLoginPassword'
        secureValue: saPassword
      }
      {
        name: 'storageAccountName'
        value: storageAccountName
      }
      {
        name: 'sqlServerName'
        value: sqlServerName
      }
      {
        name: 'resourceGroup'
        value: resourceGroupName
      }    
      {
        name: 'databaseName'
        value: databaseName
      }   
      {
        name: 'bacpacUrl'
        value: bacpacUrl
      }                                                         
    ]
    //primaryScriptUri: 'https://raw.githubusercontent.com/bramplouvier/azure-sql-wwi/main/infra/setupDatabase.sh'
    scriptContent: loadTextContent('./setupDatabase.sh', 'utf-8')
    forceUpdateTag: timestamp
    cleanupPreference: 'OnSuccess'
    storageAccountSettings: {
      storageAccountName: storageAccountName
      storageAccountKey: storageAccountKey
    }
  }
}
