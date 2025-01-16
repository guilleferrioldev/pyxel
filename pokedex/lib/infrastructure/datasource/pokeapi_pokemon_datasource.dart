import 'package:dio/dio.dart';
import 'package:pokedex/domain/datasources/pokemons_datasource.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/mappers/pokemon_mapper.dart';
import 'package:pokedex/infrastructure/models/pokeapi_pokemon_listing.dart';

class PokeapiPokemonDatasource extends PokemonsDataSource {
  final Dio client = Dio();

  @override
  Future<List<PokemonListing>> getPokemons({page = 0}) async {
    final queryParameters = {'limit': '100', 'offset': (page * 100).toString()};

    try {
      final response = await client.get(
        'https://pokeapi.co/api/v2/pokemon',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final pokeapilistingresponse =
            PokeapiListingResponse.fromJson(response.data);

        return pokeapilistingresponse.results
            .map((pokemon) => PokemonMapper.mapToPokemonListing(pokemon))
            .toList();
      } else {
        throw [];
      }
    } catch (error) {
      return [];
    }
  }
}
