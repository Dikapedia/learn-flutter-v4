import 'package:flutter/material.dart';

import 'tema.dart';

/// Tombol favorit yang statusnya dikendalikan oleh halaman induk.
class TombolFavorit extends StatelessWidget {
  final String namaProduk;
  final bool aktif;
  final VoidCallback onPressed;

  const TombolFavorit({
    super.key,
    required this.namaProduk,
    required this.aktif,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: aktif ? 'Hapus dari favorit' : 'Tambah ke favorit',
      iconSize: 22,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      icon: Icon(
        aktif ? Icons.favorite : Icons.favorite_border,
        color: aktif ? Colors.redAccent : warnaTeksLembut,
      ),
      onPressed: () {
        onPressed();

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              content: Text(
                aktif
                    ? '$namaProduk dihapus dari favorit'
                    : '$namaProduk ditambahkan ke favorit',
              ),
            ),
          );
      },
    );
  }
}
