resource "aws_kms_key" "terraform" {
  description             = "terraform secrets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# To decrypt the password do `aws kms decrypt --ciphertext-blob <secret.payload> --output text --query Plaintext`

####### PROD #######

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

data "aws_kms_secrets" "web_prod_lambda_proxy" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQGQgzu9Rkwa8X/WHAI7BZL4AAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMEXYvJljFxVhpAEQUAgEQgDsibl1bDAcYKaH7obttgZorj5YrSACEOSdLGI5E6/MXgwc+u/elNLBIUrAeJHcoF74xaHVmJ/so9fdIUg=="
  }
}

####### STAGING #######

data "aws_kms_secrets" "web_staging_rds" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQGyeKEFNjNUCBn34fUHq17tAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMtQmA3NGZeABgo5W3AgEQgDt32aH3j5OgL9LWBYf1SBre9lJmmBV7NeZ+0v8dQ6MJgMlO4GLIyWBk1ofKljupuBHPEq0BOrINih9r6g=="
  }
}

data "aws_kms_secrets" "web_staging_env" {

  secret {
    name    = "AUTH0_CLIENT_ID"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQGEzYESCU3bofgrd0mrcW58AAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMpc8GW7m9pcMPTecpAgEQgDtJjsgzA7aRnYYeiyu0sFKPSsHJQGdGDZo9fm6a78xq9MiNj1fHTvgEq1+kWwe7pJ9bX3Bu/yWiLo+wJQ=="
  }

  secret {
    name    = "AUTH0_CLIENT_SECRET"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQEb7K9cFYUeAERivJ94Bbb9AAAAojCBnwYJKoZIhvcNAQcGoIGRMIGOAgEAMIGIBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDBKps75B6jfAN75PywIBEIBbgZuLuxJGsQGrKvycc+hb7dnZaAdDByPz3nAWk/DgVNomwuKr9f9AqoPN4UIiVzskbo+MMfj8WpqV/J+GvVBLjs/WBPGVAd8az0ZvN+gUyIMoI9DsCb+/OmXKFA=="
  }
}

data "aws_kms_secrets" "web_staging_lambda_proxy" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQEenDqfsWD0PtkSI8rzzRxGAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMTnOG7sMnOj6my9/OAgEQgDsSFrHC+3tAlqNzWUI1fLlA2I4NrVrtYa7jiFm0HETWZhZMzddeQuJytMjcccSOQzohMQYQbkZG/ddMmg=="
  }
}

data "aws_kms_secrets" "andrey_gmail_app" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQHIGHcBbEkUwuw1vTUYo8W0AAAAbjBsBgkqhkiG9w0BBwagXzBdAgEAMFgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMcQUe4MFFr4Tj1QxXAgEQgCuhCZ2KlKHWD7iDPQdQGNkauO4/cAy+QU4r/nkM5ft38vKHXmeM1gDYb8uZ"
  }
}

data "aws_kms_secrets" "github_actions" {
  secret {
    name    = "password"
    payload = "AQICAHgsOys+lvW8Nr7gsicGSZ+ceSlQiZ+POZ2GZay6khZ7DQGPNQriB2SihJqY0Zj0ccF8AAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMGxaJgQXBA6wZituVAgEQgDuidYDbgafjZMOBFtBAsAuFwEa7Xn0dpEt9QwxzryR2WAyBK6iJB68LnQAifZPJlE8FVDVdsFxV0Ct0Sg=="
  }
}