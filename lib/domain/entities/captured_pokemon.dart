import 'package:isar/isar.dart';

part 'captured_pokemon.g.dart';

@Collection()
class CapturedPokemon {
  Id id = Isar.autoIncrement;

  late int pokemonId;
  late String name;
  late String imageUrl;
  late int height;
  late int weight;
  late List<String> types;
  late List<String> abilities;
  late int baseExperience;
  late List<String> stats;
}
