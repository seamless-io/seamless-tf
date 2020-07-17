# Seamless infrastructure

We use Terraform as a main scripting language for our infrastructure

## Lambda deployment

When deploying lambda:
1. Make changes in `schedule_events_proxy/lambda_function.py`
2. If requirements were changed - run `pip install --target schedule_events_proxy <package_name>`
3. Package `schedule_events_proxy` directory into the zip package: `cd schedule_events_proxy/ && zip -r9 ${OLDPWD}/schedule_events_proxy.zip . && cd ..`

## Adding to / updating secrets.tf

secret.tf file contains secrets in the encrypted form.
In order to add a new secret, you need to:
1. Create a file where the only content is the value you need encrypted
2. Go to https://console.aws.amazon.com/kms/home?region=us-east-1#/kms/keys and copy `Key ID` from the key with the Alias `-`
3. Run `aws kms encrypt --key-id <key id from step 2> --plaintext fileb://<file name from step 1> --output text --query CiphertextBlob`
4. Copy the output from the previous command.
5. Create a new record in the `secrets.tf` in the following form
```hcl-terraform
data "aws_kms_secrets" "tf_variable_name" {
  secret {
    name    = "name_of_your_secret"
    payload = "value from step 4"
  }
}
```
6. Now you can pass the secret anywhere in terraform like this 
```hcl-terraform
data.aws_kms_secrets.tf_variable_name.plaintext["name_of_your_secret"]
```
The value will be used in the open form only when the resource is created. At all other times it will be in the encrypted from.
