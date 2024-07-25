import 'package:flutter/foundation.dart';
import 'package:pokedex_flutter_app/data/datasources/captured_pokemon_datasource.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';
import 'package:pokedex_flutter_app/domain/repositories/captured_pokemon_repository.dart';

class CapturedPokemonRepositoryImpl extends ChangeNotifier implements CapturedPokemonRepository {
  final CapturedPokemonDataSource _dataSource;

  CapturedPokemonRepositoryImpl(this._dataSource);

  @override
  Future<void> capturePokemon(CapturedPokemon pokemon) async {
    await _dataSource.addOrUpdateCapturedPokemon(pokemon);
    notifyListeners();
  }

  @override
  Stream<List<CapturedPokemon>> watchAllCapturedPokemons() {
    return _dataSource.watchAllCapturedPokemons();
  }

  @override
  Future<void> deleteCapturedPokemon(int pokemonId) async {
    await _dataSource.deleteCapturedPokemon(pokemonId);
    notifyListeners();
  }

  @override
  Future<bool> isPokemonCaptured(int pokemonId) async {
    return _dataSource.isPokemonCaptured(pokemonId);
  }

  @override
  Future<Map<String, int>> countPokemonTypes() async {
    return _dataSource.countPokemonTypes();
  }
}
