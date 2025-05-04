import 'package:dio/dio.dart';
import 'package:pokedex/core/constants/app_api_constants.dart';
import 'package:pokedex/core/network/api_client.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_info_response_model.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_response_model.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_species_response_model.dart';
import 'package:pokedex/features/explore-pokemon/domain/datasources/explore_datasource.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/entities.dart';

class ExploreDataSourceImpl implements ExploreDataSource {
  final ApiClient apiClient = ApiClient();

  @override
  Future<List<PokemonSpeciesDetail>> getPokemonSpecies() async {
    try {
      var response = await apiClient.get(ApiConstants.pokemonSpeciesEndpoint);
      var mappedResponse = PokemonResponse.fromJson(response);

      final ApiClient apiDio = ApiClient(dio: Dio());

      await Future.wait(mappedResponse.pokemonSpeciesDetails
          .map((pokemonSpeciesDetail) async {
        response = await apiDio.get(pokemonSpeciesDetail.pokemonSpecies.url);
        PokemonSpeciesAboutResponse mappedResponse =
            PokemonSpeciesAboutResponse.fromJson(response);

        await Future.wait(mappedResponse.varieties.map((variety) async {
          response = await apiDio.get(variety.pokemon.url);
          PokemonDetail pokemonDetail = PokemonDetail.fromJson(response);
          variety.pokemon.pokemonDetail = pokemonDetail;
        }));
      }));

      return mappedResponse.pokemonSpeciesDetails;
    } catch (e) {
      rethrow;
    }
  }
}
