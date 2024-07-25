import 'package:flutter/foundation.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';

abstract class CapturedPokemonRepository extends ChangeNotifier {
  Future<void> capturePokemon(CapturedPokemon pokemon);
  Stream<List<CapturedPokemon>> watchAllCapturedPokemons();
  Future<void> deleteCapturedPokemon(int pokemonId);
  Future<bool> isPokemonCaptured(int pokemonId);
  Future<Map<String, int>> countPokemonTypes();
}
