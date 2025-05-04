import 'package:pokedex/features/explore-pokemon/data/models/pokemon_info_response_model.dart';

class PokemonSpecies {
  final String name;
  PokemonDetail? pokemonDetail;
  final String url;

  PokemonSpecies({
    required this.name,
    required this.url,
    this.pokemonDetail,
  });
}
