import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_detail_entity.dart';
import 'package:pokedex/features/explore-pokemon/domain/usecases/explore_usecase.dart';

final exploreUseCaseProvider = Provider<ExploreUseCase>((ref) {
  return ExploreUseCase();
});

final pokemonMapNotifierProvider =
    StateNotifierProvider<PokemonMapNotifier, PokemonMapState>((ref) {
  final exploreUseCase = ref.read(exploreUseCaseProvider);
  final notifier = PokemonMapNotifier(exploreUseCase);
  notifier.loadPokemons(); 
  return notifier;
});


class PokemonMapNotifier extends StateNotifier<PokemonMapState> {
  final ExploreUseCase _exploreUseCase;
  final Random _random = Random();

  PokemonMapNotifier(this._exploreUseCase) : super(PokemonMapState.initial());


  static const double _minLat = -22.9;
  static const double _maxLat = -9.7;
  static const double _minLng = -69.6;
  static const double _maxLng = -57.4;

  double _randomLatitude() =>
      _minLat + _random.nextDouble() * (_maxLat - _minLat);

  double _randomLongitude() =>
      _minLng + _random.nextDouble() * (_maxLng - _minLng);

  Future<void> loadPokemons() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<PokemonSpeciesDetail> pokemonList =
          await _exploreUseCase.getPokemonSpecies();

      final List<PokemonWithPosition> pokemonsWithPositions = pokemonList
          .map(
            (detail) => PokemonWithPosition(
              detail: detail,
              position: LatLng(_randomLatitude(), _randomLongitude()),
            ),
          )
          .toList();

      state = state.copyWith(pokemons: pokemonsWithPositions, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Error al cargar Pokémon: $e');
    }
  }
}

class PokemonWithPosition {
  final PokemonSpeciesDetail detail;
  final LatLng position;

  PokemonWithPosition({
    required this.detail,
    required this.position,
  });
}

class PokemonMapState {
  final List<PokemonWithPosition> pokemons;
  final bool isLoading;
  final String? error;

  PokemonMapState({
    required this.pokemons,
    required this.isLoading,
    this.error,
  });

  PokemonMapState copyWith({
    List<PokemonWithPosition>? pokemons,
    bool? isLoading,
    String? error,
  }) {
    return PokemonMapState(
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory PokemonMapState.initial() {
    return PokemonMapState(pokemons: [], isLoading: false, error: null);
  }
}