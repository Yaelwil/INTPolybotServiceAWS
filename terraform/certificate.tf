resource "aws_acm_certificate" "certificate_creation" {
  domain_name       = aws_lb.main-alb.dns_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.owner}-certificate-${var.project}"
  }
}

resource "aws_route53_zone" "primary" {
  name = "example.com"
}

resource "null_resource" "create_validation_records" {
  provisioner "local-exec" {
    command = <<EOT
    for dvo in $(terraform state show -json aws_acm_certificate.certificate_creation | jq -c '.domain_validation_options[]'); do
      name=$(echo $dvo | jq -r .resource_record_name)
      value=$(echo $dvo | jq -r .resource_record_value)
      type=$(echo $dvo | jq -r .resource_record_type)
      cat << EOF >> terraform.tf
resource "aws_route53_record" "cert_validation_$name" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "$name"
  type    = "$type"
  ttl     = 60
  records = ["$value"]
}
EOF
    done
    EOT
  }

  depends_on = [aws_acm_certificate.certificate_creation]
}

resource "null_resource" "apply_dns_records" {
  depends_on = [null_resource.create_validation_records]
  provisioner "local-exec" {
    command = "terraform apply -auto-approve"
  }
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.certificate_creation.arn
  validation_record_fqdns = [for dvo in aws_acm_certificate.certificate_creation.domain_validation_options : "${dvo.resource_record_name}.${aws_route53_zone.primary.name}"]

  depends_on = [null_resource.apply_dns_records]
}
