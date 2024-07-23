import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemonList;

  const PokemonList({
    required this.pokemonList,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        return ListTile(
          onTap: () {
            context.push('/pokemon/${pokemon.id}');
          },
          leading: CachedNetworkImage(
            imageUrl: pokemon.imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text('${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'),
        );
      },
    );
  }
}
