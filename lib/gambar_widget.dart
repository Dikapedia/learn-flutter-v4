import 'package:flutter/material.dart';

/// Menampilkan gambar produk.
///
/// - Jika [sumber] berupa URL http/https, gambar diambil dengan
///   [Image.network] beserta indikator loading dan penanganan error.
/// - Jika bukan URL, gambar dibaca dari aset lokal (misalnya
///   `assets/images/kaos.jpg`).
///
/// Parameter [size] bersifat opsional untuk mengatur lebar dan tinggi gambar.
Widget gambarProduk(String sumber, {double? size}) {
  final bool dariInternet =
      sumber.startsWith('http://') || sumber.startsWith('https://');

  if (dariInternet) {
    return Image.network(
      sumber,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.image_not_supported),
    );
  }

  return Image.asset(
    sumber,
    width: size,
    height: size,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) =>
        const Icon(Icons.image_not_supported),
  );
}
