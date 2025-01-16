class PokeapiListingResponse {
  final int count;
  final String next;
  final dynamic previous;
  final List<PokeapiPokemonListing> results;

  PokeapiListingResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokeapiListingResponse.fromJson(Map<String, dynamic> json) =>
      PokeapiListingResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokeapiPokemonListing>.from(
            json["results"].map((x) => PokeapiPokemonListing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PokeapiPokemonListing {
  final String name;
  final String url;

  PokeapiPokemonListing({
    required this.name,
    required this.url,
  });

  factory PokeapiPokemonListing.fromJson(Map<String, dynamic> json) =>
      PokeapiPokemonListing(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
