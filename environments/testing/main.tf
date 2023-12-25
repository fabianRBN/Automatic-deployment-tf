# Configuración del módulo VPC
module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = "10.0.0.0/16"
  environment = "development"
}
module "internet_gateway" {
  source      = "../../modules/internet_gateway"
  vpc_id      = module.vpc.vpc_id
  environment = "development"
}

module "route_table" {
  source                 = "../../modules/route_table"
  vpc_id                 = module.vpc.vpc_id
  gateway_id             = module.internet_gateway.igw_id
  destination_cidr_block = "0.0.0.0/0"
  environment            = "development"
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
/* module "ec2_instances" {
  source        = "../../modules/ec2_instances"
  ami_id        = "ami-00b8917ae86a424c9"  # Reemplazar con el AMI real
  instance_type = "t2.micro"
  subnet_ids    = module.public_subnet.subnet_ids
  security_group_id  = module.security_group.security_group_id
  network_interface_ids  = module.network_interface.network_interface_ids
  environment   = "development"
} */

/* 
module "ec2_instances" {
  source         = "../../modules/ec2_instances"
  subnet_ids     = module.public_subnet.subnet_ids

  ami_web        = "ami-0523aa3e7cb0fad6b"  # AMI para servidor web
  ami_db         = "ami-00b8917ae86a424c9"  # AMI para servidor MongoDB
  instance_type  = "t2.micro"
  environment    = "development"
  web_network_interface_ids   = module.network_interface.web_network_interface_ids
  db_network_interface_ids    = module.network_interface.db_network_interface_ids
}
 */



module "auto_scaling" {
  source             = "../../modules/auto_scaling"
  environment        = "development"
  ami_id             = "ami-0523aa3e7cb0fad6b"  # Reemplaza con el AMI adecuado
  instance_type      = "t2.micro"
  associate_public_ip = true
  security_group_ids = [module.security_group.web_sg_id] # Asegúrate de que este es el ID correcto del grupo de seguridad
  subnet_ids         = module.public_subnet.subnet_ids
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1
}

module "network_interface" {
  source            = "../../modules/network_interface"
  subnet_ids        = module.public_subnet.subnet_ids
  web_sg_id         = module.security_group.web_sg_id
  db_sg_id          = module.security_group.db_sg_id
  environment       = "development"
}

module "route_table_association" {
  source         = "../../modules/route_table_association"
  subnet_ids     = module.public_subnet.subnet_ids
  route_table_id = module.route_table.route_table_id
  environment    = "development"
}

/* module "eip" {
  source      = "../../modules/eip"
    instance_id = module.ec2_instances.web_instance_ids[0]  # Asignar a la primera instancia
}
 */