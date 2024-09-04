module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr 
  azs = var.azs
  public_subnets  = [for index in range(2):cidrsubnet(var.vpc_cidr, 8, index+1)]
  private_subnets = [for index in range(2):cidrsubnet(var.vpc_cidr, 8, index+11)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
