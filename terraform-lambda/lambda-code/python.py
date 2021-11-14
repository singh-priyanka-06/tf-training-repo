
# Lambda function code created as part of demo.

def lambda_handler(event,context):
    print("Hello, Lambda function started execution")
    something()
    return "Lambda execution done"


def something():
    print("Hello , I am inside something function")
