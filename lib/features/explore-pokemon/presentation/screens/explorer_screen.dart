import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/language_provider.dart';
import 'package:pokedex/features/explore-pokemon/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_info_response_model.dart';

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
            // Quitamos InfoWindow para usar nuestra propia UI al hacer tap
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Recargar los pokémon
              ref.read(pokemonMapNotifierProvider.notifier).loadPokemons();
              // Cerrar el panel de detalles si está abierto
              setState(() {
                _selectedPokemon = null;
              });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Recargar los pokémon
          ref.read(pokemonMapNotifierProvider.notifier).loadPokemons();
          // Cerrar el panel de detalles si está abierto
          setState(() {
            _selectedPokemon = null;
          });
        },
        backgroundColor: Colors.red.shade700,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

class PokemonPreviewCard extends StatelessWidget {
  final PokemonWithPosition pokemon;
  final VoidCallback onClose;
  final VoidCallback onViewDetails;

  const PokemonPreviewCard({
    super.key,
    required this.pokemon,
    required this.onClose,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final pokemonDetail = pokemon.detail.pokemonSpecies.pokemonDetail;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // Header con gradiente
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade700, Colors.red.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    pokemon.detail.pokemonSpecies.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // Botón de cerrar
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Detalles básicos
                if (pokemonDetail != null) ...[
                  Row(
                    children: [
                      // Imagen del Pokémon (si está disponible)
                      if (pokemonDetail.sprites.frontDefault != null)
                        Image.network(
                          pokemonDetail.sprites.frontDefault!,
                          height: 80,
                          width: 80,
                          errorBuilder: (_, __, ___) => Container(
                            height: 80,
                            width: 80,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.catching_pokemon, size: 40),
                          ),
                        ),
                      const SizedBox(width: 16),
                      // Info básica
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${pokemonDetail.id.toString().padLeft(3, '0')}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Tipos
                            Row(
                              children: pokemonDetail.types
                                  .map((type) => _PokemonTypeChip(type: type))
                                  .toList(),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Peso: ${pokemonDetail.weight / 10} kg',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Altura: ${pokemonDetail.height / 10} m',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                // Botón para ver detalles completos
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: onViewDetails,
                    child: const Text('Ver más información'),
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

class _PokemonTypeChip extends StatelessWidget {
  final Type type;

  const _PokemonTypeChip({required this.type});

  Color _getTypeColor() {
    switch (type.type.name.toLowerCase()) {
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'psychic':
        return Colors.purple;
      case 'fighting':
        return Colors.brown;
      case 'rock':
        return Colors.brown.shade300;
      case 'ground':
        return Colors.brown.shade200;
      case 'flying':
        return Colors.lightBlue;
      case 'bug':
        return Colors.lightGreen;
      case 'poison':
        return Colors.deepPurple;
      case 'normal':
        return Colors.grey.shade400;
      case 'ghost':
        return Colors.indigo;
      case 'dragon':
        return Colors.indigo.shade700;
      case 'dark':
        return Colors.grey.shade800;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pink;
      case 'ice':
        return Colors.lightBlue.shade100;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getTypeColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        type.type.name.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
