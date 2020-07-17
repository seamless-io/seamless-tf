resource "aws_key_pair" "web-key-pair" {
    key_name = format("web-%s-key-pair", var.stage)
    public_key = file(format("web-%s-key-pair.pub" ,var.stage))
}