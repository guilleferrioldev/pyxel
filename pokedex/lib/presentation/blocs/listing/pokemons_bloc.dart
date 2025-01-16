import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/repositories/pokemons_repository.dart';
import 'package:equatable/equatable.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonsRepository pokemonsRepository;
  int _currentPage = 0;
  bool _hasReachedMax = false;
  final List<PokemonListing> _currentPokemons = [];

  PokemonBloc(this.pokemonsRepository) : super(PokemonInitial()) {
    on<FetchPokemons>(_onFetchPokemons);
  }

  List<PokemonListing> get currentPokemons => _currentPokemons;

  Future<void> _onFetchPokemons(
      FetchPokemons event, Emitter<PokemonState> emit) async {
    try {
      if (state is PokemonLoading) return;
      if (_hasReachedMax) {
        emit(PokemonLoaded(_currentPokemons, hasReachedMax: true));
        return;
      }

      emit(PokemonLoading());

      final newPokemons =
          await pokemonsRepository.getPokemons(page: _currentPage);

      if (newPokemons.isEmpty) {
        _hasReachedMax = true;
      } else {
        _currentPokemons.addAll(newPokemons);
        _currentPage++;
      }

      emit(PokemonLoaded(_currentPokemons, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
