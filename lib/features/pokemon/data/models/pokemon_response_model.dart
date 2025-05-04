import 'package:pokedex/features/pokemon/data/mappers/mappers.dart';
import 'package:pokedex/features/pokemon/domain/entities/entities.dart';

class PokemonResponse {
  final int id;
  final String name;
  final List<PokemonSpeciesDetail> pokemonSpeciesDetails;
  final List<PokemonSpecies> pokemonRequiredForEvolution;

  PokemonResponse({
    required this.id,
    required this.name,
    required this.pokemonSpeciesDetails,
    required this.pokemonRequiredForEvolution,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        id: json["id"],
        name: json["name"],
        pokemonSpeciesDetails: List<PokemonSpeciesDetail>.from(
            json["pokemon_species_details"]
                .map((x) => PokemonSpeciesDetailMapper.fromJson(x))),
        pokemonRequiredForEvolution: List<PokemonSpecies>.from(
            json["required_for_evolution"]
                .map((x) => PokemonSpeciesMapper.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pokemon_species_details": List<dynamic>.from(pokemonSpeciesDetails
            .map((x) => PokemonSpeciesDetailMapper.toJson(x))),
        "required_for_evolution": List<dynamic>.from(pokemonRequiredForEvolution
            .map((x) => PokemonSpeciesMapper.toJson(x))),
      };
}
