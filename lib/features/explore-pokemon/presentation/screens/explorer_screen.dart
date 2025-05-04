import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/language_provider.dart';
import 'package:pokedex/features/explore-pokemon/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex/features/explore-pokemon/presentation/widgets/pokemon_preview_card.dart';

class ExplorerScreen extends ConsumerStatefulWidget {
  const ExplorerScreen({super.key});

  @override
  ConsumerState<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends ConsumerState<ExplorerScreen> {
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-16.5, -64.5), // Un punto central en Bolivia
    zoom: 5.5,
  );

  PokemonWithPosition? _selectedPokemon;
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonMapNotifierProvider);
    final appLanguage = ref.watch(languageProvider).selectedLanguage;

    Set<Marker> markers = state.pokemons
        .map(
          (pokemon) => Marker(
            markerId: MarkerId(pokemon.detail.pokemonSpecies.name),
            position: pokemon.position,
            infoWindow: InfoWindow(
              title: pokemon.detail.pokemonSpecies.name,
            ),
            onTap: () {
              // Guardar el Pokémon seleccionado y centrar el mapa
              setState(() {
                _selectedPokemon = pokemon;
              });
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(pokemon.position),
              );
            },
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        )
        .toSet();

    String getLocalizedTitle() {
      switch (appLanguage) {
        case AppLanguage.spanish:
          return 'Explorar Pokémon';
        case AppLanguage.english:
          return 'Explore Pokémon';
        case AppLanguage.japanese:
          return 'ポケモンを探す';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getLocalizedTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        actions: [],
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
                              _mapController = controller;
                            },
                            onTap: (LatLng position) {
                              // Cerrar la card al tocar en otro lugar del mapa
                              setState(() {
                                _selectedPokemon = null;
                              });
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

                          // Card de detalles cuando un Pokémon está seleccionado
                          if (_selectedPokemon != null)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: PokemonPreviewCard(
                                pokemon: _selectedPokemon!,
                                onClose: () {
                                  setState(() {
                                    _selectedPokemon = null;
                                  });
                                },
                                onViewDetails: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PokemonDetailScreen(
                                        pokemon: _selectedPokemon!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
