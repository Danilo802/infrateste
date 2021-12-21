resource "aws_security_group" "security_group_name" {
    name = "security_group-${var.cluster_identifier}"
    vpc_id = var.vpc_id
    description = "Controla o trafego de/para RDS autora ${var.cluster_identifier}"

    ingress {
        description = "Aurora MySQLPort"
        from_port = 0 
        # from_port = var.porta
        to_port = var.porta
        protocol = "tcp"
        # cidr_blocks = var.cidr
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}