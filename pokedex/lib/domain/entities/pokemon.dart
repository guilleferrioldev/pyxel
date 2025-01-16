class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonListing({required this.id, required this.name});
}

class Pokemon {
  final List<Ability> abilities;
  final int height;
  final int id;
  final String name;
  final int weight;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  Pokemon({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
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
