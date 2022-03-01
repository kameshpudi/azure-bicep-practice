@description('Specifies the location for resources.')
param location string = resourceGroup().location
param appServiceName string = 'toy-product-launch-1-kk'
var appServicePlanName = 'toy-product-launch-plan-starter-kk'

@allowed([
  'prod'
  'nonprod'
])
param environmentType string
var storageAccountSKU = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'toylaunchstoragekk'
  location: location
  sku: {
    name: storageAccountSKU
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceAppId string = appServiceApp.id


