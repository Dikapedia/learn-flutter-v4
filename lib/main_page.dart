import 'package:flutter/material.dart';

import 'beranda_page.dart';
import 'favorit_page.dart';
import 'katalog.dart';
import 'tema.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final Set<String> _favorit = <String>{};

  void _pilihTab(int index) {
    setState(() {
      _index = index;
    });
  }

  void _toggleFavorit(String namaProduk) {
    setState(() {
      if (!_favorit.add(namaProduk)) {
        _favorit.remove(namaProduk);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      body: IndexedStack(
        index: _index,
        children: [
          BerandaPage(
            favorit: _favorit,
            onToggleFavorit: _toggleFavorit,
            onLihatSemua: () => _pilihTab(1),
          ),
          Katalog(
            favorit: _favorit,
            onToggleFavorit: _toggleFavorit,
            onBeranda: () => _pilihTab(0),
          ),
          FavoritPage(
            favorit: _favorit,
            onToggleFavorit: _toggleFavorit,
            onJelajahi: () => _pilihTab(0),
          ),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: warnaLatarNav,
          border: Border(top: BorderSide(color: warnaGaris)),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: warnaAksenMuda,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final bool dipilih = states.contains(WidgetState.selected);

              return TextStyle(
                fontSize: 12,
                fontWeight: dipilih ? FontWeight.w600 : FontWeight.w500,
                color: warnaTeks,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              final bool dipilih = states.contains(WidgetState.selected);

              return IconThemeData(
                size: 24,
                color: dipilih ? warnaUtamaTua : warnaTeksLembut,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: _pilihTab,
            height: 72,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: warnaAksenMuda,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: 'Katalog',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
