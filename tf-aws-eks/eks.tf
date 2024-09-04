module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  eks_managed_node_groups = {
    default_node_group = {
      name         = "jylee-eks-node-group"
      disk_size              = 10  
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.small"]
      ami_type = "AL2_x86_64"
       tags = {
        "k8s.io/cluster-autoscaler/enabled" : "true"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" : "true"
      }
    } 
  }  
}