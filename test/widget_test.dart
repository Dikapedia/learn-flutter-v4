import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/detail_produk.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  Finder navItem(String label) {
    return find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    );
  }

  void gunakanLayarTinggi(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('halaman Beranda tampil dengan hero, promo, dan produk', (
    WidgetTester tester,
  ) async {
    gunakanLayarTinggi(tester);
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    expect(find.text('Mau cari produk apa hari ini?'), findsOneWidget);
    expect(find.text('Promo Spesial'), findsOneWidget);
    expect(find.text('Kategori'), findsOneWidget);
    expect(find.text('Produk Unggulan'), findsOneWidget);
    expect(find.text('Sepatu Lari ASICS'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('tab Katalog menampilkan ListView dan GridView', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    await tester.tap(navItem('Katalog'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Produk'), findsOneWidget);
    expect(find.text('Galeri Produk'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('galeri responsif dua kolom di ponsel', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

    await tester.drag(find.byType(ListView).first, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(navItem('Katalog'));
    await tester.pumpAndSettle();

    final GridView galeri = tester.widget<GridView>(find.byType(GridView));
    final SliverGridDelegateWithFixedCrossAxisCount delegate =
        galeri.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('galeri responsif empat kolom di layar lebar', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    await tester.tap(navItem('Katalog'));
    await tester.pumpAndSettle();

    final GridView galeri = tester.widget<GridView>(find.byType(GridView));
    final SliverGridDelegateWithFixedCrossAxisCount delegate =
        galeri.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 4);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pencarian menyaring produk unggulan', (
    WidgetTester tester,
  ) async {
    gunakanLayarTinggi(tester);
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'smartwatch');
    await tester.pumpAndSettle();

    expect(find.text('Smartwatch Sport'), findsOneWidget);
    expect(find.text('Sepatu Lari ASICS'), findsNothing);

    await tester.enterText(find.byType(TextField), 'produk tidak ada');
    await tester.pumpAndSettle();

    expect(find.text('Produk tidak ditemukan'), findsOneWidget);
  });

  testWidgets('favorit tersinkron ke halaman Favorit', (
    WidgetTester tester,
  ) async {
    gunakanLayarTinggi(tester);
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    final Finder hatiPertama = find
        .descendant(
          of: find.byType(GridView),
          matching: find.byIcon(Icons.favorite_border),
        )
        .first;

    await tester.tap(hatiPertama);
    await tester.pumpAndSettle();

    expect(find.textContaining('ditambahkan ke favorit'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.tap(navItem('Favorit'));
    await tester.pumpAndSettle();

    expect(find.text('Sepatu Lari ASICS'), findsOneWidget);
  });

  testWidgets('produk Beranda dapat dibuka ke halaman detail', (
    WidgetTester tester,
  ) async {
    gunakanLayarTinggi(tester);
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sepatu Lari ASICS'));
    await tester.pumpAndSettle();

    expect(find.byType(DetailProduk), findsOneWidget);
    expect(find.text('Kategori :'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    expect(find.text('Tambah ke Keranjang'), findsOneWidget);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    expect(
      find.text('Sepatu Lari ASICS ditambahkan ke keranjang'),
      findsOneWidget,
    );
  });

  testWidgets('menu Katalog membuka halaman Tentang Aplikasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiKatalog());
    await tester.pumpAndSettle();

    await tester.tap(navItem('Katalog'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tentang Aplikasi'));
    await tester.pumpAndSettle();

    expect(find.text('v1.0.0'), findsOneWidget);
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
