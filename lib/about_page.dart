import 'package:flutter/material.dart';

import 'tema.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: warnaAksenMuda,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: FlutterLogo(),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Katalog Produk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: warnaTeks,
                ),
              ),
              const SizedBox(height: 4),
              const Text('v1.0.0', style: TextStyle(color: warnaTeksLembut)),
              const SizedBox(height: 16),
              const Text(
                'Aplikasi katalog produk sederhana yang dibuat dengan Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(color: warnaTeksLembut, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
