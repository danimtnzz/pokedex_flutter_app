import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/domain/entities/pokemon_detail.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_flutter_app/presentation/providers/pokemon_details_provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  static const name = 'pokemon-details';
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    // Fetch the pokemon detail when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonDetailProvider>(context, listen: false)
          .fetchPokemonDetail(pokemonId);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Details')),
      body: _PokemonDetailBody(),
    );
  }
}

class _PokemonDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonDetailProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        } else if (provider.pokemonDetail != null) {
          return _PokemonDetailContent(pokemon: provider.pokemonDetail!);
        } else {
          return const Center(child: Text('No se encontraron detalles de ese Pokemon'));
        }
      },
    );
  }
}

class _PokemonDetailContent extends StatelessWidget {
  final PokemonDetail pokemon;

  const _PokemonDetailContent({required this.pokemon});

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
