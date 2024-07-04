param name string
param location string
@secure()
param saPassword string
param sqlServerName string
param userAssignedIdentityName string
param resourceGroupName string = resourceGroup().name
param databaseName string
param dbDacpacUrl string
param masterDacpacUrl string
param timestamp string = utcNow()
var identity = resourceId('Microsoft.ManagedIdentity/userAssignedIdentities/', userAssignedIdentityName)

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
    azCliVersion: '2.61.0'
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
     // {
     //   name: 'storageAccountName'
     //   value: storageAccountName
     // }
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
        name: 'dbDacpacUrl'
        value: dbDacpacUrl
      }                                                         
      {
        name: 'masterDacpacUrl'
        value: masterDacpacUrl
      }     
    ]
    scriptContent: loadTextContent('./setupDatabase.sh', 'utf-8')
    forceUpdateTag: timestamp
    cleanupPreference: 'OnSuccess'
  }
}
