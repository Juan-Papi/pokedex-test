import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_entity.dart';

class PokemonSpeciesDetail {
  final PokemonSpecies pokemonSpecies;
  final int rate;

  PokemonSpeciesDetail({
    required this.pokemonSpecies,
    required this.rate,
  });
}
