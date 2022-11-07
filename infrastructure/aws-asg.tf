# will contain code for autoscaling group


/* resource "aws_launch_configuration" "latif_lc" {
  name_prefix     = "latif_asg_-lc_tf-"
  image_id        = "ami-013a6cfe65c679183"
  instance_type   = "t2.micro"
  security_groups = ["replace"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "latif" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.latif_lc.name
  vpc_zone_identifier  = ["replace"]
}

resource "aws_lb" "latif" {
  name               = "latif-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["replace"]
  subnets            = ["replace", "repalce"]
}

resource "aws_lb_listener" "latif" {
  load_balancer_arn = aws_lb.latif.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.latif.arn
  }
}

resource "aws_lb_target_group" "latif" {
  name     = "latif-tf-asg-practice"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "replace"
}

resource "aws_autoscaling_attachment" "latif" {
  autoscaling_group_name = aws_autoscaling_group.latif.id
  alb_target_group_arn   = aws_lb_target_group.latif.arn
}

resource "aws_autoscaling_policy" "latif_scale_up" {
  name                   = "latif-scale-up"
  autoscaling_group_name = aws_autoscaling_group.latif.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "latif_scale_down" {
  name                   = "latif-scale-down"
  autoscaling_group_name = aws_autoscaling_group.latif.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300

}

resource "aws_cloudwatch_metric_alarm" "latif_scale_up_alarm" {
  alarm_description   = "Monitors CPU utilization for app"
  alarm_actions       = [aws_autoscaling_policy.tudor_scale_up.arn]
  alarm_name          = "latif_scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "30"
  evaluation_periods  = "1"
  period              = "120"
  statistic           = "Average"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.latif.name}"
  }

}

resource "aws_cloudwatch_metric_alarm" "latif_scale_down_alarm" {
  alarm_description   = "Monitors CPU utilization for app"
  alarm_actions       = [aws_autoscaling_policy.latif_scale_down.arn]
  alarm_name          = "latif_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "1"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.latif.name}"
  }
} */