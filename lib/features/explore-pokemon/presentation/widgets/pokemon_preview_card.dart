import 'package:flutter/material.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';
import 'package:pokedex/features/explore-pokemon/data/models/pokemon_info_response_model.dart';

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
