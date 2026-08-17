targetScope = 'subscription'

param resourceGroupName string
param location string = 'centralus'
param tags object

param vnetName string
param addressSpace string

param webSubnet string
param appSubnet string
param dbSubnet string

param webPrefix string
param appPrefix string
param dbPrefix string

param nsgName string
param routeTableName string
param publicIpName string
param natGatewayName string

// Resource Group
module rg './modules/resourceGroup.bicep' = {
  name: 'createRG'

  scope: subscription()

  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

// Network Security Group
module nsg './modules/nsg.bicep' = {
  name: 'createNSG'

  scope: resourceGroup(resourceGroupName)

  params: {
    nsgName: nsgName
    location: location
  }
}

// Route Table
module rt './modules/routeTable.bicep' = {
  name: 'createRouteTable'

  scope: resourceGroup(resourceGroupName)

  params: {
    routeTableName: routeTableName
    location: location
  }
}

// Public IP
module pip './modules/publicIp.bicep' = {
  name: 'createPublicIP'

  scope: resourceGroup(resourceGroupName)

  params: {
    publicIpName: publicIpName
    location: location
  }
}

// NAT Gateway
module nat './modules/natGateway.bicep' = {
  name: 'createNatGateway'

  scope: resourceGroup(resourceGroupName)

  params: {
    natGatewayName: natGatewayName
    location: location
    publicIpId: pip.outputs.publicIpId
  }
}

// Virtual Network
module vnet './modules/vnet.bicep' = {
  name: 'createVNet'

  scope: resourceGroup(resourceGroupName)

  params: {
    vnetName: vnetName
    location: location

    addressSpace: addressSpace

    webSubnet: webSubnet
    appSubnet: appSubnet
    dbSubnet: dbSubnet

    webPrefix: webPrefix
    appPrefix: appPrefix
    dbPrefix: dbPrefix

    nsgId: nsg.outputs.nsgId
    routeTableId: rt.outputs.routeTableId
    natGatewayId: nat.outputs.natGatewayId
  }
}
