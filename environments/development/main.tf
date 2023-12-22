# Configuración del módulo VPC
module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = "10.0.0.0/16"
  environment = "development"
}

# Configuración del módulo Subnets
/* module "subnets" {
  source              = "../../modules/subnet"
  vpc_id              = module.vpc.vpc_id
  subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  environment         = "development"
} */


module "public_subnet" {
  source             = "../../modules/public_subnet"
  vpc_id             = module.vpc.vpc_id
  subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  environment        = "development"
}


module "security_group" {
  source      = "../../modules/security_group"
  vpc_id      = module.vpc.vpc_id
  environment = "development"
}

# Configuración del módulo EC2 Instances
module "ec2_instances" {
  source        = "../../modules/ec2_instances"
  ami_id        = "ami-00b8917ae86a424c9"  # Reemplazar con el AMI real
  instance_type = "t2.micro"
  subnet_ids    = module.public_subnet.subnet_ids
  security_group_id  = module.security_group.security_group_id
  environment   = "development"
}
