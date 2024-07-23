import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_flutter_app/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_flutter_app/domain/entities/pokemon_detail.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonMapper>> getPokemonList();
  Future<PokemonDetail> getPokemonDetail(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<List<PokemonMapper>> getPokemonList() async {
    final response = await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((pokemon) => PokemonMapper.fromJson(pokemon)).toList();
    } else {
      throw Exception('Error al cargar Pokemon');
    }
  }

  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    final response = await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final types = (data['types'] as List).map((type) => type['type']['name'] as String).toList();
      final abilities = (data['abilities'] as List).map((ability) => ability['ability']['name'] as String).toList();
      final moves = (data['moves'] as List).map((move) => move['move']['name'] as String).toList();
      final stats = (data['stats'] as List).map((stat) => '${stat['stat']['name']}: ${stat['base_stat']}').toList();

      return PokemonDetail(
        id: data['id'],
        name: data['name'],
        imageUrl: data['sprites']['front_default'],
        height: data['height'],
        weight: data['weight'],
        types: types,
        abilities: abilities,
        baseExperience: data['base_experience'],
        moves: moves,
        stats: stats,
      );
    } else {
      throw Exception('Error al cargar los Pokemon details');
    }
  }
}