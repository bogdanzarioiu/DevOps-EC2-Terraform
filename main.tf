


# Create an EC2 instance running Ubuntu and install /enable apache2
#Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"
}
resource "aws_instance" "ec2-webserver-instance" {
    ami = "ami-0bbe28eb2173f6167"
    instance_type = "t2.micro"
    key_name = "webserver-kp"
    tags = {
        Name = "UbuntuWebServer"
    }
    user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        mkdir test
        sudo systemctl start apache2
        sudo bash -c 'echo My first deployed web server > /var/www/html/index.html'
        EOF
}



