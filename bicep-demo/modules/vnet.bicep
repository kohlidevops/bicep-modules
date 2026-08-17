param vnetName string
param location string
param addressSpace string
param webSubnet string
param appSubnet string
param dbSubnet string
param webPrefix string
param appPrefix string
param dbPrefix string
param nsgId string
param routeTableId string
param natGatewayId string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01'={
 name:vnetName
 location:location
 properties:{
  addressSpace:{
   addressPrefixes:[addressSpace]
  }
  subnets:[
   {
    name:webSubnet
    properties:{
      addressPrefix:webPrefix
      networkSecurityGroup:{id:nsgId}
      routeTable:{id:routeTableId}
    }
   }
   {
    name:appSubnet
    properties:{
      addressPrefix:appPrefix
      networkSecurityGroup:{id:nsgId}
      natGateway:{id:natGatewayId}
    }
   }
   {
    name:dbSubnet
    properties:{
      addressPrefix:dbPrefix
      networkSecurityGroup:{id:nsgId}
    }
   }
  ]
 }
}
output vnetId string=vnet.id
