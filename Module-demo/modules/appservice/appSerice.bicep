param location string
param appServiceAppName string
@allowed([
  'nonprod'
  'prod'
])
param environmentType string
var appServicePlanName = 'toy-product-launch-plan-starter-kk'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
