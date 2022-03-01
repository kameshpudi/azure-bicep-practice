@secure()ssh
@description('The name of the environment. This must be dev, test, or prod.')
@allowed([
  'dev'
  'test'
  'prod'
])
@minLength(3)
@maxLength(30)
param environmentName string = 'dev'
param namePrefix string
param sku string ='B1'
param resourceTags object = {
  EnvironmentName: 'Test'
  CostCenter: '1000100'
  Team: 'Human Resources'
}

resource appPlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: '${namePrefix}kkappPlan'
  location: resourceGroup().location
  tags: resourceTags
  kind: 'linux'
  sku:{
    name: sku
  }
  properties:{
    reserved: true
  }
}

output planID string = appPlan.id
