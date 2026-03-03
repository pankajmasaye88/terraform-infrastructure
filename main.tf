module "pankaj_vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "18.0.0.0/16"
  public_subnet_cidr  = "18.0.0.0/24"
  private_subnet_cidr = "18.0.1.0/24"
}

module "pankaj_keypair" {
  source          = "./modules/keypair"
  key_name        = var.key_pair_name
  public_key_path = var.public_key_path
}

module "pankaj_security" {
  source = "./modules/security"
  vpc_id = module.pankaj_vpc.vpc_id
}

module "pankaj_ec2" {
  source            = "./modules/ec2"
  public_subnet_id  = module.pankaj_vpc.public_subnet_id
  private_subnet_id = module.pankaj_vpc.private_subnet_id
  key_name          = module.pankaj_keypair.key_name
  sg_id             = module.pankaj_security.sg_id
  instance_type     = var.instance_type
}
