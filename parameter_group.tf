resource "aws_rds_cluster_parameter_group" "default" {
    name = "${var.cluster_identifier}-parameter-group-aurora"
    family = var.cluster_group_family
    description = "Grupo de parametros padrão do RDS cluster"

    parameter {
      name = "long_query_time"
      value = 5
    }

      parameter {
      name = "slow_query_log"
      value = 1
    }
    
}