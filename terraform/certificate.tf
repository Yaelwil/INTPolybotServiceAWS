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

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate_creation.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_route53_zone" "primary" {
  name = aws_lb.main-alb.dns_name
}

################################
# Validate the ACM Certificate #
################################
resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.certificate_creation.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
