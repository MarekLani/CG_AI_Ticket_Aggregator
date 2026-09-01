# Deployment architecture

## Direction

The application will be containerized and deployed to Azure. Terraform will define the target infrastructure and GitHub Actions will perform validation and deployment.

## Deliberately undecided

The bootstrap does not choose a specific Azure compute service or full topology. The infrastructure issue must compare the minimal viable options against requirements such as networking to RM, authentication, cost, operational complexity and training value.

## Delivery progression

1. local developer execution;
2. first manual container build/run;
3. first intentionally simple Azure deployment to validate the runtime path;
4. Terraform representation of the approved Azure resources;
5. CI validation of application and Terraform;
6. controlled CD from GitHub Actions using federated identity rather than long-lived cloud credentials where supported;
7. incremental deployment as features are merged.
