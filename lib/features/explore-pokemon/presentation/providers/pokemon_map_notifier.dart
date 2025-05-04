import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_detail_entity.dart';
import 'package:pokedex/features/explore-pokemon/domain/usecases/explore_usecase.dart';

final exploreUseCaseProvider = Provider<ExploreUseCase>((ref) {
  return ExploreUseCase();
});
/// Provider para el PokemonMapNotifier
final pokemonMapNotifierProvider =
    StateNotifierProvider<PokemonMapNotifier, PokemonMapState>((ref) {
  final exploreUseCase = ref.read(exploreUseCaseProvider);
  final notifier = PokemonMapNotifier(exploreUseCase);
  notifier.loadPokemons(); // Carga inicial
  return notifier;
});

/// Notifier que carga y gestiona los Pokémon para mostrar en el mapa
class PokemonMapNotifier extends StateNotifier<PokemonMapState> {
  final ExploreUseCase _exploreUseCase;
  final Random _random = Random();

  PokemonMapNotifier(this._exploreUseCase) : super(PokemonMapState.initial());

  /// Límite geográfico aproximado del territorio de Bolivia
  static const double _minLat = -22.9;
  static const double _maxLat = -9.7;
  static const double _minLng = -69.6;
  static const double _maxLng = -57.4;

  /// Método para generar una latitud aleatoria dentro del rango
  double _randomLatitude() =>
      _minLat + _random.nextDouble() * (_maxLat - _minLat);

  /// Método para generar una longitud aleatoria dentro del rango
  double _randomLongitude() =>
      _minLng + _random.nextDouble() * (_maxLng - _minLng);

  /// Carga los Pokémon y asigna posiciones aleatorias en Bolivia
  Future<void> loadPokemons() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<PokemonSpeciesDetail> pokemonList =
          await _exploreUseCase.getPokemonSpecies();

      // Generar posiciones aleatorias para cada Pokémon
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

/// Clase que une el Pokémon con una posición LatLng
class PokemonWithPosition {
  final PokemonSpeciesDetail detail;
  final LatLng position;

  PokemonWithPosition({
    required this.detail,
    required this.position,
  });
}

/// Estado que contiene cada Pokémon con su posición en el mapa
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