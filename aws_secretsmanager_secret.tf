resource "aws_secretsmanager_secret" "aurora_user" {
  name = "${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstanceUserSecret1"
  description = "Usuário master da instancia RDS ${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}"
  recovery_window_in_days = "0"
  kms_key_id = aws_kms_key.kmsbinobi.id
    

}

resource "aws_secretsmanager_secret" "aurora_password" {
  name = "${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstancePasswordrSecret1"
  description = "Password do Usuário master da instancia RDS ${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}"
  recovery_window_in_days = "0"
  kms_key_id = aws_kms_key.kmsbinobi.id
    

}

resource "aws_secretsmanager_secret" "aurora_endpoint" {
  name = "${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstanceEndpointSecret1"
  description = "Endpoint da instancia RDS ${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}"
  recovery_window_in_days = "0"
  kms_key_id = aws_kms_key.kmsbinobi.id
    

}


resource "aws_ssm_parameter" "RDSInstanceUserSecret" {
    name = "/rds/${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstanceUserSecret"
    type = "String"
    value = aws_secretsmanager_secret.aurora_user.id
  
}


resource "aws_ssm_parameter" "RDSInstancePasswordSecret" {
    name = "/rds/${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstancePasswordSecret"
    type = "String"
    value = aws_secretsmanager_secret.aurora_password.id
  
}

resource "aws_ssm_parameter" "RDSInstanceEndpointSecret" {
    name = "/rds/${aws_rds_cluster_instance.cluster_instance_writer.cluster_identifier}-RDSInstanceEndpointSecret"
    type = "String"
    value = aws_secretsmanager_secret.aurora_endpoint.id
  
}