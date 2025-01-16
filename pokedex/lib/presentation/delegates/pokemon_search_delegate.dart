import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/presentation/cubics/search/pokemon_search_cubit.dart';
import 'package:pokedex/presentation/widgets/pokemon/pokemon_details_helper.dart';

class PokemonSearchDelegate extends SearchDelegate<Pokemon?> {
  @override
  String? get searchFieldLabel => 'Look for a pokemon';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonSearchCubit()..searchPokemon(query),
      child: BlocBuilder<PokemonSearchCubit, PokemonSearchState>(
        builder: (context, state) {
          if (state is PokemonSearchInitial) {
            return const Center(child: Text('Look for a pokemon.'));
          } else if (state is PokemonSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonSearchLoaded) {
            return PokemonDetailsHelper().buildPokemonDetails(state.pokemon);
          } else if (state is PokemonSearchError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
        child: Text('Write the name of a Pokemon and press enter.'));
  }
}
