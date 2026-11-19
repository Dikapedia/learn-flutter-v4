import 'package:flutter/material.dart';

import 'main_page.dart';
import 'tema.dart';

void main() {
  runApp(const AplikasiKatalog());
}

class AplikasiKatalog extends StatelessWidget {
  const AplikasiKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Produk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: warnaUtama)
            .copyWith(primary: warnaUtama, secondary: warnaAksen),
        scaffoldBackgroundColor: warnaLatar,
        appBarTheme: const AppBarTheme(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const MainPage(),
    );
  }
}
