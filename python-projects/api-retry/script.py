import requests
import json

# Set up http client and retry strategy
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

retry_strategy = Retry(
    total=3,
    status_forcelist=[429, 500, 502, 503, 504],
    allowed_methods=["HEAD", "GET", "POST", "OPTIONS"]
)
adapter = HTTPAdapter(max_retries=retry_strategy)
http = requests.Session()
http.mount("https://", adapter)
http.mount("http://", adapter)


def make_call(url):
    headers = {'test': 'header'}
    body = {'message': 'yo'}
    # make api call
    response = http.post(url, headers=headers, data=json.dumps(body))
    return response


def main():
    make_call(url='https://docs.python.org')


if __name__ == "__main__":
    main()
