class PokemonDetail {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final int baseExperience;
  final List<String> moves;
  final List<String> stats;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.baseExperience,
    required this.moves,
    required this.stats,
  });
}
