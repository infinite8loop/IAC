resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_profile_inference"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-role-inference"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
  name       = "ssm-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.ec2_role.name]
}

resource "aws_iam_policy_attachment" "ecr_policy_attachment" {
  name       = "ecr-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  roles      = [aws_iam_role.ec2_role.name]
}

## Security Group Resources
resource "aws_security_group" "alb_security_group" {
  name        = "${var.name}-alb-security-group"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-alb-security-group"
  }
}

resource "aws_security_group" "asg_security_group" {
  name        = "${var.name}-asg-security-group"
  description = "ASG Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 8001
    to_port         = 8001
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-asg-security-group"
  }
}

# Lookup Ubunut AMI Image
/* data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
} */

variable "custom_ami_id" {
  default = "ami-0994c9f47de7d7559"
  description = "The ID of your custom AMI"
}

## Launch Template and ASG Resources

resource "aws_launch_template" "launch_template" {
  name          = "${var.name}-launch-template"
  image_id      = var.custom_ami_id
  instance_type = "t3.medium"
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }  

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-asg-ec2"
    }
  }
  user_data = base64encode("${var.ec2_user_data}")
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "CPUUtilizationScalingPolicy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
  estimated_instance_warmup = 200
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name = "${var.name}-asg"  
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = var.private_subnets_ids
  target_group_arns   = [aws_lb_target_group.target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

# Application Load Balancer Resources

resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.public_subnets_ids
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.name}-target-group"
  port     = 8001
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path    = "/"
    matcher = 200
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  tags = {
    Name = "${var.name}-alb-listenter"
  }
}