provider "aws" {
    profile = "default"
    region = "us-east-1"
}


resource "aws_s3_bucket" "bemobi" {
  bucket = "bemobidanbucket"
  acl    = "private"

  tags = {
    Name        = "bucket"
    Environment = "Dev"
  }
}

resource "aws_sqs_queue" "queue" {
  name  = "bemobiqueue"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:bemobiqueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_s3_bucket.bemobi.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "${aws_s3_bucket.bemobi.id}"
    queue {
        queue_arn     = aws_sqs_queue.queue.arn
        events        = ["s3:ObjectCreated:Put"]
    }

}

resource "aws_db_subnet_group" "db_subnet_group" {
    name = "${var.cluster_identifier}-subnet_group"
    description = "Para a instância RDS ${var.cluster_identifier}"
    subnet_ids = var.db_subnet_ids
  
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  skip_final_snapshot      = true
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = local.master_password
  deletion_protection = false
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  port                     = var.porta
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = compact(aws_security_group.security_group_name.*.id)
  storage_encrypted = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.id
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  iam_database_authentication_enabled = false
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  final_snapshot_identifier = "${var.cluster_identifier}-snapshotfinal"
}


resource "aws_rds_cluster_instance" "cluster_instance_writer" {
    identifier         = "${var.cluster_identifier}-1"
    cluster_identifier = aws_rds_cluster.default.id
    instance_class     = "db.t3.medium"
    engine             = aws_rds_cluster.default.engine
    engine_version     = aws_rds_cluster.default.engine_version
    apply_immediately = true
    preferred_maintenance_window = var.preferred_maintenance_window
    publicly_accessible = true
    auto_minor_version_upgrade = true

    lifecycle {
      prevent_destroy = false

    }
    depends_on = [
      aws_rds_cluster.default
    ]
  
}

resource "aws_cloudwatch_log_group" "default" {
    name = "/aws/rds/${var.cluster_identifier}"
    retention_in_days = 1
  
}

resource "aws_ecr_repository" "aws-ecr" {
  name = "${var.app_name}-ecr"
  tags = {
    Name        = "${var.app_name}-ecr"
  }
}


