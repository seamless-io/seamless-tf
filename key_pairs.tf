resource "aws_key_pair" "web-prod-key-pair" {
    key_name = "web-prod-key-pair"
    public_key = file("web-prod-key-pair.pub")
}