resource "aws_kms_key" "kmsbinobi" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}