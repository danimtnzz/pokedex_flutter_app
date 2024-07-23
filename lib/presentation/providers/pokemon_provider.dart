import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonRepository repository;
  List<Pokemon> _pokemonList = [];
  List<Pokemon> _filteredPokemonList = [];
  bool _isLoading = false;
  String? _errorMessage;

  PokemonProvider(this.repository) {
    fetchPokemonList();
  }

  List<Pokemon> get pokemonList => _filteredPokemonList.isEmpty ? _pokemonList : _filteredPokemonList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pokemonList = await repository.getPokemonList();
    } catch (e) {
      _errorMessage = 'Error al cargar Pokemons';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterPokemonList(String query) {
    if (query.isEmpty) {
      _filteredPokemonList = [];
    } else {
      _filteredPokemonList = _pokemonList.where((pokemon) =>
        pokemon.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}
