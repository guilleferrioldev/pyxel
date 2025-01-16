part of 'details_cubit.dart';

abstract class PokemonDetailsState {}

class PokemonInitial extends PokemonDetailsState {}

class PokemonLoading extends PokemonDetailsState {}

class PokemonLoaded extends PokemonDetailsState {
  final Pokemon pokemon;

  PokemonLoaded({required this.pokemon});
}

class PokemonError extends PokemonDetailsState {
  final String message;

  PokemonError({required this.message});
}
