import os

import requests


def lambda_handler(event, context):
    print(event)
    url = f"https://schedule:{os.getenv('SCHEDULE_PASSWORD')}@app.seamlesscloud.io/schedule/jobs/execute"
    res = requests.post(url, json=event)
    res.raise_for_status()
