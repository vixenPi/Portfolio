resource "aws_key_pair" "alex_ps" {
  key_name   = "alex-ps-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCty6EvRgyezTJBZA9DcCHqz1aHphcg0OmwW9T/Al1nsz6HgggGeRwNQ18YLmuJvQV5ueff4FJs4NuxY3Lw7NqJ7H4jYBEJ7WPXgTNrZvL1eYnA5iSioI6xadWJHUbsET6wLxLR8Y3azcwiA0azLMDvprgTUmjjjhj/J541Ql2MeNTLWO/w/8uUwFsiSE8G1hcVFoyxiRR6Yg878PHhOZFtEH9Q1vYe0Dqd61HftdLfMlB7VlTMn9S1zB0/Ho2ZOD7vjiLcNqgAuZRZTvvvi6aOcsI5iS+EnrXSJcv8Fqzrlz6BX/jWvxolO52ZPo5d3K0CYMAUTj92w9886i3ZVePcdykB7kQOBBd8PNFlcjEU5mCYlI0hYZWZhF66eEZf3fgAvG9p3cUCb8m3LapXVYMjkpWR7aC/MCRb7T2hCtmKxqbKXnZyaJSFnJyMBkaVGTI9k7NYtcydJLvd/E+cUwZC8yAQWulbP2BxXEDGf35itGd1o9KuOESjlNix05sgNsM= alexandra-neubauer@AleNeub-MBP"
}

resource "aws_key_pair" "alex_mac" {
  key_name   = "alex-mac-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgAj9z9pPZLZT8x8BIw+5l7rgv074KQTRCMusbGyokFw7XWcfBrByUCbGXPYpXwcE8EvVt95MFh/HcNE7klFyOij+qpJd9m5pF/3lMfg+unnboHm0ySV+Tf8d97CxwwBVGqdoD68E0fixaP7FfG4t0EdREeDRj5G54fdSlZxAKcVJVbJ6T2oVLIPRvfmKJXR0mq6sDR+rhC4BVQuqBRB7sM9FhuW5OVYi20TF0BrNYx8SMeVfAeNWzTRR9iqI3hqzw9QWdi21od48CrQDvb5wXG8mjAfvo8mrRnWC/ZOqI03iS3cJawFxUuPO7oHQ1dHxBxaBcDj2PqmZpzWz/+Iq99+SJa8tIuvpQveCkiB6npQN9cSZzM8a/LbOxnqx95NJSAbjlQPrZT7U+L/e8uGUID9tA4CtPC6EoAJuqPffZ1rlJfVR2NVEcgSDoGC1GwZCaiA4TGfqa6UB2mK4nM1LRSyQAnOmx/s+TGvpZXchSkjz5e/OQoIJudJ71fod1cUE= Alex@Alexandras-MacBook-Pro-530.local"
}

resource "aws_autoscaling_group" "alexs_scaling" {
  name                      = "alexs-scaling"
  max_size                  = 2
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.alexs_launch.name
  vpc_zone_identifier       = [aws_subnet.subnet_0.id, aws_subnet.subnet_1.id]
  target_group_arns         = [aws_lb_target_group.alexs-page.arn]
  # suspended_processes = ["ReplaceUnhealthy"]
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
  key_name      = aws_key_pair.alex_mac.key_name
  user_data     = data.local_file.alexs-user-data.content
  security_groups = [
    aws_security_group.alexs_sg_bc.id
  ]
  lifecycle {
    create_before_destroy = true
  }
}
