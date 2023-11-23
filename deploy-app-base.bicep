resource symbolicname 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'string'
  location: 'string'
  properties: {
    reserved: bool
  }
  sku: {
    name: 'string'
  }
  kind: 'string'
}

resource appService 'Microsoft.Web/sites@2020-12-01' = {
  name: 'string'
  location: 'string'
  kind: 'string'
  properties: {
    serverFarmId: 'string'
    httpsOnly: bool
    siteConfig: {
      appSettings: [
        {
          name: 'string'
          value: 'string'
        }
      ]
      publicNetworkAccess: bool
    }
  }
}

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: 'string'
  name: 'string'
  properties: {
    repoUrl: 'string'
    branch: 'string'
    isManualIntegration: bool
  }
}
