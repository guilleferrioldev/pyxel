import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/repositories/pokemons_repository.dart';
import 'package:pokedex/infrastructure/datasource/pokeapi_pokemon_datasource.dart';

class PokeapiPokemonRepository extends PokemonsRepository {
  final PokeapiPokemonDatasource datasource;
  PokeapiPokemonRepository(this.datasource);

  @override
  Future<List<PokemonListing>> getPokemons({page = 0}) async {
    return datasource.getPokemons(page: page);
  }

  @override
  Future<Pokemon> getPokemon(String id) async {
    return datasource.getPokemon(id);
  }
}
