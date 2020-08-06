# resource "aws_instance" "web" {
#   ami           = "ami-07c1207a9d40bc3bd"
#   instance_type = "t2.micro"
#   security_groups = [
#     module.alexs-sg-bc.name
#   ]
#   user_data = data.local_file.alexs-user-data.content
#   key_name = "alex"
#   tags = {
#     Name = "HelloWorld"
#   }
# }

data "local_file" "alexs-user-data" {
  filename = "user_data.sh"
}
