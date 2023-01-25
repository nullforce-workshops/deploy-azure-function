# deploy-azure-function

This repository deploys a .NET function app to Azure via GitHub Actions.

Additionally:
* An Azure Service Principal is used
* An Azure ARM Bicep template is used to create the function app

## GitHub Repository Settings

* Create an `AZURE_CREDENTIALS` secret in the repo and set it to the value of your Azure Security Principal
* Optionally, set a **wait timer** environment protection rule for the `Clean` environment. This will cleanup the resource group after the time passes.

## Executing the example function

https://{hostname}/api/HelloWorld?name=MyName
