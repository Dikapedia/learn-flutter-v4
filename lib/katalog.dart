import 'package:flutter/material.dart';

import 'about_page.dart';
import 'detail_produk.dart';
import 'gambar_widget.dart';
import 'grid_produk.dart';
import 'produk_card.dart';
import 'rating_widget.dart';
import 'tema.dart';

class Katalog extends StatelessWidget {
  final Set<String> favorit;
  final ValueChanged<String>? onToggleFavorit;
  final VoidCallback? onBeranda;

  const Katalog({
    super.key,
    this.favorit = const <String>{},
    this.onToggleFavorit,
    this.onBeranda,
  });

  // Satu sumber data, dipakai oleh Beranda, ListView, GridView, dan Favorit.
  // Foto produk dimuat dari folder assets/images (didaftarkan di pubspec.yaml).
  static const List<Map<String, String>> items = [
    {
      'nama': 'Sepatu Lari ASICS',
      'kategori': 'Sepatu',
      'harga': 'Rp 2.400.000',
      'gambar': 'assets/images/assics.jpg',
      'deskripsi': 'Sepatu lari ringan dengan midsole tebal untuk jarak jauh.',
      'rating': '4.8',
    },
    {
      'nama': 'Headphone Wireless',
      'kategori': 'Audio',
      'harga': 'Rp 380.000',
      'gambar': 'assets/images/earphone.webp',
      'deskripsi': 'Headphone Bluetooth dengan suara jernih dan baterai awet.',
      'rating': '4.6',
    },
    {
      'nama': 'Hydropack Trail',
      'kategori': 'Tas',
      'harga': 'Rp 200.000',
      'gambar': 'assets/images/hydropack.webp',
      'deskripsi': 'Rompi hidrasi ringan dengan saku botol dan ventilasi mesh.',
      'rating': '4.7',
    },
    {
      'nama': 'Kacamata Sport',
      'kategori': 'Aksesori',
      'harga': 'Rp 35.000',
      'gambar': 'assets/images/kacamata.jpeg',
      'deskripsi': 'Kacamata sepeda dan lari dengan lensa anti silau.',
      'rating': '4.5',
    },
    {
      'nama': 'Jersey Lari Nusantara',
      'kategori': 'Pakaian',
      'harga': 'Rp 170.000',
      'gambar': 'assets/images/kaos.jpg',
      'deskripsi': 'Jersey dry-fit dengan desain Nusantara, nyaman untuk lari.',
      'rating': '4.9',
    },
    {
      'nama': 'Smartwatch Sport',
      'kategori': 'Wearable',
      'harga': 'Rp 350.000',
      'gambar': 'assets/images/smartwatch.png',
      'deskripsi': 'Jam pintar layar AMOLED dengan pemantau detak jantung.',
      'rating': '4.7',
    },
    {
      'nama': 'Topi Lari Sport',
      'kategori': 'Aksesori',
      'harga': 'Rp 680.000',
      'gambar': 'assets/images/topi.webp',
      'deskripsi':
          'Topi lari ringan dengan ventilasi mesh dan tali penyesuaian.',
      'rating': '4.6',
    },

    // Tambahkan produk baru di sini dengan struktur kunci yang sama, lalu
    // simpan gambarnya di folder assets/images. Contoh:
    // {
    //   'nama': 'Tas Ransel Sport',
    //   'kategori': 'Tas',
    //   'harga': 'Rp 350.000',
    //   'gambar': 'assets/images/tas_ransel.jpg',
    //   'deskripsi': 'Tas ransel ringan untuk latihan dan aktivitas harian.',
    //   'rating': '4.8',
    // },
  ];

  // Widget pembantu: judul dengan ikon
  Widget _judul(String teks, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          Icon(ikon, color: warnaUtama),
          const SizedBox(width: 8),
          Text(
            teks,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: warnaTeks,
            ),
          ),
        ],
      ),
    );
  }

  // Navigasi ke halaman detail sambil mengirim data produk
  void _bukaDetail(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: item)),
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

  // Daftar produk (ListView.builder)
  Widget _daftar(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 0,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: warnaGaris),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            onTap: () => _bukaDetail(context, item),
            isThreeLine: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            leading: gambarProduk(item['gambar']!, size: 56),
            title: Text(
              item['nama']!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: warnaTeks,
              ),
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['deskripsi']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: warnaTeksLembut),
                ),
                const SizedBox(height: 2),
                Text(
                  item['harga']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: warnaHarga,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  label: Text(item['kategori']!),
                  labelStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: warnaUtamaTua,
                  ),
                  backgroundColor: warnaAksenMuda,
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                const SizedBox(height: 2),
                RatingBintang(
                  rating: double.tryParse(item['rating'] ?? '') ?? 0,
                  ukuran: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Galeri produk (GridView.count)
  Widget _galeri(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int kolom = jumlahKolomProduk(constraints.maxWidth);

        return GridView.count(
          padding: const EdgeInsets.all(12),
          crossAxisCount: kolom,
          childAspectRatio: rasioKartuProduk,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(items.length, (index) {
            final item = items[index];

            return ProdukCard(
              produk: item,
              favorit: favorit.contains(item['nama']),
              onToggleFavorit: () => onToggleFavorit?.call(item['nama']!),
              onTap: () => _bukaDetail(context, item),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu navigasi',
          onSelected: (value) {
            if (value == 'beranda') {
              if (onBeranda != null) {
                onBeranda!();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Anda sudah berada di halaman Beranda'),
                  ),
                );
              }
            } else if (value == 'tentang') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            } else if (value == 'pengaturan') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Halaman Pengaturan belum tersedia'),
                ),
              );
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'beranda', child: Text('Beranda')),
            PopupMenuItem(value: 'tentang', child: Text('Tentang Aplikasi')),
            PopupMenuItem(value: 'pengaturan', child: Text('Pengaturan')),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _bukaKeranjang(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _judul('Daftar Produk', Icons.list),
          Expanded(child: _daftar(context)),
          _judul('Galeri Produk', Icons.grid_view),
          Expanded(child: _galeri(context)),
        ],
      ),
    );
  }
}
