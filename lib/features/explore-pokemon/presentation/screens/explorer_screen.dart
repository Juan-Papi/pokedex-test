import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/language_provider.dart';

class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-16.5, -64.5), // Un punto central en Bolivia
    zoom: 5.5,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchar el estado del mapa
    final state = ref.watch(pokemonMapNotifierProvider);
    // Obtener el idioma actual
    final appLanguage = ref.watch(languageProvider).selectedLanguage;

    // Crear marcadores para los pokémon
    Set<Marker> markers = state.pokemons
        .map(
          (pokemon) => Marker(
            markerId: MarkerId(pokemon.detail.pokemonSpecies.name),
            position: pokemon.position,
            infoWindow: InfoWindow(title: pokemon.detail.pokemonSpecies.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        )
        .toSet();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLanguage == AppLanguage.spanish
              ? 'Explorar Pokémon'
              : appLanguage == AppLanguage.english
                  ? 'Explore Pokémon'
                  : 'ポケモンを探す',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Recargar los pokémon
              ref.read(pokemonMapNotifierProvider.notifier).loadPokemons();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.red),
                        SizedBox(height: 16),
                        Text('Cargando Pokémon...'),
                      ],
                    ),
                  )
                : state.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 64, color: Colors.red),
                            SizedBox(height: 16),
                            Text(
                              state.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(pokemonMapNotifierProvider.notifier)
                                    .loadPokemons();
                              },
                              child: const Text('Intentar de nuevo'),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: _initialCameraPosition,
                            markers: markers,
                            mapType: MapType.normal,
                            myLocationEnabled: false,
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              // Puedes guardar el controller si lo necesitas más tarde
                            },
                          ),
                          // Contador de Pokémon en la esquina
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.catching_pokemon,
                                      color: Colors.red),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${state.pokemons.length}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Recargar los pokémon
          ref.read(pokemonMapNotifierProvider.notifier).loadPokemons();
        },
        backgroundColor: Colors.red.shade700,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}