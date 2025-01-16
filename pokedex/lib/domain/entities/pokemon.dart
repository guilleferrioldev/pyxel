class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonListing({required this.id, required this.name});
}

class Pokemon {
  final List<Ability> abilities;
  final int baseExperience;
  final List<Species> forms;
  final int height;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final String name;
  final int order;
  final Species species;
  final int weight;

  Pokemon({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.height,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.name,
    required this.order,
    required this.species,
    required this.weight,
  });
}

class Ability {
  final Species ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });
}
