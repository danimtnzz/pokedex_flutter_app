import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';
import 'package:pokedex_flutter_app/domain/entities/pokemon_detail.dart';

class CapturedPokemonRepository with ChangeNotifier {
  late Future<Isar> _db;

  CapturedPokemonRepository() {
    _db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [CapturedPokemonSchema],
      directory: dir.path,
    );
  }

  Future<void> capturePokemon(PokemonDetail pokemonDetail) async {
    final isar = await _db;
    final capturedPokemon = CapturedPokemon()
      ..pokemonId = pokemonDetail.id
      ..name = pokemonDetail.name
      ..imageUrl = pokemonDetail.imageUrl
      ..height = pokemonDetail.height
      ..weight = pokemonDetail.weight
      ..types = pokemonDetail.types
      ..abilities = pokemonDetail.abilities
      ..baseExperience = pokemonDetail.baseExperience
      ..stats = pokemonDetail.stats;

    await isar.writeTxn(() async {
      final existingPokemon = await isar.capturedPokemons.filter().pokemonIdEqualTo(pokemonDetail.id).findFirst();
      if (existingPokemon != null) {
        await isar.capturedPokemons.delete(existingPokemon.id);
      } 
      await isar.capturedPokemons.put(capturedPokemon);
    });

    notifyListeners();
  }

  Stream<List<CapturedPokemon>> watchAllCapturedPokemons() async* {
    final isar = await _db;
    yield* isar.capturedPokemons.where().watch(fireImmediately: true);
  }

  Future<void> deleteCapturedPokemon(int pokemonId) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.capturedPokemons
          .filter()
          .pokemonIdEqualTo(pokemonId)
          .deleteFirst();
    });

    notifyListeners();
  }

  Future<bool> isPokemonCaptured(int pokemonId) async {
    final isar = await _db;
    final existingPokemon = await isar.capturedPokemons.filter().pokemonIdEqualTo(pokemonId).findFirst();
    return existingPokemon != null;
  }

  Future<Map<String, int>> countPokemonTypes() async {
    final isar = await _db;
    return await isar.txn(() async {
      final pokemons = await isar.capturedPokemons.where().findAll();
      final typeCounts = <String, int>{};

      for (final pokemon in pokemons) {
        for (final type in pokemon.types) {
          if (typeCounts.containsKey(type)) {
            typeCounts[type] = typeCounts[type]! + 1;
          } else {
            typeCounts[type] = 1;
          }
        }
      }

      return typeCounts;
    });
  }
}
