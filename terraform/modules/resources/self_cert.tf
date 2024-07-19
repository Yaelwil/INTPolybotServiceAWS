# Configure the TLS provider
provider "tls" {
  version = "~> 3.1"
}

# Generate a private key
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a self-signed certificate
resource "tls_self_signed_cert" "example" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = aws_lb.main-alb.dns_name
    organization = "Example Organization"
  }

  validity_period_hours = 8760  # 1 year
  early_renewal_hours   = 720   # 30 days before expiration

  dns_names = [
    aws_lb.main-alb.dns_name
  ]

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# # Output the certificate and private key
# output "certificate_pem" {
#   value = tls_self_signed_cert.example.cert_pem
# }
#
# output "private_key_pem" {
#   value = tls_private_key.example.private_key_pem
# }
