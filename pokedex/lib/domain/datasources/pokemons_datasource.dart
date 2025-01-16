import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonsDataSource {
  Future<List<PokemonListing>> getPokemons({page = 0});
  Future<Pokemon> getPokemon(String id);
}
