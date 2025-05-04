import 'package:pokedex/features/explore-pokemon/data/repositories/explore_repository_impl.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/entities.dart';
import 'package:pokedex/features/explore-pokemon/domain/repositories/explore_repository.dart';

class ExploreUseCase {
  final ExploreRepository repository;

  ExploreUseCase({ExploreRepository? repository})
      : repository = repository ?? ExploreRepositoryImpl();

  Future<List<PokemonSpeciesDetail>> getPokemonSpecies() async {
    return await repository.getPokemonSpecies();
  }
}
