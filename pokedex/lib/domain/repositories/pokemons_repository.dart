import 'package:pokedex/domain/entities/pokemon.dart';

abstract class PokemonsRepository {
  Future<List<PokemonListing>> getPokemons({page = 0});
}
