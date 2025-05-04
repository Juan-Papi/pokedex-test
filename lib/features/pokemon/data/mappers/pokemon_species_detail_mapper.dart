import 'package:pokedex/features/pokemon/data/mappers/pokemon_species_mapper.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_detail_entity.dart';

class PokemonSpeciesDetailMapper {
  const PokemonSpeciesDetailMapper._();

  static PokemonSpeciesDetail fromJson(Map<String, dynamic> json) =>
      PokemonSpeciesDetail(
        pokemonSpecies: PokemonSpeciesMapper.fromJson(json["pokemon_species"]),
        rate: json["rate"],
      );

  static Map<String, dynamic> toJson(
          PokemonSpeciesDetail pokemonSpeciesDetail) =>
      {
        "pokemon_species":
            PokemonSpeciesMapper.toJson(pokemonSpeciesDetail.pokemonSpecies),
        "rate": pokemonSpeciesDetail.rate,
      };
}
