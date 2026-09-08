# Terraform — first Azure hands-on exercise

## Goal

In roughly 35–45 minutes you will:

1. write a small Terraform configuration yourself;
2. deploy a real disposable workload to Azure in your own training resource group;
3. inspect how Terraform uses a **local state file**;
4. make one controlled change and read the plan;
5. migrate the same state to a trainer-provided **Azure Blob backend**;
6. initialize the same infrastructure from a clean working directory to demonstrate how another developer or a pipeline can reuse the shared state;
7. destroy your temporary resources through Terraform.

This folder is deliberately a **starter workbook, not a finished Azure solution**. The exercise is intended to make you write and understand the first resource blocks yourself. Production Terraform for Unified Work Items belongs in the separate infrastructure repository defined by ADR 0001.

## Prerequisites

Everyone needs:

- Terraform installed;
- a short participant ID assigned by the trainer, for example `m01`;
- the trainer-provided training Azure subscription ID;
- the trainer-provided Terraform state Storage Account name;
- permission to create and delete the lab resources in the designated Azure scope;
- Blob data-plane access to the shared `tfstate` container.

The lab supports **two authentication options**. The trainer can choose one option for the whole group or mix them if needed.

---

# Authentication — choose one option

## Option A — your own Microsoft Entra account

Use this option when you have direct access to the training Azure subscription with your own account.

You need Azure CLI installed. Authenticate and select the training subscription:

```bash
terraform version
az version
az login
az account set --subscription "<TRAINING_SUBSCRIPTION_ID_OR_NAME>"
az account show
```

Terraform then uses your current Azure CLI / Microsoft Entra identity for both:

- the `azurerm` provider that creates the resource group and Azure Container Instance;
- the Azure Blob state backend after Part 2.

For the remote state part, use `backend.user.hcl.example`, which contains:

```hcl
use_cli          = true
use_azuread_auth = true
```

The trainer should grant your account the required Azure resource permissions for the lab and `Storage Blob Data Contributor` on the shared state container.

## Option B — trainer-provided training service principal

Use this option when you do **not** have direct Azure access with your own account.

The trainer provides a short-lived training service principal with these four values:

- tenant ID;
- subscription ID;
- client ID;
- client secret.

Set them as environment variables before running Terraform.

### Bash / zsh

```bash
export ARM_TENANT_ID="<TRAINER_PROVIDED>"
export ARM_SUBSCRIPTION_ID="<TRAINER_PROVIDED>"
export ARM_CLIENT_ID="<TRAINER_PROVIDED>"
export ARM_CLIENT_SECRET="<TRAINER_PROVIDED>"
```

### PowerShell

```powershell
$env:ARM_TENANT_ID = "<TRAINER_PROVIDED>"
$env:ARM_SUBSCRIPTION_ID = "<TRAINER_PROVIDED>"
$env:ARM_CLIENT_ID = "<TRAINER_PROVIDED>"
$env:ARM_CLIENT_SECRET = "<TRAINER_PROVIDED>"
```

The same `ARM_*` credentials authenticate both the `azurerm` provider and the Azure Blob state backend. You do not need to put credentials into the `.tf` files.

For the remote state part, use `backend.service-principal.hcl.example`. The file contains only the backend mode and state location; the tenant/client/secret values are read from the environment.

**Never put `ARM_CLIENT_SECRET` into `backend.hcl`, Terraform files, Git, chat, screenshots or shell history that will be shared.** The service principal is a practical fallback for this short-lived classroom exercise. For real CI/CD, use workload identity / OIDC rather than distributing a long-lived client secret.

If one shared service principal is used by the whole class, all participants effectively have the same Azure permissions. The unique participant IDs, resource-group names and state keys provide organizational separation, **not security isolation**.

The trainer should rotate/revoke the shared credential after the workshop and grant the service principal only the permissions needed for the designated training scope plus `Storage Blob Data Contributor` on the state container.

---

## Starter files

This folder contains:

- `versions.tf` — Terraform/AzureRM version and provider baseline;
- `variables.tf` — participant and location inputs;
- `main.tf` — TODO checklist for the resources you will create;
- `outputs.tf` — TODO for a useful deployment output;
- `terraform.tfvars.example` — copy to `terraform.tfvars` and set your participant ID;
- `backend.tf.example` — enable only when the exercise moves from local state to remote state;
- `backend.user.hcl.example` — Azure CLI / participant-account backend configuration;
- `backend.service-principal.hcl.example` — trainer-provided service-principal backend configuration.

The repository already ignores Terraform state, `.terraform/`, saved plans and other local Terraform artifacts.

---

# Part 1 — create a personal Azure sandbox

Copy the variable example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

On PowerShell you can use:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Set your assigned `participant_id` in `terraform.tfvars`.

Your Terraform configuration should create exactly two Azure resources:

### A. Resource group

Create an `azurerm_resource_group` with:

- name: `rg-tf-lab-<participant_id>`;
- location: `var.location`;
- a tag such as `purpose = "terraform-training"`.

### B. Azure Container Instance

Create an `azurerm_container_group` in that resource group with:

- a unique name based on your participant ID;
- Linux as the OS type;
- a public IP address;
- one container using `mcr.microsoft.com/azuredocs/aci-helloworld`;
- port `80/TCP` exposed;
- small training CPU/memory values, for example `0.5` CPU and `1.5` GB memory;
- the same training-purpose tag.

