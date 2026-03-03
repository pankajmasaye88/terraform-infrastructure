module "alex_vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "18.0.0.0/16"
  public_subnet_cidr  = "18.0.0.0/24"
  private_subnet_cidr = "18.0.1.0/24"
}

module "alex_keypair" {
  source          = "./modules/keypair"
  key_name        = var.key_pair_name
  public_key_path = var.public_key_path
}

module "alex_security" {
  source = "./modules/security"
  vpc_id = module.alex_vpc.vpc_id
}

module "alex_ec2" {
  source            = "./modules/ec2"
  public_subnet_id  = module.alex_vpc.public_subnet_id
  private_subnet_id = module.alex_vpc.private_subnet_id
  key_name          = module.alex_keypair.key_name
  sg_id             = module.alex_security.sg_id
  instance_type     = var.instance_type
}
