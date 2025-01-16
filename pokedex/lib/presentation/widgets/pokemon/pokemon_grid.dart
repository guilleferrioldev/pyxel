import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/domain/entities/pokemon.dart';

class PokemonGrid extends StatelessWidget {
  final ScrollController scrollController;
  final bool hasReachedMax;
  final bool isLoading;
  final List<PokemonListing> pokemons;
  const PokemonGrid({
    super.key,
    required this.scrollController,
    required this.hasReachedMax,
    required this.isLoading,
    required this.pokemons,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
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

        return GridIem(pokemon: pokemon);
      },
    );
  }
}

class GridIem extends StatelessWidget {
  const GridIem({
    super.key,
    required this.pokemon,
  });

  final PokemonListing pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/pokemons/pokemon/${pokemon.id}'),
      child: Card(
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Image.network(
              pokemon.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 48);
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pokemon.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
