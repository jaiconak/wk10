# Load Balancer 
resource "aws_lb" "alb" {
  name = "alb-loadbalancer"
  internal = false  #No internet access or internet access
  load_balancer_type = "application" #application = https/http  network= tcp/udp
  security_groups = [aws_security_group.loadbalancerProxy.id]
  subnets = [aws_subnet.public1.id, aws_subnet.public2.id]
  enable_deletion_protection = false #Prevents people from using terraform destroy
  tags = {
    Env = "dev"
  }
}
#target group
resource "aws_lb_target_group" "target1" {
    name = "alb-target"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.utcVpc.id

    health_check {
      enabled = true
      healthy_threshold = 3
      interval = 100
      path = "/"
      matcher = 200
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 6
      unhealthy_threshold = 3
    }  
}
# Attaches Load Balancer to EC2
resource "aws_lb_target_group_attachment" "lbAttach1" {
  target_group_arn = aws_lb_target_group.target1.arn
  target_id = aws_instance.firstInstance.id
  port = 80
}
resource "aws_lb_target_group_attachment" "lbAttach2" {
  target_group_arn = aws_lb_target_group.target1.arn
  target_id = aws_instance.secondInstance.id
  port = 80
}

# Directs incoming traffic
resource "aws_lb_listener" "listener1" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target1.arn
    }
}