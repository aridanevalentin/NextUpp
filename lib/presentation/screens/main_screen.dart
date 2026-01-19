import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nextupp/core/theme/app_theme.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/screens/dashboard_screen.dart';
import 'package:nextupp/presentation/screens/library_screen.dart';
import 'package:nextupp/presentation/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true, // Content behind bottom bar
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppTheme.accent,
                unselectedItemColor: Colors.white60,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.house_outlined),
                    ),
                    activeIcon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.house),
                    ),
                    label: l10n.homeTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.search_outlined),
                    ),
                    activeIcon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.search),
                    ),
                    label: l10n.searchTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.video_library_outlined),
                    ),
                    activeIcon: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.video_library),
                    ),
                    label: l10n.libraryTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
