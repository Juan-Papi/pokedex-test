
import 'package:pokedex/core/constants/app_api_constants.dart';
import 'package:pokedex/core/network/api_client.dart';
import 'package:pokedex/features/explore/domain/datasources/explore_datasource.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_species_entity.dart';

class ExploreDataSourceImpl implements ExploreDataSource{
   final ApiClient apiClient = ApiClient();
   
     @override
     Future<List<PokemonSpecies>> getPokemonSpecies() {
    // TODO: implement getPokemonSpecies
    throw UnimplementedError();
     }
   
  // @override
  // Future<List<PokemonSpecies>> getPokemonSpecies() {
  //   final response = await apiClient.get(ApiConstants.pokemonSpeciesEndpoint);
  //   // TODO: implement getPokemonSpecies
  //   throw UnimplementedError();
  // }

}