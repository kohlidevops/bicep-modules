targetScope = 'subscription'

param resourceGroupName string
param location string
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

module rg './modules/resourceGroup.bicep' = {
  name: 'createRG'

  scope: subscription()

  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

module nsg './modules/nsg.bicep' = {
  name: 'createNSG'

  scope: resourceGroup(resourceGroupName)

  dependsOn: [
    rg
  ]

  params: {
    nsgName: nsgName
    location: location
  }
}

module vnet './modules/vnet.bicep' = {
  name: 'createVnet'

  scope: resourceGroup(resourceGroupName)

  dependsOn: [
    nsg
  ]

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
  }
}
