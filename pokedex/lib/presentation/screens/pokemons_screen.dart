import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/datasource/pokeapi_pokemon_datasource.dart';
import 'package:pokedex/infrastructure/repositories/pokeapi_pokemon_repository.dart';
import 'package:pokedex/presentation/blocs/listing/pokemons_bloc.dart';
import 'package:pokedex/presentation/delegates/pokemon_search_delegate.dart';
import 'package:pokedex/presentation/widgets/pokemon/pokemon_grid.dart';

class PokemonScreen extends StatefulWidget {
  static const name = "pokemon-screen";

  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final ScrollController _scrollController = ScrollController();
  late PokemonBloc _pokemonBloc;

  @override
  void initState() {
    super.initState();
    final datasource = PokeapiPokemonDatasource();
    final repository = PokeapiPokemonRepository(datasource);
    _pokemonBloc = PokemonBloc(repository);
    _scrollController.addListener(_onScroll);
    _pokemonBloc.add(const FetchPokemons());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pokemonBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _pokemonBloc.add(FetchPokemons());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch<Pokemon?>(
                  context: context,
                  delegate: PokemonSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocProvider<PokemonBloc>(
        create: (context) => _pokemonBloc,
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoaded || state is PokemonLoading) {
              final List<PokemonListing> pokemons = state is PokemonLoaded
                  ? state.pokemons
                  : _pokemonBloc.currentPokemons;
              final bool hasReachedMax =
                  state is PokemonLoaded ? state.hasReachedMax : false;
              final bool isLoading = state is PokemonLoading;
              return _buildPokemonGrid(
                  pokemons, hasReachedMax, isLoading, _scrollController);
            } else if (state is PokemonError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildPokemonGrid(
    List<PokemonListing> pokemons,
    bool hasReachedMax,
    bool isLoading,
    ScrollController scrollController,
  ) {
    return PokemonGrid(
        scrollController: scrollController,
        hasReachedMax: hasReachedMax,
        isLoading: isLoading,
        pokemons: pokemons);
  }
}
