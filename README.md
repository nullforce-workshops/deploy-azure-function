# deploy-azure-function

This repository deploys a .NET function app to Azure via GitHub Actions.

Additionally:
* An Azure Service Principal is used
* An Azure ARM Bicep template is used to create the function app

## Executing the example function

https://{hostname}/api/HelloWorld?name=MyName
