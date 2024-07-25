import 'package:hive/hive.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';

class CapturedPokemonDataSource {
  late Box<CapturedPokemon> _capturedPokemonBox;

  CapturedPokemonDataSource() {
    _initDb();
  }

  Future<void> _initDb() async {
    _capturedPokemonBox = await Hive.openBox<CapturedPokemon>('capturedPokemonBox');
  }

  Future<void> addOrUpdateCapturedPokemon(CapturedPokemon pokemon) async {
    await _initDb();
    final existingPokemonKey = _capturedPokemonBox.keys.firstWhere(
      (key) => _capturedPokemonBox.get(key)!.pokemonId == pokemon.pokemonId,
      orElse: () => null,
    );

    if (existingPokemonKey != null) {
      await _capturedPokemonBox.put(existingPokemonKey, pokemon);
    } else {
      await _capturedPokemonBox.add(pokemon);
    }
  }

  Stream<List<CapturedPokemon>> watchAllCapturedPokemons() async* {
    await _initDb();
    yield* Stream.periodic(const Duration(milliseconds: 500), (_) {
      return _capturedPokemonBox.values.toList();
    });
  }

  Future<void> deleteCapturedPokemon(int pokemonId) async {
    await _initDb();
    final keyToDelete = _capturedPokemonBox.keys.firstWhere(
      (key) => _capturedPokemonBox.get(key)!.pokemonId == pokemonId,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await _capturedPokemonBox.delete(keyToDelete);
    }
  }

  Future<bool> isPokemonCaptured(int pokemonId) async {
    await _initDb();
    return _capturedPokemonBox.values.any((pokemon) => pokemon.pokemonId == pokemonId);
  }

  Future<Map<String, int>> countPokemonTypes() async {
    await _initDb();
    final typeCounts = <String, int>{};

    for (final pokemon in _capturedPokemonBox.values) {
      for (final type in pokemon.types) {
        if (typeCounts.containsKey(type)) {
          typeCounts[type] = typeCounts[type]! + 1;
        } else {
          typeCounts[type] = 1;
        }
      }
    }

    return typeCounts;
  }
}
