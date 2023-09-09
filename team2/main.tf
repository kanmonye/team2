resource "aws_instance" "web" {
  ami           = "ami-01c647eace872fc02"
  instance_type = "t2.micro"

  subnet_id              = "subnet-0d10ffc7b0ae1f534"
  vpc_security_group_ids = ["sg-0a9b5e8659c62852d"]

  tags = {
    "Terraform" = "true"
  }
}

resource "aws_s3_bucket" "my-new-S3-bucket" {
  bucket = "my-new-test-kanayo-${random_id.randomness.hex}"

  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Intro to Resource Blocks Lab"
  }
}

resource "aws_s3_bucket_acl" "my_new_bucket_acl" {
  bucket = aws_s3_bucket.my-new-S3-bucket.id
  acl    = "private"
}

resource "aws_security_group" "my-new-security-group" {
  name        = "web_server_inbound"
  description = "allow inbound traffic on tcp/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow 443 from the Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web_server_inbound"
    Purpose = "Intro to Resource Blocks Lab"
  }
}