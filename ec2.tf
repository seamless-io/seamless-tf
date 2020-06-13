resource "aws_instance" "core-prod" {

    ami = var.AMI
    instance_type = var.INSTANCE_TYPE

    # VPC
    subnet_id = aws_subnet.prod-subnet-public-1.id

    # Security Group
    vpc_security_group_ids = [
        aws_security_group.ssh-allowed.id]

    # the Public SSH key
    key_name = aws_key_pair.seamless-core-prod-key-pair.id

    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/nginx.sh",
            "sudo /tmp/nginx.sh"
        ]
    }

    connection {
        user = var.EC2_USER
        private_key = file(var.PRIVATE_KEY_PATH)
        host = self.public_ip
    }
}

resource "aws_key_pair" "seamless-core-prod-key-pair" {
    key_name = "seamless-core-prod-key-pair"
    public_key = file(var.PUBLIC_KEY_PATH)
}