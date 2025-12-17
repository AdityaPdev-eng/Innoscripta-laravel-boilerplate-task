output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "iam_user" {
  value = module.iam.iam_user_name
}
