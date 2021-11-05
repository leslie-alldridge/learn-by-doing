import json


def handler(event, _context):
    # Parse out query string params
    query_params = event['queryStringParameters']
    transaction_id = query_params['transactionId']
    transaction_type = query_params['type']
    transaction_amount = query_params['amount']

    print(
        f"Id: {transaction_id} | type: {transaction_type} | amount: {transaction_amount}"
    )

    # Construct response body
    transaction_response = {}
    message = "Lambda has responded!"

    transaction_response['transactionId'] = transaction_id
    transaction_response['type'] = transaction_type
    transaction_response['amount'] = transaction_amount
    transaction_response['message'] = message

    # Construct http response object
    response_object = {}
    response_object['statusCode'] = 200
    response_object['headers'] = {}
    response_object['headers']['Content-Type'] = 'application/json'
    response_object['body'] = json.dumps(transaction_response)

    # Return response object
    return response_object
