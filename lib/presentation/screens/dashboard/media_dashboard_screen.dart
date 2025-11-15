import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/providers/search_provider.dart';
import 'package:nextupp/presentation/screens/completed_screen.dart';
import 'package:nextupp/presentation/screens/pending_screen.dart';
import 'package:nextupp/presentation/screens/search_screen.dart';

// Es un StatefulWidget porque necesita gestionar el PageController y el índice de la pestaña seleccionada.
class MediaDashboardScreen extends ConsumerStatefulWidget {
  final MediaType mediaType;

  const MediaDashboardScreen({required this.mediaType, super.key});

  @override
  ConsumerState<MediaDashboardScreen> createState() =>
      _MediaDashboardScreenState();
}

class _MediaDashboardScreenState extends ConsumerState<MediaDashboardScreen> {
  // Controlador para las páginas
  late final PageController _pageController;
  // Índice de la pestaña actual
  int _currentIndex = 0;

  // Lista de las pantallas que se mostrarán en las páginas
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Se inicializa la lista de pantallas pasándoles el mediaType
    _screens = [
      SearchScreen(mediaType: widget.mediaType),
      PendingScreen(mediaType: widget.mediaType),
      CompletedScreen(mediaType: widget.mediaType),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Se llama cuando se pulsa un icono de la BottomBar
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Se anima el PageView para que cambie de pantalla
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // El Cuerpo: PageView
      // Es como un 'LazyColumn' horizontal que se bloquea en cada página
      body: PageView(
        controller: _pageController,
        // Se desactiva el scroll con el dedo
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),

      // La Barra de Navegación Inferior (BottomBar)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Marca el icono seleccionado
        onTap: _onTabTapped, // Llama a la función al pulsar
        items: [
          // Pestaña de Búsqueda
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: l10n.nav_search_label,
          ),
          // Pestaña de Pendientes
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: l10n.nav_watchlist_label,
          ),
          // Pestaña de Completados
          BottomNavigationBarItem(
            icon: const Icon(Icons.check),
            label: l10n.nav_watched_label,
          ),
        ],
      ),
    );
  }
}