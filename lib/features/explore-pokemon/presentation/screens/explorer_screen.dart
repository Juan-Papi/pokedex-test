import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';

class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-16.5, -64.5), // Un punto central en Bolivia
    zoom: 5.5,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonMapNotifierProvider);

    Set<Marker> markers = state.pokemons
        .map(
          (pokemon) => Marker(
            markerId: MarkerId(pokemon.detail.pokemonSpecies.name),
            position: pokemon.position,
            infoWindow: InfoWindow(title: pokemon.detail.pokemonSpecies.name),
          ),
        )
        .toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar Pokémon'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  markers: markers,
                ),
    );
  }
}
