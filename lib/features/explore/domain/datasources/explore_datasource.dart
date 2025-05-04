import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_entity.dart';

abstract class ExploreDataSource {
  Future<List<PokemonSpecies>> getPokemonSpecies();
}
