# api-gateway-lambda

Here you will find an api gateway + lambda infrastructure as code configuration.

Once deployed you will be able to hit a URL such as:

<https://api_gateway_id.execute-api.ap-southeast-2.amazonaws.com/api_gateway_lambda_example/transactions?transactionId=5&type=PURCHASE&amount=500>

and receive a JSON response from the Lambda.

The API Gateway has logging configured.

Some generic roles required are located in `/aws-accounts/tf/environments/production`
