/// Rasio kartu produk untuk grid di Beranda, Katalog, dan Favorit.
const double rasioKartuProduk = 0.62;

/// Menentukan jumlah kolom grid sesuai lebar layar.
int jumlahKolomProduk(double lebar) {
  if (lebar >= 1000) return 4;
  if (lebar >= 650) return 3;
  return 2;
}
