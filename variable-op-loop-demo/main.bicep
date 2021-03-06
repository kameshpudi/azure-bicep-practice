@description('The Azure regions into which the resources should be deployed.')
param locations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

@description('The IP address range for all virtual networks to use.')
param virtualNetworkAddressPrefix string = '10.10.0.0/16'

@description('The name and IP address range for each subnet in the virtual networks.')
param subnets array = [
  {
    name: 'frontend'
    ipAddressRange: '10.10.5.0/24'
  }
  {
    name: 'backend'
    ipAddressRange: '10.10.10.0/24'
  }
]

var subnetProperties = [for subnet in subnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2020-11-01' = [for location in locations: {
  name: 'teddybear-${location}'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        virtualNetworkAddressPrefix
      ]
    }
    subnets: subnetProperties
  }
}]

output serverInfo array = [for i in range(0, length(locations)): {
  name: virtualNetworks[i].name
  location: virtualNetworks[i].location
  fullyQualifiedDomainName: virtualNetworks[i].id
}]
