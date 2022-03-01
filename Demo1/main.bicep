targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01'={
  name: 'kkappPaln-bicep-rg'
  location: deployment().location
}

module storageDeploy 'storage.bicep' = {
  name:'appPlanDeploy'
  scope: rg
  params:{
    namePrefix: 'kkbicep'
    
  }
}
// module appPlanDeploy 'appPlan.bicep' = {
//   name:'appPlanDeploy'
//   scope: rg
//   params:{
//     namePrefix: 'kkbicep'
    
//   }
// }

// var websites= [
//   {
//     name: 'fancy'
//     tag: 'latest'
//   }
//   {
//     name: 'plain'
//     tag: 'plain-text'
//   }
// ]
// module siteDeploy 'site.bicep' = [for site in websites:{
//   name:'${site.name}siteDeploy'
//   scope: rg
//   params:{
//     appPlanId: appPlanDeploy.outputs.planID
//     namePrefix: site.name
//     dockerImage: 'nginixdemos/hello'
//     dockerImageTag: site.tag
    
//   }
// }]

output planID string = storageDeploy.outputs.storageAccountId
