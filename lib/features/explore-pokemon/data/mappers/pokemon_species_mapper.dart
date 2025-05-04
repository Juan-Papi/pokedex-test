import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_entity.dart';

class PokemonSpeciesMapper {
  const PokemonSpeciesMapper._();

  static PokemonSpecies fromJson(Map<String, dynamic> json) => PokemonSpecies(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
      );

  static Map<String, dynamic> toJson(PokemonSpecies pokemonSpecies) => {
        "name": pokemonSpecies.name,
        "url": pokemonSpecies.url,
      };
}
