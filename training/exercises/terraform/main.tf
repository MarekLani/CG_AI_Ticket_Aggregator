# Training exercise scaffold
#
# Intentionally incomplete: participants write the first Azure resource blocks
# themselves during the lab. Follow README.md and the Terraform presentation.
#
# TODO 1: Create an azurerm_resource_group named:
#         rg-tf-lab-${var.participant_id}
#         Use var.location and add a training-purpose tag.
#
# TODO 2: Create an azurerm_container_group in that resource group.
#         Requirements:
#         - unique name derived from var.participant_id
#         - Linux
#         - public IP
#         - image: mcr.microsoft.com/azuredocs/aci-helloworld
#         - port 80/TCP
#         - small training CPU/memory allocation
#         - use references to the resource group instead of duplicating values
#
# TODO 3: After the first successful deployment, add one harmless participant
#         tag and use terraform plan to observe the in-place change.
