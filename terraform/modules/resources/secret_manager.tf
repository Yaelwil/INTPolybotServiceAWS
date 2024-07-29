###################
# ACM Certificate #
###################
resource "aws_acm_certificate" "self_signed" {
  private_key       = tls_private_key.example.private_key_pem
  certificate_body  = tls_self_signed_cert.example.cert_pem
  tags = {
    Name = "self-signed-cert"
  }
}

###########
# Secrets #
###########
# Store the certificate body in Secrets Manager
resource "aws_secretsmanager_secret" "certificate" {
  name = "${var.owner}-certificate-i-${var.project}"
  kms_key_id = aws_kms_key.kms_key.id  # Reference to the KMS key

#   lifecycle {
#     prevent_destroy = true
#   }
}

resource "aws_secretsmanager_secret_version" "certificate_version" {
  secret_id     = aws_secretsmanager_secret.certificate.id
  secret_string = tls_self_signed_cert.example.cert_pem
}
