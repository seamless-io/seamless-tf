# Seamless infrastructure

We use Terraform as a main scripting language for our infrastructure

## Lambda deployment

When deploying lambda:
1. Make changes in `schedule_events_proxy/lambda_function.py`
2. If requirements were changed - run `pip install --target schedule_events_proxy <package_name>`
3. Package `schedule_events_proxy` directory into the zip package: `cd schedule_events_proxy/ && zip -r9 ${OLDPWD}/schedule_events_proxy.zip . && cd ..`
