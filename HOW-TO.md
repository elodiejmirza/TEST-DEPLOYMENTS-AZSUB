Setup for Terraform Cloud

1 - Service Principals
Create a service principal for each subscription.

Using AZ CLI:
az ad sp create-for-rbac --name sp-tf-<subscription name>-contrubutor --role Contributor --scopes /subscriptions/<subscription id>

Command output wiill be something like this:
    "appId": "17c94ae8-fab0-4c4f-aa5e-fe2afd7aa18d",    #The addId will be unique for each service principal
    "displayName": "sp-tf-test-deployments-contrubutor",
    "password": "<REDACTED>",
    "tenant": "ee196bdf-8fe9-40c3-8d53-10712d6eb71b"

2 - Create Variable Set in Terraform Cloud

Create them in the settings for the organsation.
Use these variable names:
$env:ARM_CLIENT_ID for "appId"
$env:ARM_SUBSCRIPTION_ID for the azure subscription ID that you want to deploy to
$env:ARM_TENANT_ID for "tenant"
ARM_CLIENT_SECRET for "password"


Ensure that you use the Environemnt variable type and set the sensitive flag on for the ARM_CLIENT_SECRET variable
