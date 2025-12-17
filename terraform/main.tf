module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  azs      = var.azs
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

module "iam" {
  source = "./modules/iam"
}
