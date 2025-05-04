import 'package:pokedex/features/explore/data/datasources/explore_datasource_impl.dart';
import 'package:pokedex/features/explore/domain/datasources/explore_datasource.dart';
import 'package:pokedex/features/explore/domain/repositories/explore_repository.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_entity.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreDataSource dataSource;

  ExploreRepositoryImpl({ExploreDataSource? dataSource})
      : dataSource = dataSource ?? ExploreDataSourceImpl();

  @override
  Future<List<PokemonSpecies>> getPokemonSpecies() async {
    return await dataSource.getPokemonSpecies();
  }
}
