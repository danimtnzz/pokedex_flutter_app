import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import '../widgets/pokemon_list.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  PokedexViewState createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar Pokemon',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 207, 207, 207),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  _filterPokemon(context, value);
                },
              ),
            ),
            Expanded(
              child: Consumer<PokemonProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.errorMessage != null) {
                    return Center(child: Text(provider.errorMessage!));
                  } else {
                    return PokemonList(pokemonList: provider.pokemonList);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterPokemon(BuildContext context, String query) {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    provider.filterPokemonList(query);
  }
}
