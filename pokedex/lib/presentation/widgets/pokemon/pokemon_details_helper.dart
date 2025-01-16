import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon.dart';

class PokemonDetailsHelper {
  Widget buildPokemonDetails(Pokemon pokemon) {
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
