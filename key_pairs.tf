resource "aws_key_pair" "core-prod-key-pair" {
    key_name = "core-prod-key-pair"
    public_key = file(var.PUBLIC_KEY_PATH)
}