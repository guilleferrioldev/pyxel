part of 'pokemons_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemons extends PokemonEvent {
  final int page;

  const FetchPokemons({this.page = 0});
  @override
  List<Object> get props => [page];
}
