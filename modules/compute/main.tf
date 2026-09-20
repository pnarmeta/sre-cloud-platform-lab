resource "aws_security_group" "web_server" {
  name        = "sre-web-server-sg"
  description = "Security group for SRE learning web server"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "sre-web-server-sg"
    }
  )
}
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_server.id

  description = "Allow HTTP traffic"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.web_server.id

  description = "Allow all outbound traffic"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
resource "aws_iam_role" "ec2_role" {
  name = "sre-learning-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "sre-learning-ec2-role"
    }
  )
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "sre-learning-ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = local.common_tags
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [
    aws_security_group.web_server.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              dnf install -y httpd
              systemctl enable httpd
              systemctl start httpd

              cat > /var/www/html/index.html <<'HTML'
              <html>
                <body>
                  <h1>SRE Cloud Platform Lab</h1>
                  <p>Provisioned automatically using Terraform.</p>
                </body>
              </html>
              HTML
              EOF

  tags = merge(
    local.common_tags,
    {
      Name = "sre-learning-web-server"
    }
  )
}