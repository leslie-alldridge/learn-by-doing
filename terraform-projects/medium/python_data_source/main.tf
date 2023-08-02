terraform {
    backend "local" {}
}

data "external" "get_specific_pokemon" {
  program = ["python3", "${path.module}/script.py"]

  query = {
    pokemon_number = "150"
  }
}

output "pokemon_150_name" {
  description = "Name of the pokemon you caught"
  value = data.external.get_specific_pokemon.result
}

data "external" "catch_random_pokemon" {
  program = ["python3", "${path.module}/script.py"]
}

output "pokemon_name" {
  description = "Name of the pokemon you caught"
  value = data.external.catch_random_pokemon.result
}