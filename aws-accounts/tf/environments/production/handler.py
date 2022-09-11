import requests


def handler(event, context):
    r = requests.get('https://pokeapi.co/api/v2/pokemon/1/').json()
    print(r)
    return "Hello World!"
