part of 'pokemon_search_cubit.dart';

abstract class PokemonSearchState {}

class PokemonSearchInitial extends PokemonSearchState {}

class PokemonSearchLoading extends PokemonSearchState {}

class PokemonSearchLoaded extends PokemonSearchState {
  final Pokemon pokemon;

  PokemonSearchLoaded({required this.pokemon});
}

class PokemonSearchError extends PokemonSearchState {
  final String message;

  PokemonSearchError({required this.message});
}
