import 'package:pokedex/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:pokedex/features/explore/domain/repositories/explore_repository.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_entity.dart';

class ExploreUseCase {
  final ExploreRepository repository;

  ExploreUseCase({ExploreRepository? repository})
      : repository = repository ?? ExploreRepositoryImpl();

  Future<List<PokemonSpecies>> getPokemonSpecies() async {
    return await repository.getPokemonSpecies();
  }
}
