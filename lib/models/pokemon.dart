class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final int hp;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hp,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // PokéAPI, les sprites dans
    // json['sprites']['front_default']
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      hp: json['stats'][0]['base_stat'],
      types:
          (json['types'] as List)
              .map((typeInfo) => typeInfo['type']['name'] as String)
              .toList(),
    );
  }
}
