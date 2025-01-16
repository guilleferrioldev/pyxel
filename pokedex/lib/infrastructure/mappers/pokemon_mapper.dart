import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/models/pokeapi_pokemon_listing.dart';

class PokemonMapper {
  static PokemonListing mapToPokemonListing(PokeapiPokemonListing pokemon) {
    return PokemonListing(
        id: int.parse(pokemon.url.split('/')[6]), name: pokemon.name);
  }
}
