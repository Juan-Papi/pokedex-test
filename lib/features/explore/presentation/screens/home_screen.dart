import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/explore/presentation/providers/language_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade600,
              Colors.red.shade800,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Logo y título
                  const Icon(
                    Icons.catching_pokemon,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido a Pokédex',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Selecciona tu idioma preferido para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Tarjetas de selección de idioma
                  _LanguageSelectionCard(
                    language: AppLanguage.spanish,
                    icon: Icons.translate,
                    onTap: () =>
                        _selectLanguage(context, ref, AppLanguage.spanish),
                  ),
                  const SizedBox(height: 16),
                  _LanguageSelectionCard(
                    language: AppLanguage.english,
                    icon: Icons.language,
                    onTap: () =>
                        _selectLanguage(context, ref, AppLanguage.english),
                  ),
                  const SizedBox(height: 16),
                  _LanguageSelectionCard(
                    language: AppLanguage.japanese,
                    icon: Icons.public,
                    onTap: () =>
                        _selectLanguage(context, ref, AppLanguage.japanese),
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    '© 2025 Pokémon API',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectLanguage(
      BuildContext context, WidgetRef ref, AppLanguage language) {
    // Actualizar el estado del idioma
    ref.read(languageProvider.notifier).setLanguage(language);

    // Mostrar un snackbar con la selección
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idioma seleccionado: ${language.name}'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade700,
      ),
    );

    // Aquí puedes navegar a la siguiente pantalla
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => const PokemonListScreen()),
    // );
    context.push('/explore');

    // Por ahora, simplemente mostraremos un mensaje
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Idioma configurado'),
          content: Text(
            'La aplicación ahora usará el idioma ${language.name} (${language.code}).\n\n'
            'Implementa la navegación a la siguiente pantalla aquí.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}

class _LanguageSelectionCard extends StatelessWidget {
  final AppLanguage language;
  final IconData icon;
  final VoidCallback onTap;

  const _LanguageSelectionCard({
    required this.language,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, size: 32, color: Colors.red.shade700),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      language.code,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
