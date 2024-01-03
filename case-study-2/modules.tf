module "vpc" {
  source   = "./modules/network"
  vpc_cidr = "10.10.0.0/16"
}

module "server" {
  source             = "./modules/instance"
  subnet-ids         = module.vpc.subnet_ids[0]
  security_group_ids = module.server.security_group_id
  vpc_id             = module.vpc.vpc_id
}

module "apache" {
  source            = "./modules/application"
  public_subnets    = module.vpc.public_subnets
  private_subnets   = module.vpc.private_subnets
  security_group_id = module.server.security_group_id
  vpc_id            = module.vpc.vpc_id
}