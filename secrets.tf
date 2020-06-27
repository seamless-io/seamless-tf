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

data "aws_kms_secrets" "web_prod_env" {

  secret {
    name    = "AUTH0_CLIENT_ID"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQFarndkdRx1uXf8oYfpTOFFAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMyH87auAeHX0Hr5sOAgEQgDtoDqy5oK/zz4Hj4YUpcyLLI6Gz89EStb8sjWpE38MZWHSeiHOH1o0j6jDqHMGnjG33LmygzPojO27k8Q=="
  }

  secret {
    name    = "AUTH0_CLIENT_SECRET"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQGJ1pqZHQP1JVCJzwOB1nF8AAAAojCBnwYJKoZIhvcNAQcGoIGRMIGOAgEAMIGIBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDBhc/CUYmhFHaLrAWwIBEIBb6JIvdaMOhBXboTYY3XQgF5X/OAH2In7Db7xrzCM8JJNdn1gGAZHfsx1UIRZYVx7vhp6wVtLCYPh/uetNX2kuasCwC2gBis4i7MxGlH2UwDtM3JJ1MPPH2bGStw=="
  }
}
