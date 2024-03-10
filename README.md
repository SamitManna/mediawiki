# Mediawiki

## Prerequisites
To perform all steps below you will need to have the following in place:

- Access to a [Azure Account](https://azure.microsoft.com/en-in/free) with role `Global Administrator`
- Terraform `1.7.4` or newer installed
- Kubectl installed
- Azure CLI `2.58.0` or newer installed
- Azure `subscription id`
- Ubuntu VM for Github Actions self-hosted runner
- Github [Personal Access Token](https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

# Bootstraping

## Step 1: Provision backend with bootstraping
### 1.1. Azure login

- Clone github repo
- Login to Azure CLI `az login` or open Azure Cloud Shell

## 1.2 Initialise the Terraform

```shell
cd mediawiki/bootstrap
# change location value in variables.tf file
terraform init
```

## 1.3 Plan the bootstrap

```shell
terraform plan
```

## 1.4 Apply the bootstrap

```shell
terraform apply
````

# Infrastructure Provisioning with Terraform & Github Actions

## Step 1: Create Azure Service Prinipal
- Login to Azure CLI `az login` or open Azure Cloud Shell
- Run the following command to create a new service principal
```
az ad sp create-for-rbac --name "myServicePrincipal" --role contributor --scopes /subscriptions/{subscription-id} --sdk-auth
```
- The command will output a JSON object containing the service principal's credentials, including the clientId and clientSecret. Save these values as you'll need them in the next step

## Step 2: Insttal Github Actions self-hosted runner if not avaulable already
- Add [self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners)
- Configure [self-hosted runner as service](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service)
- Install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Install [az cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)

> **BETTER WAY TO DO THIS:**  Create docker image with all cli installed and use the docker image in Github Actions to run the job on container

## Step 3: Configure your first environment

### 3.1. Create Environment

Github Environments are used to configure Vnet and AKS cluster deployment in a specific region. The name of the environment will be used as the `resource_prefix` for all resources in the account.
An environment requires the following variables and secrets at a minimum:

| Variable               | Description                                         | Example                                |
|------------------------|-----------------------------------------------------|----------------------------------------|
| `LOCATION`           | The Azure Region to deploy the Vent and AKS cluster to | `EAST US`                            |

| Secret               | Description                                         | Example                                |
|------------------------|-----------------------------------------------------|----------------------------------------|
| `ARM_CLIENT_ID`           | Client Id obtained at step 1 | `XXXXXXXXX`                            |
| `ARM_CLIENT_SECRET`           | Client Secret obtained at step 1 | `XXXXXXXXX`                            |
| `ARM_SUBSCRIPTION_ID`           | Azure subcription id | `XXXXXXXXX`                            |
| `ARM_TENANT_ID`           | Tentant Id obtained at step 1 | `XXXXXXXXX`                            |

> **BETTER WAY TO DO THIS:**  Configure a Federated Identity Credential in Azure allowing Github to Authenticate with OIDC and access Azure Resources.

### 3.2. Trigger workflow

Trigger the `Apply Cluster with Vnet` workflow. Input the name of the `environment` (e.g. `dev`) you just created. After about 5 minutes you should have a fully functional AKS cluster within its own Vnet.

# Application Deployment


4. CI/CD Pipeline (Optional):

5. Monitoring and Logging:

6. Security and Networking:

7. High Availability and Scalability:

8. Scaling Considerations (Optional):

9. Create docker image
