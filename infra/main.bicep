@description('Name of the database')
param name string
@description('Password for the sqladmin user')
@secure()
param saPassword string

param bacpacUrl string = 'https://github.com/bramplouvier/azure-sql-wwi/releases/download/v0.0.1/WideWorldImporters.dacpac'

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
    name: 'stor${name}'
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

module sqlserver 'sqlserver.bicep' = {
  name: 'sqlserver'
  params: {
    location: location
    name: name
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
    serverName: name
  }
}

module dbDeployment 'deploymentScript.bicep' = {
  name: 'dbdeploy'
  params: {
    location: location
    name: '${name}Deploy'
    saPassword: saPassword
    sqlServerName: name
    storageAccountName: 'stor${name}'
    userAssignedIdentityName: 'manid-sqlaadadmin'
    bacpacUrl: bacpacUrl
  }
  dependsOn: [database]
}
 
