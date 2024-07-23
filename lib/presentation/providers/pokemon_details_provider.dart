import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonDetailProvider with ChangeNotifier {
  final PokemonRepository repository;
  PokemonDetail? _pokemonDetail;
  bool _isLoading = false;
  String? _errorMessage;

  PokemonDetailProvider(this.repository);

  PokemonDetail? get pokemonDetail => _pokemonDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonDetail(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pokemonDetail = await repository.getPokemonDetail(id);
    } catch (e) {
      _errorMessage = 'Error al cargar los Pokemon details';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
