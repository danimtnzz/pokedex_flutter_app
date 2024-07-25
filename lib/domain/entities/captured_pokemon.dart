import 'package:hive/hive.dart';
import 'package:pokedex_flutter_app/domain/entities/pokemon_detail.dart';

part 'captured_pokemon.g.dart';

@HiveType(typeId: 0)
class CapturedPokemon {
  @HiveField(0)
  int pokemonId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  int height;

  @HiveField(4)
  int weight;

  @HiveField(5)
  List<String> types;

  @HiveField(6)
  List<String> abilities;

  @HiveField(7)
  int baseExperience;

  @HiveField(8)
  List<String> stats;

  CapturedPokemon({
    required this.pokemonId,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.baseExperience,
    required this.stats,
  });

  factory CapturedPokemon.fromPokemonDetail(PokemonDetail detail) {
    return CapturedPokemon(
      pokemonId: detail.id,
      name: detail.name,
      imageUrl: detail.imageUrl,
      height: detail.height,
      weight: detail.weight,
      types: detail.types,
      abilities: detail.abilities,
      baseExperience: detail.baseExperience,
      stats: detail.stats,
    );
  }
}
