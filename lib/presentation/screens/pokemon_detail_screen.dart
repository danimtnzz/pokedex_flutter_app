import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/domain/repositories/captured_pokemon_repository.dart';
import 'package:pokedex_flutter_app/presentation/widgets/pokemon_detail_content.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_flutter_app/presentation/providers/pokemon_details_provider.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  static const name = 'pokemon-details';
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonDetailProvider>(context, listen: false).fetchPokemonDetail(pokemonId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Consumer<PokemonDetailProvider>(
          builder: (context, provider, child) {
            final pokemonDetail = provider.pokemonDetail;
            return Text(
              pokemonDetail != null
                  ? '${pokemonDetail.name[0].toUpperCase()}${pokemonDetail.name.substring(1)}'
                  : 'Características',
            );
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<PokemonDetailProvider>(
            builder: (context, provider, child) {
              final pokemonDetail = provider.pokemonDetail;
              if (pokemonDetail == null) {
                return Container();
              }
              return FutureBuilder<bool>(
                future: Provider.of<CapturedPokemonRepository>(context, listen: false).isPokemonCaptured(pokemonId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final isCaptured = snapshot.data ?? false;
                  return IconButton(
                    onPressed: () async {
                      final repository = Provider.of<CapturedPokemonRepository>(context, listen: false);
                      if (isCaptured) {
                        await repository.deleteCapturedPokemon(pokemonDetail.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('¡${pokemonDetail.name[0].toUpperCase()}${pokemonDetail.name.substring(1)} eliminado de capturados!')),
                          );
                        }
                      } else {
                        final capturedPokemon = CapturedPokemon.fromPokemonDetail(pokemonDetail);
                        await repository.capturePokemon(capturedPokemon);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('¡${pokemonDetail.name[0].toUpperCase()}${pokemonDetail.name.substring(1)} capturado!')),
                          );
                        }
                      }
                    },
                    icon: Icon(
                      isCaptured ? Icons.check : Icons.catching_pokemon,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
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
          return PokemonDetailContent(pokemon: provider.pokemonDetail!);
        } else {
          return const Center(child: Text('No se encontraron detalles de ese Pokemon'));
        }
      },
    );
  }
}
