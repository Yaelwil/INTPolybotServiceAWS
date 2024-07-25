###########
# Secrets #
###########

# Store the certificate body in Secrets Manager
resource "aws_secretsmanager_secret" "certificate" {
  name = "${var.owner}-mn-certificate-${var.project}"
  kms_key_id = aws_kms_key.kms_key.id  # Reference to the KMS key
}

resource "aws_secretsmanager_secret_version" "certificate_version" {
  secret_id     = aws_secretsmanager_secret.certificate.id
  secret_string = tls_self_signed_cert.example.cert_pem
}
