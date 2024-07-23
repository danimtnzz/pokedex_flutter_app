import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailMapper extends PokemonDetail {
  PokemonDetailMapper({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.height,
    required super.weight,
    required super.types,
    required super.abilities,
    required super.baseExperience,
    required super.stats,
    required super.moves,
  });

  factory PokemonDetailMapper.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final imageUrl = json['sprites']['front_default'] as String;
    final height = json['height'] as int;
    final weight = json['weight'] as int;

    final types = (json['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();

    final abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();

    final baseExperience = json['base_experience'] as int;

    final stats = (json['stats'] as List)
        .map((stat) =>
            '${stat['stat']['name']}: ${stat['base_stat']}')
        .toList();

    return PokemonDetailMapper(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      types: types,
      abilities: abilities,
      baseExperience: baseExperience,
      stats: stats, 
      moves: [],
    );
  }
}
