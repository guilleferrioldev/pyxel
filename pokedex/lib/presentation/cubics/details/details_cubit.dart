import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/datasource/pokeapi_pokemon_datasource.dart';

part 'details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final PokeapiPokemonDatasource _pokemonDatasource;

  PokemonDetailsCubit({PokeapiPokemonDatasource? pokemonDatasource})
      : _pokemonDatasource = pokemonDatasource ?? PokeapiPokemonDatasource(),
        super(PokemonInitial());

  Future<void> fetchPokemon(String pokemonId) async {
    emit(PokemonLoading());
    try {
      final pokemon = await _pokemonDatasource.getPokemon(pokemonId);
      emit(PokemonLoaded(pokemon: pokemon));
    } catch (e) {
      emit(PokemonError(message: 'Failed to load pokemon: $e'));
    }
  }
}
