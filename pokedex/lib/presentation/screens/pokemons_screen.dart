import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/infrastructure/datasource/pokeapi_pokemon_datasource.dart';
import 'package:pokedex/infrastructure/repositories/pokeapi_pokemon_repository.dart';
import 'package:pokedex/presentation/bloc/pokemons_bloc.dart';

class PokemonScreen extends StatefulWidget {
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
      appBar: AppBar(title: const Text('Pokédex')),
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
    return GridView.builder(
      controller: scrollController, // Usamos el ScrollController aquí
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio:
            0.8, // Ajustar según necesidad para que quepan imagen y texto
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: hasReachedMax ? pokemons.length : pokemons.length + 1,
      itemBuilder: (context, index) {
        if (index >= pokemons.length) {
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox();
        }
        final pokemon = pokemons[index];
        return Card(
          // Agregamos un Card para mejor visualización
          elevation: 2.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  // Para que la imagen ocupe el espacio disponible
                  child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.cover, // Para que la imagen cubra el espacio
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image,
                      size: 48); // Icono si falla
                },
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pokemon.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
