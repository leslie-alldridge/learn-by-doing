import unittest
import script
import requests


class TestAPI(unittest.TestCase):
    def test_failed_api_call(self):
        with self.assertRaises(requests.exceptions.ConnectionError) as context:
            script.make_call('http://localhost:3010')

        self.assertTrue(
            'Max retries exceeded with url' in str(context.exception))

    def test_method_not_allowed(self):
        response = script.make_call('http://www.google.com')
        self.assertEqual(405, response.status_code)

    def test_method_not_allowed(self):
        response = script.make_call(
            'https://jsonplaceholder.typicode.com/posts')
        self.assertEqual(201, response.status_code)


if __name__ == '__main__':
    unittest.main()
