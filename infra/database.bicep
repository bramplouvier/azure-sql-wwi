param databaseName string
param location string
param serverName string
param databaseSku string

resource server 'Microsoft.Sql/servers@2023-05-01-preview' existing = {
  name: serverName
}

resource db 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  location: location
  name: databaseName
  parent: server
  sku: {
    name: databaseSku
  }
}
