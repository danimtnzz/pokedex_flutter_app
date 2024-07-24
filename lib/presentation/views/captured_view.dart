import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/domain/entities/captured_pokemon.dart';
import 'package:pokedex_flutter_app/domain/repositories/captured_pokemon_repository.dart';
import 'package:pokedex_flutter_app/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex_flutter_app/presentation/widgets/filter_type_dialog.dart';
import 'package:provider/provider.dart';

class CapturedView extends StatefulWidget {
  const CapturedView({super.key});

  @override
  CapturedViewState createState() => CapturedViewState();
}

class CapturedViewState extends State<CapturedView> {
  String _sortOrder = 'id'; // 'id' or 'name'
  String _filterType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Capturados'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'sort_id' || value == 'sort_name') {
                setState(() {
                  _sortOrder = value.replaceFirst('sort_', '');
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'sort_id', child: Text('Ordenar por ID')),
              const PopupMenuItem(value: 'sort_name', child: Text('Ordenar por Nombre')),
              PopupMenuItem(
                value: 'filter_type',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterTypeDialog(
                        selectedType: _filterType,
                        onTypeSelected: (String type) {
                          setState(() {
                            _filterType = type;
                          });
                        },
                      );
                    },
                  );
                },
                child: const Text('Filtrar por Tipo'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<CapturedPokemonRepository>(
        builder: (context, repository, child) {
          return StreamBuilder<List<CapturedPokemon>>(
            stream: repository.watchAllCapturedPokemons(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay Pokémon capturados.'));
              } else {
                List<CapturedPokemon> pokemons = snapshot.data!;

                if (_filterType.isNotEmpty) {
                  pokemons = pokemons.where((p) => p.types.contains(_filterType)).toList();
                }

                if (_sortOrder == 'name') {
                  pokemons.sort((a, b) => a.name.compareTo(b.name));
                } else {
                  pokemons.sort((a, b) => a.pokemonId.compareTo(b.pokemonId));
                }

                return ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return Dismissible(
                      key: Key(pokemon.pokemonId.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        repository.deleteCapturedPokemon(pokemon.pokemonId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)} eliminado')),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text('${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}'),
                        subtitle: Text('ID: ${pokemon.pokemonId}'),
                        leading: Image.network(pokemon.imageUrl),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailScreen(pokemonId: pokemon.pokemonId),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

