import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/presentation/cubics/details/details_cubit.dart';

class PokemonDetailsScreen extends StatefulWidget {
  static const name = "pokemon-details";

  final String pokemonId;

  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetailsScreen> {
  late PokemonDetailsCubit _pokemonDetailsCubit;

  @override
  void initState() {
    super.initState();
    _pokemonDetailsCubit = PokemonDetailsCubit();
    _pokemonDetailsCubit.fetchPokemon(widget.pokemonId);
  }

  @override
  void dispose() {
    _pokemonDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Details'),
      ),
      body: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
        bloc: _pokemonDetailsCubit,
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoaded) {
            return _buildPokemonDetails(state.pokemon);
          } else if (state is PokemonError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Initial State'));
        },
      ),
    );
  }

  Widget _buildPokemonDetails(Pokemon pokemon) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(pokemon.imageUrl, width: 150, height: 150),
          Text('Name: ${pokemon.name}'),
          Text('Height: ${pokemon.height}'),
          Text('Weight: ${pokemon.weight}'),
          const SizedBox(height: 10),
          _buildAbilitiesContainer(pokemon.abilities),
        ],
      ),
    );
  }

  Widget _buildAbilitiesContainer(List<Ability> abilities) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Abilities:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          ...abilities.map((ability) => _buildAbilityItem(ability)),
        ],
      ),
    );
  }

  Widget _buildAbilityItem(Ability ability) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            '${ability.ability.name} ${ability.isHidden ? '(Hidden)' : ''}',
          ),
        ],
      ),
    );
  }
}
