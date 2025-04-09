resource "aws_security_group" "vpc_endpoint_sg" {
  name   = "${var.env}-vpc-endpoint-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-vpc-endpoint-sg"
  }
}

resource "aws_security_group_rule" "vpc_endpoint_sg_ingress_vpc_cidr_to_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.vpc_endpoint_sg.id
}

resource "aws_security_group_rule" "vpc_endpoint_sg_egress_443" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_endpoint_sg.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
}

# resource "aws_vpc_endpoint" "secrets_manager" {
#   vpc_id              = var.vpc_id
#   service_name        = "com.amazonaws.${var.region}.secretsmanager"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   security_group_ids  = concat(var.whitelist_sg_ids, [aws_security_group.vpc_endpoint_sg.id])
#   subnet_ids          = var.private_subnets
#   depends_on          = [aws_security_group.vpc_endpoint_sg]
# }

# resource "aws_vpc_endpoint" "ecr" {
#   vpc_id              = var.vpc_id
#   service_name        = "com.amazonaws.${var.region}.ecr.dkr"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   security_group_ids  = concat(var.whitelist_sg_ids, [aws_security_group.vpc_endpoint_sg.id])
#   subnet_ids          = var.private_subnets
#   depends_on          = [aws_security_group.vpc_endpoint_sg]
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id              = var.vpc_id
#   service_name        = "com.amazonaws.${var.region}.ecr.api"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   security_group_ids  = concat(var.whitelist_sg_ids, [aws_security_group.vpc_endpoint_sg.id])
#   subnet_ids          = var.private_subnets
#   depends_on          = [aws_security_group.vpc_endpoint_sg]
# }

# resource "aws_vpc_endpoint" "logs" {
#   vpc_id              = var.vpc_id
#   service_name        = "com.amazonaws.${var.region}.logs"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   security_group_ids  = concat(var.whitelist_sg_ids, [aws_security_group.vpc_endpoint_sg.id])
#   subnet_ids          = var.private_subnets
#   depends_on          = [aws_security_group.vpc_endpoint_sg]
# }

# resource "aws_vpc_endpoint" "kms" {
#   vpc_id              = var.vpc_id
#   service_name        = "com.amazonaws.${var.region}.kms"
#   vpc_endpoint_type   = "Interface"
#   security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
#   subnet_ids          = var.private_subnets
#   private_dns_enabled = true
#   depends_on          = [aws_security_group.vpc_endpoint_sg]
# }
