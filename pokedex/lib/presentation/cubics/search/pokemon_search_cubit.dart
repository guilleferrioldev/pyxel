import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/datasource/pokeapi_pokemon_datasource.dart';

part 'pokemon_search_state.dart';

class PokemonSearchCubit extends Cubit<PokemonSearchState> {
  final PokeapiPokemonDatasource _pokemonDatasource;

  PokemonSearchCubit({PokeapiPokemonDatasource? pokemonDatasource})
      : _pokemonDatasource = pokemonDatasource ?? PokeapiPokemonDatasource(),
        super(PokemonSearchInitial());

  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      emit(PokemonSearchInitial());
      return;
    }

    emit(PokemonSearchLoading());
    try {
      final pokemon = await _pokemonDatasource.getPokemon(query);
      emit(PokemonSearchLoaded(pokemon: pokemon));
    } catch (e) {
      emit(PokemonSearchError(message: 'The pokemon was not found'));
    }
  }

  void clearSearch() {
    emit(PokemonSearchInitial());
  }
}
