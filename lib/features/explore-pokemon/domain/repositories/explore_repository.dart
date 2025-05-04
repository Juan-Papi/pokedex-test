import 'package:pokedex/features/explore-pokemon/domain/entities/entities.dart';

abstract class ExploreRepository {
  Future<List<PokemonSpeciesDetail>> getPokemonSpecies();
}
