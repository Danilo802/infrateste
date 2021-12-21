resource "aws_secretsmanager_secret_version" "user_secret" {
    secret_id  = aws_secretsmanager_secret.aurora_user.id
    secret_string = aws_rds_cluster.default.master_username
  
}

resource "aws_secretsmanager_secret_version" "password_secret" {
    secret_id  = aws_secretsmanager_secret.aurora_password.id
    secret_string = aws_rds_cluster.default.master_password

    lifecycle {
      create_before_destroy = true
    }
  
}

resource "aws_secretsmanager_secret_version" "endpoint_secret" {
    secret_id  = aws_secretsmanager_secret.aurora_endpoint.id
    secret_string = aws_rds_cluster_instance.cluster_instance_writer.endpoint

    lifecycle {
      create_before_destroy = true
    }
  
}