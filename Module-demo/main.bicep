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

module appService 'modules/appservice/appSerice.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceName
    environmentType: environmentType
  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
