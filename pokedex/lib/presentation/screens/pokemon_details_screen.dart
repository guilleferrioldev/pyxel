import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/cubics/details/details_cubit.dart';
import 'package:pokedex/presentation/widgets/pokemon/pokemon_details_helper.dart';

class PokemonDetailsScreen extends StatefulWidget {
  static const name = "pokemon-details";

  final String pokemonId;

  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetailsScreen> {
  late PokemonDetailsCubit _pokemonDetailsCubit;
  late PokemonDetailsHelper _detailsHelper;

  @override
  void initState() {
    super.initState();
    _pokemonDetailsCubit = PokemonDetailsCubit();
    _detailsHelper = PokemonDetailsHelper();
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
            return _detailsHelper.buildPokemonDetails(state.pokemon);
          } else if (state is PokemonError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Initial State'));
        },
      ),
    );
  }
}
