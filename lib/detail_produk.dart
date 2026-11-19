import 'package:flutter/material.dart';

import 'gambar_widget.dart';
import 'rating_widget.dart';
import 'tema.dart';

class DetailProduk extends StatelessWidget {
  final Map<String, String> produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: Text(
          produk['nama']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Gambar produk
          Container(
            height: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: warnaGaris),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: gambarProduk(produk['gambar']!),
          ),
          const SizedBox(height: 18),

          // Nama & harga
          Text(
            produk['nama']!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: warnaTeks,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            produk['harga']!,
            style: const TextStyle(
              fontSize: 20,
              color: warnaHarga,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Rating
          Row(
            children: [
              const Text('Rating :', style: TextStyle(color: warnaTeksLembut)),
              const SizedBox(width: 8),
              RatingBintang(
                rating: double.tryParse(produk['rating'] ?? '') ?? 0,
                ukuran: 18,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Kategori
          Row(
            children: [
              const Icon(Icons.sell_outlined, size: 20, color: warnaUtamaTua),
              const SizedBox(width: 8),
              const Text(
                'Kategori :',
                style: TextStyle(color: warnaTeksLembut),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(produk['kategori']!),
                backgroundColor: warnaAksenMuda,
                labelStyle: const TextStyle(
                  color: warnaUtamaTua,
                  fontWeight: FontWeight.w500,
                ),
                side: BorderSide.none,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Deskripsi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: warnaGaris),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 20,
                      color: warnaUtamaTua,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: warnaTeks,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  produk['deskripsi']!,
                  style: const TextStyle(color: warnaTeksLembut, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tombol simulasi keranjang
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: warnaUtama,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text(
              'Tambah ke Keranjang',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${produk['nama']} ditambahkan ke keranjang'),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
