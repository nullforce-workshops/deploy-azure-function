param functionAppName string = 'nfexamplefuncapp'
param location string = resourceGroup().location

var storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${funcappstorage.name};AccountKey=${listKeys(funcappstorage.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'

resource hostingPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'nfexampleplan'
  location: location
  tags: {
    'nf-app-type': 'Example'
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource funcappstorage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'nfexamplefuncappstorage'
  kind: 'StorageV2'
  location: location
  tags: {
    'nf-app-type': 'Example'
  }
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

resource funcappwebconfig 'Microsoft.Web/sites/config@2021-03-01' = {
  name: 'web'
  parent: funcapp
  properties: {
    netFrameworkVersion: 'v6.0'
  }
}

resource funcappsettings 'Microsoft.Web/sites/config@2021-03-01' = {
  name: 'appsettings'
  parent: funcapp
  properties: {
    AzureWebJobsStorage: storageAccountConnectionString
    FUNCTIONS_EXTENSION_VERSION: '~4'
    FUNCTIONS_WORKER_RUNTIME: 'dotnet'
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: storageAccountConnectionString
    WEBSITE_CONTENTSHARE: '${toLower(functionAppName)}876f'
  }
}

resource funcapp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  kind: 'functionapp'
  location: location
  tags: {
    'nf-app-type': 'Example'
  }
  properties: {
    httpsOnly: true
    serverFarmId: hostingPlan.id
  }
}

output functionAppUrl string = 'https://${funcapp.properties.defaultHostName}'
