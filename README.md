# bicep-modules

### Open Azure Cloud Shell

```
az login
```

### Upload the Files and Validate the Deployment

```
cd bicep-demo

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

