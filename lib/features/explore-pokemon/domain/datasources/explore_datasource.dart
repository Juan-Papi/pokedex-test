import 'package:pokedex/features/explore-pokemon/domain/entities/entities.dart';

abstract class ExploreDataSource {
  Future<List<PokemonSpeciesDetail>> getPokemonSpecies();
}
