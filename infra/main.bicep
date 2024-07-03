@description('Name of the database')
param databaseName string
@description('Password for the sqladmin user')
@secure()
param saPassword string


@allowed([
  'new'
  'existing'
])
param newOrExistingServer string = 'new'
@description('Name of the server')
param serverName string

param dbDacpacUrl string = 'https://bramplouvier.github.io/azure-sql-wwi/WideWorldImporters.dacpac'
param masterDacpacUrl string = 'https://bramplouvier.github.io/azure-sql-wwi/master.dacpac'

var location = resourceGroup().location

module manid 'manid.bicep' = {
  name: 'manid'
  params: {
    location: location
    name: 'manid-sqlaadadmin'
  }
}

module storage 'storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    name: 'stor${databaseName}'
  }
}

var ownerRole = '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
var contributorRole = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
module role 'roleAssignments.bicep' = {
  name: 'roleassign'
  params: {
    principalId: manid.outputs.uamidPrincipalId
    roles: [ownerRole, contributorRole]
    principalType: 'ServicePrincipal'
  }
}

resource existingSqlServer 'Microsoft.Sql/servers@2022-05-01-preview' existing = if (newOrExistingServer == 'existing'){
  name: serverName
}

module sqlserver 'sqlserver.bicep' = if (newOrExistingServer == 'new') {
  name: 'sqlserver'
  params: {
    location: location
    name: serverName
    saPassword: saPassword
    administratorPrincipalType: 'Application'
    administratorPrincipalId: manid.outputs.uamidClientId
  }
}

module database 'database.bicep' = {
  name: 'wwiDatabase'
  params: {
    databaseName: 'wwi'
    databaseSku: 'S3'
    location: location
    serverName: serverName
  }
  dependsOn: [sqlserver, existingSqlServer]
}

module dbDeployment 'deploymentScript.bicep' = {
  name: 'dbdeploy'
  params: {
    location: location
    name: '${databaseName}Deploy'
    saPassword: saPassword
    sqlServerName: serverName
    databaseName: databaseName
    storageAccountName: 'stor${databaseName}'
    userAssignedIdentityName: 'manid-sqlaadadmin'
    dbDacpacUrl: dbDacpacUrl
    masterDacpacUrl: masterDacpacUrl
  }
  dependsOn: [database]
}
 