Use Terraform references instead of repeating the resource-group name or location manually.

### C. Output

Add an output that prints the public IP address of the container group after deployment.

## First Terraform workflow

Make sure you have completed **Option A or Option B authentication** above, then run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan -out tfplan
```

Before applying, read the plan. You should expect Terraform to create your resource group and container group, and nothing outside your participant-specific sandbox.

Then apply the saved plan:

```bash
terraform apply tfplan
terraform output
```

Open the public IP from the output in your browser. You should see the hello-world page served from Azure Container Instances.

## Inspect local state

At this point Terraform uses local state. Confirm that `terraform.tfstate` exists in the exercise folder.

Useful commands:

```bash
terraform state list
terraform show
```

Do **not** edit the state JSON manually.

Discuss: what information does Terraform need the state for, and why would a state file stored only on your laptop be a problem for a team?

## Make one controlled change

Change one harmless tag value in the configuration, for example add:

```text
participant = <your participant id>
```

Then run:

```bash
terraform plan
terraform apply
```

Read the plan before applying it. The expected result is an in-place metadata change rather than recreation of the whole environment.

---

# Part 2 — migrate local state to Azure Blob Storage

The trainer creates the shared backend infrastructure ahead of the lab. Participants do **not** create or destroy the shared state Storage Account.

Each participant gets a different blob key:

```text
training/<participant_id>.tfstate
```

The identity used for state access depends on the authentication option selected earlier:

- **Option A:** your Azure CLI / Microsoft Entra user identity;
- **Option B:** the trainer-provided service principal from the `ARM_*` environment variables.

## Enable the backend block

First copy the backend block:

```bash
cp backend.tf.example backend.tf
```

PowerShell:

```powershell
Copy-Item backend.tf.example backend.tf
```

Then copy the backend configuration matching your authentication option.

### Option A — participant account / Azure CLI

```bash
cp backend.user.hcl.example backend.hcl
```

PowerShell:

```powershell
Copy-Item backend.user.hcl.example backend.hcl
```

### Option B — training service principal

```bash
cp backend.service-principal.hcl.example backend.hcl
```

PowerShell:

```powershell
Copy-Item backend.service-principal.hcl.example backend.hcl
```

Edit `backend.hcl` and set:

- `storage_account_name` to the value supplied by the trainer;
- `key` to `training/<your participant id>.tfstate`.

Do not put credentials, account keys or client secrets in this file.

## Migrate the existing state

Run:

```bash
terraform init -migrate-state -backend-config=backend.hcl
```

Terraform should ask to migrate the existing local state to the configured Azure backend. Read the prompt and confirm the migration.

Then verify:

```bash
terraform state list
terraform plan
```

The expected plan is **no infrastructure changes**. The Azure resources did not move; only Terraform's state storage moved from your local file to the shared backend.

---

# Part 3 — prove another working directory can reuse the state

Use a clean copy/checkout of this exercise folder, representing another developer or later a CI/CD runner.

In the clean folder:

1. recreate your `terraform.tfvars` with the **same** participant ID;
2. copy `backend.tf.example` to `backend.tf`;
3. copy the same authentication-specific backend example you used earlier to `backend.hcl` and configure the **same** Storage Account and blob key;
4. use the same authentication method as the first working directory;
5. ensure the `.tf` resource configuration is the same as in your first folder;
6. run:

```bash
terraform init -backend-config=backend.hcl
terraform plan
```

Expected result: Terraform discovers the existing state from Azure Blob Storage and does **not** propose creating another copy of your resource group or container group.

## Optional collaboration demonstration

In the second working directory, make one harmless tag change and apply it. Return to the first working directory and run:

```bash
terraform plan
```

Both directories now operate on the same remote state. This is the basic collaboration model that can later be used by CI/CD with workload identity rather than a developer's interactive Azure CLI session or a distributed training secret.

Azure Blob-backed Terraform state also supports state locking, which protects against two writers changing the same state concurrently.

---

# Cleanup

Run cleanup **while still configured to use the remote backend**:

```bash
terraform plan -destroy
terraform destroy
```

Confirm in Azure that your personal `rg-tf-lab-<participant_id>` resource group is gone.

Do **not** delete the shared state Storage Account or `tfstate` container; they are trainer-owned lab infrastructure.

If you used the shared service principal, remove the secret from your shell after the lab.

### Bash / zsh

```bash
unset ARM_CLIENT_SECRET
unset ARM_CLIENT_ID
unset ARM_TENANT_ID
unset ARM_SUBSCRIPTION_ID
```

### PowerShell

```powershell
Remove-Item Env:ARM_CLIENT_SECRET -ErrorAction SilentlyContinue
Remove-Item Env:ARM_CLIENT_ID -ErrorAction SilentlyContinue
Remove-Item Env:ARM_TENANT_ID -ErrorAction SilentlyContinue
Remove-Item Env:ARM_SUBSCRIPTION_ID -ErrorAction SilentlyContinue
```

## Discussion

Be ready to explain:

- which identity Terraform used to authenticate to Azure;
- what Terraform state represents;
- why local state is acceptable for this first isolated step but unsuitable for shared infrastructure;
- what changed when the state was migrated to Azure Blob Storage;
- why the clean working directory did not recreate the resources;
- how the same pattern can be used by GitHub Actions or another CI/CD runner;
- why state access and service-principal credentials should be tightly controlled.
