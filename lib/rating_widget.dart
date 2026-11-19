import 'package:flutter/material.dart';

import 'tema.dart';

/// Menampilkan rating produk dalam bentuk ikon bintang dan angka.
class RatingBintang extends StatelessWidget {
  final double rating;
  final double ukuran;

  const RatingBintang({super.key, required this.rating, this.ukuran = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber, size: ukuran),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: ukuran,
            fontWeight: FontWeight.w600,
            color: warnaTeks,
          ),
        ),
      ],
    );
  }
}
