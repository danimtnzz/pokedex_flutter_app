import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Pokemon>> getPokemonList() async {
    return await remoteDataSource.getPokemonList();
  }

  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    return await remoteDataSource.getPokemonDetail(id);
  }
}
