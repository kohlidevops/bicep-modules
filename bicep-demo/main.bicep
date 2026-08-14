targetScope = 'subscription'

param resourceGroupName string
param location string = 'centralus'
param tags object

module resourceGroupModule './modules/resourceGroup.bicep' = {
  name: 'createResourceGroup'
  scope: subscription()
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}
