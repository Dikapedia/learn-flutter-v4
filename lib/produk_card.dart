import 'package:flutter/material.dart';

import 'gambar_widget.dart';
import 'rating_widget.dart';
import 'tema.dart';
import 'tombol_favorit.dart';

/// Kartu produk yang dipakai di Beranda, galeri Katalog, dan halaman Favorit.
class ProdukCard extends StatelessWidget {
  final Map<String, String> produk;
  final bool favorit;
  final VoidCallback onToggleFavorit;
  final VoidCallback onTap;

  const ProdukCard({
    super.key,
    required this.produk,
    required this.favorit,
    required this.onToggleFavorit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: warnaGaris),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: gambarProduk(produk['gambar']!),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: TombolFavorit(
                        namaProduk: produk['nama']!,
                        aktif: favorit,
                        onPressed: onToggleFavorit,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk['nama']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warnaTeks,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      produk['harga']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warnaHarga,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RatingBintang(
                      rating: double.tryParse(produk['rating'] ?? '') ?? 0,
                      ukuran: 13,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
