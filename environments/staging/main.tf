module "vpc" {
  source   = "../../modules/vpc"
  name     = "staging"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

module "alb" {
  source = "../../modules/alb"
  name = var.name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source              = "../../modules/ecs"
  name                = var.name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  target_group_arn    = module.alb.target_group_arn
  ecs_execution_role_arn = module.ecs.ecs_execution_role_arn
  alb_security_group_id = module.alb.alb_security_group_id

}




