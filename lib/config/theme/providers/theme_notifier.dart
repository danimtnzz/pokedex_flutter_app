import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/config/theme/pokemon_type_colors.dart';
import 'package:pokedex_flutter_app/domain/repositories/captured_pokemon_repository.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._repository) {
    _init();
  }

  final CapturedPokemonRepository _repository;
  Color _themeColor = Colors.red;

  Color get themeColor => _themeColor;

  Future<void> _init() async {
    await _updateThemeColor();
  }

  Future<void> _updateThemeColor() async {
    final typeCounts = await _repository.countPokemonTypes();
    if (typeCounts.isNotEmpty) {
      final dominantType = typeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
      _themeColor = pokemonTypeColors[dominantType] ?? Colors.red;
    } else {
      _themeColor = Colors.red; // Default color if no Pokémon are captured
    }
    notifyListeners();
  }

}
