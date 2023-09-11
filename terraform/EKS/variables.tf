variable "kubernetes_version" {
  type        = string
  default     = "1.27"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "local_exec_interpreter" {
  type        = list(string)
  default     = ["/bin/sh", "-c"]
  description = "shell to use for local_exec"
}

variable "oidc_provider_enabled" {
  type        = bool
  default     = true
  description = "Create an IAM OIDC identity provider for the cluster, then you can create IAM roles to associate with a service account in the cluster, instead of using `kiam` or `kube2iam`. For more information, see https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = ["audit", "controllerManager", "scheduler"]
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
}


variable "cluster_log_retention_period" {
  type        = number
  default     = 7
  description = "Number of days to retain cluster logs. Requires `enabled_cluster_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html."
}

variable "addons" {
  type = list(object({
    addon_name               = string
    addon_version            = string
    resolve_conflicts        = string
    service_account_role_arn = string
  }))
  default     = [{
    addon_name               = "vpc-cni"
    addon_version            = null
    resolve_conflicts        = "OVERWRITE" 
    service_account_role_arn = null
  },
  // https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html
  {
    addon_name               = "kube-proxy"
    addon_version            = null
    resolve_conflicts        = "OVERWRITE"
    service_account_role_arn = null
  },
  // https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html
  {
    addon_name               = "coredns"
    addon_version            = null
    resolve_conflicts        = "OVERWRITE"
    service_account_role_arn = null
  },
  {
    addon_name               = "aws-ebs-csi-driver"
    addon_version            = null
    resolve_conflicts        = "OVERWRITE"
    service_account_role_arn = null
  }
  ]
  description = "Manages [`aws_eks_addon`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) resources."
}

variable "apply_config_map_aws_auth" {
  type        = bool
  default     = true
  description = "Whether to apply the ConfigMap to allow worker nodes to join the EKS cluster and allow additional users, accounts and roles to acces the cluster"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided"
}


variable "desired_size" {
  type        = number
  default = 4
  description = "Desired number of worker nodes"
}

variable "max_size" {
  type        = number
  default = 5
  description = "The maximum size of the AutoScaling Group"
}

variable "min_size" {
  type        = number
  default = 4
  description = "The minimum size of the AutoScaling Group"
}