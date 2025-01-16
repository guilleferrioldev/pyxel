import 'package:pokedex/domain/entities/pokemon.dart' as domain;
import 'package:pokedex/infrastructure/models/pokeapi_pokemon_listing.dart';
import 'package:pokedex/infrastructure/models/pokeapi_pokemon_response.dart';

class PokemonMapper {
  static domain.PokemonListing mapToPokemonListing(
      PokeapiPokemonListing pokemon) {
    return domain.PokemonListing(
        id: int.parse(pokemon.url.split('/')[6]), name: pokemon.name);
  }

  static domain.Pokemon mapToPokemon(PokeapiPokemonResponse pokemon) {
    return domain.Pokemon(
      abilities: pokemon.abilities
          .map((pokeapiAbility) => domain.Ability(
                ability: domain.Species(
                    name: pokeapiAbility.ability.name,
                    url: pokeapiAbility.ability.url),
                isHidden: pokeapiAbility.isHidden,
                slot: pokeapiAbility.slot,
              ))
          .toList(),
      height: pokemon.height,
      weight: pokemon.weight,
      id: pokemon.id,
      name: pokemon.name,
    );
  }
}
