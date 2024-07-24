import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/domain/entities/pokemon_detail.dart';

class PokemonDetailContent extends StatelessWidget {
  final PokemonDetail pokemon;

  const PokemonDetailContent({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: ${pokemon.id}'),
            Text('Name: ${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'),
            Image.network(pokemon.imageUrl),
            Text('Height: ${pokemon.height}'),
            Text('Weight: ${pokemon.weight}'),
            Text('Types: ${pokemon.types.join(', ')}'),
            Text('Abilities: ${pokemon.abilities.join(', ')}'),
            Text('Base Experience: ${pokemon.baseExperience}'),
            ...pokemon.stats.map((stat) => Text(stat)),
          ],
        ),
      ),
    );
  }
}