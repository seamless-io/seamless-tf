resource "aws_kms_key" "terraform" {
  description             = "terraform secrets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# To decrypt the password do `aws kms decrypt --ciphertext-blob <secret.payload> --output text --query Plaintext`
data "aws_kms_secrets" "web_prod_rds" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQHhImDVuhbCxD40vfRu4rAzAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMZfvmtGDy5DQWUsESAgEQgDuxPpJzhnvsUjBoOO1/2Bh54FMr+Pix0SyKE7iS87cX8eY5dgUKR87b3mxxxCX/jjfg7ICZdmsZoliVKg=="
  }
}