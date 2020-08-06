resource "aws_autoscaling_group" "alexs_scaling" {
  name                      = "alexs-scaling"
  max_size                  = 2
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.alexs_launch.name
  vpc_zone_identifier       = [aws_vpc.main.id]
  target_group_arns         = [aws_lb_target_group.alexs-page.arn]
  tag {
    key                 = "Name"
    value               = "Alexs Web Server"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "alexs_launch" {
  name_prefix   = "alexs-lc-"
  image_id      = "ami-07c1207a9d40bc3bd"
  instance_type = "t2.micro"
  #key_name      = "alex"
  user_data     = data.local_file.alexs-user-data.content
  security_groups = [
    aws_security_group.alexs_sg_bc.id
  ]
  lifecycle {
    create_before_destroy = true
  }
}
