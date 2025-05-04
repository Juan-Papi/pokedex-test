import 'package:pokedex/core/constants/app_api_constants.dart';
import 'package:pokedex/core/network/api_client.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_response_model.dart';
import 'package:pokedex/features/explore-pokemon/domain/datasources/explore_datasource.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/entities.dart';

class ExploreDataSourceImpl implements ExploreDataSource {
  final ApiClient apiClient = ApiClient();

  @override
  Future<List<PokemonSpeciesDetail>> getPokemonSpecies() async {
    try {
      final response = await apiClient.get(ApiConstants.pokemonSpeciesEndpoint);
      final mappedResponse = PokemonResponse.fromJson(response);
      return mappedResponse.pokemonSpeciesDetails;
    } catch (e) {
      rethrow;
    }
  }
}
