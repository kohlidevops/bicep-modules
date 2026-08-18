# bicep-modules

### Open Azure Cloud Shell

```
az login
```

### Upload the Files and Validate the Deployment

#### Architecture

```
bicep-demo/

Resource Group (rg-demo-centralus)
│
├── Virtual Network (demo-vnet)
│   │
│   ├── Public Subnet (10.0.1.0/24)
│   │     ├── Network Security Group (demo-nsg)
│   │     └── Route Table (public-rt)
│   │
│   ├── App Subnet (10.0.2.0/24)
│   │     ├── Network Security Group (demo-nsg)
│   │     ├── Route Table (public-rt)
│   │     ├── NAT Gateway (demo-nat)
│   │     │     └── Public IP (nat-pip)
│   │     └── Ubuntu VM (app-vm01)
│   │           └── Network Interface (app-vm01-nic)
│   │
│   ├── DB Subnet (10.0.3.0/24)
│   │     └── Network Security Group (demo-nsg)
│   │
│   └── AzureBastionSubnet (10.0.10.0/26)
│         └── Azure Bastion (demo-bastion)
│               └── Public IP (demo-bastion-pip)
│
└── Tags
      ├── Environment = Dev
      └── Project = Demo
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
az bicep build --file main.bicep

az deployment sub validate \
    --location centralus \
    --template-file main.bicep \
    --parameters @main.parameters.json
```

### Deploy and Verify

```
az deployment sub create \
    --location centralus \
    --template-file main.bicep \
    --parameters @main.parameters.json

az group list --output table
```

#### VNET, NSG Architecture

```
                                      Azure Subscription
                                              │
                                              │
                                  Resource Group
                                 rg-demo-centralus
                                              │
 ┌────────────────────────────────────────────┼────────────────────────────────────────────┐
 │                                            │                                            │
 │                                   Network Security Group                               │
 │                                        demo-nsg                                        │
 │                                            │                                            │
 │                                    Route Table (UDR)                                   │
 │                                        public-rt                                       │
 │                                            │                                            │
 │                                    NAT Gateway                                          │
 │                                      demo-nat                                           │
 │                                            │                                             │
 │                                      Public IP                                           │
 │                                        nat-pip                                           │
 │
 │
 └────────────────────────────── Virtual Network ───────────────────────────────────────────
                                demo-vnet (10.0.0.0/16)

        ┌────────────────────────────┬────────────────────────────┬────────────────────────────┬────────────────────────────┐
        │                            │                            │                            │
        │                            │                            │                            │
 Public Subnet                 App Subnet                  DB Subnet               AzureBastionSubnet
 10.0.1.0/24                   10.0.2.0/24                10.0.3.0/24               10.0.10.0/26
        │                            │                            │                            │
        │                            │                            │                            │
      NSG                         NSG                         NSG                   Azure Bastion
        │                            │                                                      │
 Route Table                    Route Table                                               Public IP
        │                            │                                                      │
        │                      NAT Gateway                                                  │
        │                            │                                                      │
        │                       Ubuntu VM                                                   │
        │                     app-vm01 (Private IP)                                         │
        │                            ▲                                                      │
        └────────────────────────────┴──────────────────────────────────────────────────────┘
                                     Secure SSH via Bastion
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

### Delete the resource

```
az group delete \
  --name rg-demo-centralus \
  --yes \
  --no-wait
```
