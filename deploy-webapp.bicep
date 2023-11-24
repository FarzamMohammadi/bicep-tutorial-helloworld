@description('Azure resource deployment location.')
param location string = resourceGroup().location

@description('The text to replace the default subtitle with.')
param textToReplaceSubtileWithValue string = 'This is my default subtitle text. Boring, right?'

@description('Branch of the repository for deployment.')
param repositoryBranch string = 'main'

// App Service Plan Creation
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'myAppServicePlan'
  location: location
  sku: {
    name: 'F1'
  }
  kind: 'linux'
  properties: {
    reserved: false
  }
}

// Web App Creation
resource appService 'Microsoft.Web/sites@2020-12-01' = {
  name: 'this-is-a-unique-name-for-the-web-app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'NODE:20-lts'
      appSettings: [
        {
          name: 'TEXT_TO_REPLACE_SUBTITLE_WITH' // This value needs to match the name of the environment variable in the application code
          value: textToReplaceSubtileWithValue
        }
      ]
      publicNetworkAccess: 'Enabled'
    }
  }
}

// Source Control Integration
resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: appService
  name: 'web'
  properties: {
    repoUrl: 'https://github.com/FarzamMohammadi/hello-world'
    branch: repositoryBranch
    isManualIntegration: true
  }
}
