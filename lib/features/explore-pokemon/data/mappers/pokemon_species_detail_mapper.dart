import 'package:pokedex/features/explore-pokemon/data/mappers/pokemon_species_mapper.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_detail_entity.dart';

class PokemonSpeciesDetailMapper {
  const PokemonSpeciesDetailMapper._();

  static PokemonSpeciesDetail fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError("The provided JSON map cannot be null.");
    }

    return PokemonSpeciesDetail(
      pokemonSpecies: PokemonSpeciesMapper.fromJson(json["pokemon_species"] ?? {}),
      rate: json["rate"] ?? 0,
    );
  }

  static Map<String, dynamic> toJson(
          PokemonSpeciesDetail pokemonSpeciesDetail) =>
      {
        "pokemon_species":
            PokemonSpeciesMapper.toJson(pokemonSpeciesDetail.pokemonSpecies),
        "rate": pokemonSpeciesDetail.rate,
      };
}
