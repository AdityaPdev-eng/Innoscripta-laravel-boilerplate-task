resource "aws_iam_user" "eks_ecr_user" {
  name = "eks-ecr-evaluator"
}

resource "aws_iam_user_policy_attachment" "eks" {
  user       = aws_iam_user.eks_ecr_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFullAccess"
}

resource "aws_iam_user_policy_attachment" "ecr" {
  user       = aws_iam_user.eks_ecr_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
