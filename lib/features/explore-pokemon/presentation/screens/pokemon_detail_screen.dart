import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/pokemon_map_notifier.dart';
import 'package:pokedex/features/explore-pokemon/presentation/providers/language_provider.dart';

class PokemonDetailScreen extends ConsumerWidget {
  final PokemonWithPosition pokemon;

  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLanguage = ref.watch(languageProvider).selectedLanguage;
    final pokemonDetail = pokemon.detail.pokemonSpecies.pokemonDetail;

    if (pokemonDetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(pokemon.detail.pokemonSpecies.name),
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('No se encontraron detalles para este Pokémon'),
        ),
      );
    }

    // Obtener título localizado
    String getLocalizedTitle() {
      switch (appLanguage) {
        case AppLanguage.spanish:
          return 'Detalles de ${pokemon.detail.pokemonSpecies.name}';
        case AppLanguage.english:
          return '${pokemon.detail.pokemonSpecies.name} Details';
        case AppLanguage.japanese:
          return '${pokemon.detail.pokemonSpecies.name}の詳細';
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con imagen y detalles básicos
            Container(
              color: Colors.red.shade50,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // ID y nombre
                  Text(
                    '#${pokemonDetail.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    pokemon.detail.pokemonSpecies.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),

                  // Tipos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemonDetail.types.map((type) {
                      return _TypeBadge(typeName: type.type.name);
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Imagen
                  Hero(
                    tag: 'pokemon-${pokemonDetail.id}',
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: pokemonDetail.sprites.frontDefault != null
                          ? Image.network(
                              pokemonDetail.sprites.frontDefault!,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.catching_pokemon,
                                size: 100,
                                color: Colors.red,
                              ),
                            )
                          : const Icon(
                              Icons.catching_pokemon,
                              size: 100,
                              color: Colors.red,
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Características físicas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Características',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _CharacteristicItem(
                            icon: Icons.monitor_weight,
                            label: 'Peso',
                            value: '${pokemonDetail.weight / 10} kg',
                          ),
                          _CharacteristicItem(
                            icon: Icons.height,
                            label: 'Altura',
                            value: '${pokemonDetail.height / 10} m',
                          ),
                          _CharacteristicItem(
                            icon: Icons.bolt,
                            label: 'Experiencia Base',
                            value: '${pokemonDetail.baseExperience}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Estadísticas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estadísticas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...pokemonDetail.stats.map((stat) {
                        return _StatBar(
                          statName: stat.stat.name,
                          value: stat.baseStat,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),

            // Habilidades
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Habilidades',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...pokemonDetail.abilities.map((ability) {
                        return ListTile(
                          leading: const Icon(
                            Icons.auto_awesome,
                            color: Colors.amber,
                          ),
                          title: Text(
                            ability.ability?.name ?? 'Desconocida',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: ability.isHidden
                              ? const Text('Habilidad oculta')
                              : null,
                          dense: true,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),

            // Botón para volver al mapa
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Volver al mapa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacteristicItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CharacteristicItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.red.shade700),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String typeName;

  const _TypeBadge({required this.typeName});

  Color _getTypeColor() {
    switch (typeName.toLowerCase()) {
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: _getTypeColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        typeName.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String statName;
  final int value;

  const _StatBar({
    required this.statName,
    required this.value,
  });

  String _getStatDisplayName() {
    switch (statName.toLowerCase()) {
      case 'hp':
        return 'PS';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'Ataque Esp.';
      case 'special-defense':
        return 'Defensa Esp.';
      case 'speed':
        return 'Velocidad';
      default:
        return statName;
    }
  }

  Color _getStatColor() {
    if (value < 50) {
      return Colors.red;
    } else if (value < 70) {
      return Colors.orange;
    } else if (value < 90) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Máximo valor de estadística para la barra de progreso (normalmente 255)
    const maxStatValue = 255.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              _getStatDisplayName(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getStatColor(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value / maxStatValue,
                backgroundColor: Colors.grey.shade200,
                color: _getStatColor(),
                minHeight: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
