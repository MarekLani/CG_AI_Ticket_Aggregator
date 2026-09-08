variable "participant_id" {
  type        = string
  description = "Short unique participant identifier assigned by the trainer."

  validation {
    condition     = can(regex("^[a-z0-9-]{2,12}$", var.participant_id))
    error_message = "participant_id must contain only lowercase letters, digits, or hyphens and be 2-12 characters long."
  }
}

variable "location" {
  type        = string
  description = "Azure region used by the training resources."
  default     = "westeurope"
}
