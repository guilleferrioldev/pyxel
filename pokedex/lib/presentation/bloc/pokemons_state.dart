part of 'pokemons_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonListing> pokemons;
  final bool hasReachedMax;

  const PokemonLoaded(this.pokemons, {this.hasReachedMax = false});

  @override
  List<Object> get props => [pokemons, hasReachedMax];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
