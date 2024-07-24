import 'package:pokedex_flutter_app/domain/repositories/captured_pokemon_repository.dart';
import 'package:pokedex_flutter_app/presentation/providers/pokemon_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_flutter_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_flutter_app/presentation/providers/pokemon_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pokedex_flutter_app/domain/repositories/pokemon_repository.dart';

List<SingleChildWidget> providers = [ 
  Provider<PokemonRepository>(
    create: (_) => PokemonRepositoryImpl(
      PokemonRemoteDataSourceImpl(http.Client()),
    ),
  ),
  ChangeNotifierProvider<PokemonProvider>(
    create: (context) => PokemonProvider(context.read<PokemonRepository>())..fetchPokemonList(),
  ),
  ChangeNotifierProvider<PokemonDetailProvider>(
    create: (context) => PokemonDetailProvider(context.read<PokemonRepository>()),
  ),
  ChangeNotifierProvider<CapturedPokemonRepository>(
    create: (_) => CapturedPokemonRepository(),
  ),
];
