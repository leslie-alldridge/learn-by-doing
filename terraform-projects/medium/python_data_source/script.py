import http.client
import json
import random
import sys


def main(pokemon_number):
    host = "pokeapi.co"
    conn = http.client.HTTPSConnection(host)

    if not pokemon_number:
        pokemon_number = random.randint(1,150)

    conn.request("GET", f"/api/v2/pokemon/{pokemon_number}")
    
    response = conn.getresponse()

    if response.status != 200:
        print(json.dumps({'status': str(response.status), 'msg': response.reason}))
        return

    data = json.loads(response.read())
    print(json.dumps({'value': data["name"]}))


if __name__ == "__main__":
    input = sys.stdin.read()
    input_json = json.loads(input)

    main(pokemon_number=input_json.get('pokemon_number'))
