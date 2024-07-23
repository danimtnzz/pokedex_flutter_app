import '../../domain/entities/pokemon.dart';

class PokemonMapper extends Pokemon {
  PokemonMapper({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonMapper.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = _extractPokemonId(url);
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    return PokemonMapper(
      id: id,
      name: json['name'] as String,
      imageUrl: imageUrl,
    );
  }

  static int _extractPokemonId(String url) {
    final parts = url.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}
