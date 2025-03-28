provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc_network" {
  source = "../../modules/vpc-network"  
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  azs    = var.azs
  public_subnet_cidr     = var.public_subnet_cidr
  public_subnet_names    = var.public_subnet_names
  private_subnet_cidr    = var.private_subnet_cidr
  private_subnet_names   = var.private_subnet_names
  enable_nat_gateway = var.enable_nat_gateway
}

module "security_groups" {
    source = "../../modules/security-groups"
    vpc_id = module.vpc_network.vpc_id
    alb_sg_name = var.alb_sg_name
    ecs_sg_name = var.ecs_sg_name
    rds_sg_name = var.rds_sg_name
}

module "rds" {

    source = "../../modules/rds"
    rds_instance_name            =   var.rds_instance_name  
    vpc_id                       =   module.vpc_network.vpc_id
    subnet_ids                   =   module.vpc_network.private_subnet_ids
    enable_parameter_group       =   var.enable_parameter_group  
    allocated_storage            =   var.allocated_storage  
    max_allocated_storage        =   var.max_allocated_storage  
    storage_type                 =   var.storage_type  
    engine                       =   var.engine  
    engine_version               =   var.engine_version  
    instance_class               =   var.instance_class  
    multi_az                     =   var.multi_az  
    publicly_access              =   var.publicly_access  
    skip_final_snapshot          =   var.skip_final_snapshot  
    final_snapshot_identifier    =   var.final_snapshot_identifier  
    backup_retention_period      =   var.backup_retention_period  
    backup_window                =   var.backup_window  
    maintenance_window           =   var.maintenance_window  
    enable_enhanced_monitoring   =   var.enable_enhanced_monitoring  
    performance_insights_enabled =   var.performance_insights_enabled  
    storage_encryption           =   var.storage_encryption  
    apply_immediately            =   var.apply_immediately  
    enable_cloudwatch_logs_exports = var.enable_cloudwatch_logs_exports  
    rds_instance_tags            =   var.rds_instance_tags  
    rds_sg_id                    =   module.security_groups.rds_sg_id
    secret_id                    =   var.secret_id  

}