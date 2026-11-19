import 'package:flutter/material.dart';

import 'detail_produk.dart';
import 'grid_produk.dart';
import 'katalog.dart';
import 'produk_card.dart';
import 'tema.dart';

class FavoritPage extends StatelessWidget {
  final Set<String> favorit;
  final ValueChanged<String> onToggleFavorit;
  final VoidCallback onJelajahi;

  const FavoritPage({
    super.key,
    required this.favorit,
    required this.onToggleFavorit,
    required this.onJelajahi,
  });

  List<Map<String, String>> get _produkFavorit {
    return Katalog.items
        .where((produk) => favorit.contains(produk['nama']))
        .toList();
  }

  void _bukaDetail(BuildContext context, Map<String, String> produk) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: produk)),
    );
  }

  void _bukaKeranjang(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Keranjang masih kosong'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> produk = _produkFavorit;

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Favorit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: () => _bukaKeranjang(context),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: produk.isEmpty
          ? _kosong(context)
          : LayoutBuilder(
              builder: (context, constraints) {
                final int kolom = jumlahKolomProduk(constraints.maxWidth);

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: produk.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kolom,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: rasioKartuProduk,
                  ),
                  itemBuilder: (context, index) {
                    final Map<String, String> item = produk[index];

                    return ProdukCard(
                      produk: item,
                      favorit: true,
                      onToggleFavorit: () => onToggleFavorit(item['nama']!),
                      onTap: () => _bukaDetail(context, item),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _kosong(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
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
              child: const Icon(
                Icons.favorite_border,
                size: 44,
                color: warnaUtamaTua,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum ada produk favorit',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: warnaTeks,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tekan ikon hati pada produk untuk menyimpannya di halaman ini.',
              textAlign: TextAlign.center,
              style: TextStyle(color: warnaTeksLembut, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onJelajahi,
              style: ElevatedButton.styleFrom(
                backgroundColor: warnaUtama,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: const StadiumBorder(),
              ),
              child: const Text('Jelajahi Produk'),
            ),
          ],
        ),
      ),
    );
  }
}
