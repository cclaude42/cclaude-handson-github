import json


def handler(event, context):
    body = {
        "message": "Welcome to handson CI/CD"
    }

    response = {
        "statusCode": 200,
        "body": json.dumps(body)
    }

    return response
