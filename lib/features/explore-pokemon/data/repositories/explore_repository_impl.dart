import 'package:pokedex/features/explore-pokemon/data/datasources/explore_datasource_impl.dart';
import 'package:pokedex/features/explore-pokemon/domain/datasources/explore_datasource.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_detail_entity.dart';
import 'package:pokedex/features/explore-pokemon/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreDataSource dataSource;

  ExploreRepositoryImpl({ExploreDataSource? dataSource})
      : dataSource = dataSource ?? ExploreDataSourceImpl();

  @override
  Future<List<PokemonSpeciesDetail>> getPokemonSpecies() async {
    return await dataSource.getPokemonSpecies();
  }
}
