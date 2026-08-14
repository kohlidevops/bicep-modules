# bicep-modules

### Open Azure Cloud Shell

```
az login
```

### Upload the Files and Validate the Deployment

#### Architecture

```
bicep-demo/
│
├── main.bicep
├── main.parameters.json
└── modules/
      ├── resourceGroup.bicep
      ├── vnet.bicep
      └── nsg.bicep
```

#### Create modules/resourceGroup.bicep

```
mkdir bicep-demo
mkdir bicep-demo/modules
nano bicep-demo/resourceGroup.bicep
```

#### Create main.bicep

```
nano main.bicep
```

#### Create main.parameters.json

```
nano main.parameters.json
```

### Validate the Deployment

```
az deployment sub validate \
    --location centralus \
    --template-file main.bicep \
    --parameters @main.parameters.json
```

### Deploy and Verify

```
az deployment sub create \
    --name create-rg-demo \
    --location centralus \
    --template-file main.bicep \
    --parameters @main.parameters.json

az group list --output table
```

#### VNET, NSG Architecture

```
bicep-demo/
│
├── main.bicep
├── main.parameters.json
└── modules/
      ├── resourceGroup.bicep
      ├── vnet.bicep
      └── nsg.bicep
```

#### Create modules/nsg.bicep

```
nano modules/nsg.bicep
```

#### Create modules/vnet.bicep

```
nano modules/vnet.bicep
```

#### Update main.bicep

```
nano main.bicep
```

#### Update main.parameters.json

```
nano main.parameters.json
```

### Deploy and Validate

```
az deployment sub create \
    --location centralus \
    --template-file main.bicep \
    --parameters @main.parameters.json
```
