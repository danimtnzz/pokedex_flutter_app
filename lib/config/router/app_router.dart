import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter_app/presentation/screens/home_screen.dart';
import 'package:pokedex_flutter_app/presentation/screens/pokemon_detail_screen.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      }),
  GoRoute(
    path: '/pokemon/:id',
    name: PokemonDetailScreen.name,
    builder: (context, state) {
      final pokemonId = int.tryParse(state.pathParameters['id'] ?? '') ?? -1;
      if (pokemonId == -1) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Invalid Pokémon ID')),
        );
      }
      return PokemonDetailScreen(pokemonId: pokemonId);
    },
  ),
]);
