import 'package:flutter/material.dart';

import 'about_page.dart';
import 'detail_produk.dart';
import 'grid_produk.dart';
import 'katalog.dart';
import 'produk_card.dart';
import 'tema.dart';

class BerandaPage extends StatefulWidget {
  final Set<String> favorit;
  final ValueChanged<String> onToggleFavorit;
  final VoidCallback onLihatSemua;

  const BerandaPage({
    super.key,
    required this.favorit,
    required this.onToggleFavorit,
    required this.onLihatSemua,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final TextEditingController _cari = TextEditingController();

  String _query = '';
  String? _kategori;

  static const List<String> _urutanKategori = [
    'Tas',
    'Sepatu',
    'Audio',
    'Wearable',
    'Aksesori',
    'Pakaian',
  ];

  static const Map<String, IconData> _ikonKategori = {
    'Tas': Icons.work_outline,
    'Sepatu': Icons.directions_run,
    'Audio': Icons.headphones_outlined,
    'Wearable': Icons.watch_outlined,
    'Aksesori': Icons.visibility_outlined,
    'Pakaian': Icons.checkroom,
  };

  @override
  void dispose() {
    _cari.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _produkTampil {
    final String kataKunci = _query.trim().toLowerCase();

    return Katalog.items.where((produk) {
      final bool cocokKategori =
          _kategori == null || produk['kategori'] == _kategori;
      final bool cocokCari =
          kataKunci.isEmpty ||
          produk['nama']!.toLowerCase().contains(kataKunci) ||
          produk['kategori']!.toLowerCase().contains(kataKunci) ||
          produk['deskripsi']!.toLowerCase().contains(kataKunci);

      return cocokKategori && cocokCari;
    }).toList();
  }

  void _bukaDetail(Map<String, String> produk) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: produk)),
    );
  }

  void _bukaKeranjang() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Keranjang masih kosong'),
        ),
      );
  }

  void _resetFilter() {
    _cari.clear();
    setState(() {
      _query = '';
      _kategori = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> produk = _produkTampil;

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Beranda',
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
            onPressed: _bukaKeranjang,
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          _hero(),
          _promo(),
          _bagianKategori(),
          _judulProduk(),
          if (produk.isEmpty) _kosong() else _gridProduk(produk),
          _footerTentang(),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      color: warnaUtama,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mau cari produk apa hari ini?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: TextField(
              controller: _cari,
              onChanged: (value) => setState(() => _query = value),
              cursorColor: warnaUtama,
              textInputAction: TextInputAction.search,
              style: const TextStyle(color: warnaTeks),
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                hintStyle: const TextStyle(color: warnaTeksLembut),
                prefixIcon: const Icon(Icons.search, color: warnaTeksLembut),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        onPressed: () {
                          _cari.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close, color: warnaTeksLembut),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _promo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [warnaUtama, warnaAksen],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 44,
              child: Transform.rotate(
                angle: 0.5,
                child: Icon(
                  Icons.local_offer,
                  size: 84,
                  color: Colors.white.withValues(alpha: 0.22),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Promo Spesial',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Diskon hingga 30% untuk produk pilihan minggu ini.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: widget.onLihatSemua,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: warnaUtama,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Belanja Sekarang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bagianKategori() {
    final List<String> kategori = _urutanKategori
        .where(
          (nama) => Katalog.items.any((produk) => produk['kategori'] == nama),
        )
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool lebar = constraints.maxWidth >= 520;

        final Widget isi = lebar
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final String nama in kategori) _itemKategori(nama),
                ],
              )
            : SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: kategori.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  itemBuilder: (context, index) =>
                      _itemKategori(kategori[index]),
                ),
              );

        return Padding(
          padding: EdgeInsets.fromLTRB(16, 24, lebar ? 16 : 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: warnaTeks,
                ),
              ),
              const SizedBox(height: 14),
              isi,
            ],
          ),
        );
      },
    );
  }

  Widget _itemKategori(String nama) {
    final bool dipilih = _kategori == nama;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _kategori = dipilih ? null : nama;
        });
      },
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: dipilih ? warnaAksen : warnaAksenMuda,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _ikonKategori[nama] ?? Icons.category_outlined,
                color: dipilih ? Colors.white : warnaUtamaTua,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: dipilih ? FontWeight.w600 : FontWeight.w400,
                color: warnaTeks,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _judulProduk() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Produk Unggulan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: warnaTeks,
              ),
            ),
          ),
          TextButton(
            onPressed: widget.onLihatSemua,
            style: TextButton.styleFrom(foregroundColor: warnaUtama),
            child: const Text(
              'Lihat semua',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridProduk(List<Map<String, String>> produk) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int kolom = jumlahKolomProduk(constraints.maxWidth);

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                favorit: widget.favorit.contains(item['nama']),
                onToggleFavorit: () => widget.onToggleFavorit(item['nama']!),
                onTap: () => _bukaDetail(item),
              );
            },
          );
        },
      ),
    );
  }

  Widget _kosong() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
      child: Column(
        children: [
          const Icon(Icons.search_off, size: 56, color: warnaTeksLembut),
          const SizedBox(height: 12),
          const Text(
            'Produk tidak ditemukan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: warnaTeks,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Coba kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: TextStyle(color: warnaTeksLembut),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _resetFilter,
            style: TextButton.styleFrom(foregroundColor: warnaUtama),
            child: const Text('Tampilkan semua produk'),
          ),
        ],
      ),
    );
  }

  Widget _footerTentang() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          style: TextButton.styleFrom(foregroundColor: warnaTeksLembut),
          icon: const Icon(Icons.info_outline, size: 18),
          label: const Text('Tentang Aplikasi'),
        ),
      ),
    );
  }
}
