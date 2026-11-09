import 'package:flutter/material.dart';

void main() {
  runApp(const DataProdukApp());
}

class DataProdukApp extends StatelessWidget {
  const DataProdukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DATA PRODUK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF7C3AED),
        scaffoldBackgroundColor: const Color(0xFFF6F3FB),
        fontFamily: 'Roboto',
      ),
      home: const HalamanDataProduk(),
    );
  }
}

// ==========================================================
// CLASS PRODUK (Konsep PBO)
// - Minimal 4 property : nama, harga, kategori, stok
// - Constructor
// - Minimal 1 method   : formatHarga(), statusStok(), dll
// ==========================================================
class Produk {
  String nama;
  int harga;
  String kategori;
  int stok;

  // Constructor
  Produk({
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.stok,
  });

  // Method 1: format harga jadi "Rp15.000"
  String formatHarga() {
    String angka = harga.toString();
    String hasil = '';
    int hitung = 0;
    for (int i = angka.length - 1; i >= 0; i--) {
      hasil = angka[i] + hasil;
      hitung++;
      if (hitung % 3 == 0 && i != 0) {
        hasil = '.$hasil';
      }
    }
    return 'Rp$hasil';
  }

  // Method 2: status stok berdasarkan jumlah
  String statusStok() {
    if (stok <= 0) return 'Habis';
    if (stok < 10) return 'Menipis';
    return 'Tersedia';
  }

  // Method 3: warna badge sesuai status stok
  Color warnaStok() {
    switch (statusStok()) {
      case 'Habis':
        return const Color(0xFFE53935);
      case 'Menipis':
        return const Color(0xFFFB8C00);
      default:
        return const Color(0xFF43A047);
    }
  }

  // Method 4: ikon sesuai kategori minuman
  IconData ikonKategori() {
    switch (kategori) {
      case 'Kopi':
        return Icons.coffee_rounded;
      case 'Teh':
        return Icons.emoji_food_beverage_rounded;
      case 'Jus':
        return Icons.local_bar_rounded;
      case 'Susu':
        return Icons.icecream_rounded;
      case 'Soda':
        return Icons.bubble_chart_rounded;
      default:
        return Icons.local_drink_rounded;
    }
  }

  // Method 5: warna gradasi kartu sesuai kategori
  List<Color> warnaKategori() {
    switch (kategori) {
      case 'Kopi':
        return [const Color(0xFF6F4E37), const Color(0xFFA9745B)];
      case 'Teh':
        return [const Color(0xFF2E7D32), const Color(0xFF66BB6A)];
      case 'Jus':
        return [const Color(0xFFF57C00), const Color(0xFFFFB74D)];
      case 'Susu':
        return [const Color(0xFF5C6BC0), const Color(0xFF9FA8DA)];
      case 'Soda':
        return [const Color(0xFFD81B60), const Color(0xFFF06292)];
      default:
        return [const Color(0xFF7C3AED), const Color(0xFFB794F6)];
    }
  }
}

class HalamanDataProduk extends StatefulWidget {
  const HalamanDataProduk({super.key});

  @override
  State<HalamanDataProduk> createState() => _HalamanDataProdukState();
}

class _HalamanDataProdukState extends State<HalamanDataProduk> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  String _kategoriTerpilih = 'Kopi';

  final List<String> _daftarKategori = ['Kopi', 'Teh', 'Jus', 'Susu', 'Soda'];

  // Minimal 1 object dari class Produk, langsung dipakai di aplikasi
  final List<Produk> _daftarProduk = [
    Produk(nama: 'Es Kopi Susu Gula Aren', harga: 18000, kategori: 'Kopi', stok: 25),
    Produk(nama: 'Thai Tea Boba', harga: 15000, kategori: 'Teh', stok: 8),
    Produk(nama: 'Jus Alpukat Coklat', harga: 17000, kategori: 'Jus', stok: 0),
  ];

  bool _sudahTampil = false;

  void _tampilkanData() {
    if (_formKey.currentState!.validate()) {
      // Membuat object baru dari class Produk memakai data form
      final produkBaru = Produk(
        nama: _namaController.text,
        harga: int.parse(_hargaController.text),
        kategori: _kategoriTerpilih,
        stok: int.parse(_stokController.text),
      );

      setState(() {
        _daftarProduk.insert(0, produkBaru);
        _sudahTampil = true;
      });

      _namaController.clear();
      _hargaController.clear();
      _stokController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF43A047),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Text('${produkBaru.nama} berhasil ditampilkan'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ---------- APP BAR CANTIK ----------
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: const Color(0xFF7C3AED),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'DATA PRODUK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 0.5),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFFC084FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: 10,
                      child: Icon(Icons.local_cafe_rounded, size: 130, color: Colors.white.withOpacity(0.15)),
                    ),
                    const Positioned(
                      left: 20,
                      bottom: 48,
                      child: Text(
                        'Kedai Segar 🥤 Cek stok & harga minuman',
                        style: TextStyle(color: Colors.white70, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---------- FORM INPUT ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tambah Produk Minuman',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5)),
                      const SizedBox(height: 14),
                      _kotakInput(_namaController, 'Nama produk', Icons.local_drink_outlined,
                          validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _kotakInput(_hargaController, 'Harga', Icons.payments_outlined,
                                keyboardType: TextInputType.number,
                                validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _kotakInput(_stokController, 'Stok', Icons.inventory_2_outlined,
                                keyboardType: TextInputType.number,
                                validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _kategoriTerpilih,
                        decoration: _dekorasiInput('Kategori', Icons.category_outlined),
                        items: _daftarKategori
                            .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                            .toList(),
                        onChanged: (v) => setState(() => _kategoriTerpilih = v!),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _tampilkanData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.visibility_rounded),
                          label: const Text('TAMPILKAN DATA',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ---------- LABEL DAFTAR ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Daftar Produk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${_daftarProduk.length} item', style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
                ],
              ),
            ),
          ),

          // ---------- LIST KARTU PRODUK ----------
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _kartuProduk(_daftarProduk[index]),
                childCount: _daftarProduk.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kotakInput(TextEditingController c, String label, IconData icon,
      {TextInputType? keyboardType, String? Function(String?)? validator}) {
    return TextFormField(
      controller: c,
      keyboardType: keyboardType,
      decoration: _dekorasiInput(label, icon),
      validator: validator,
    );
  }

  InputDecoration _dekorasiInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: const Color(0xFFF6F3FB),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }

  Widget _kartuProduk(Produk p) {
    final warna = p.warnaKategori();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: warna, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(p.ikonKategori(), color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.nama, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: warna.first.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(p.kategori, style: TextStyle(color: warna.first, fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 6),
                    Text(p.formatHarga(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED))),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(color: p.warnaStok(), borderRadius: BorderRadius.circular(20)),
                child: Text(p.statusStok(), style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 6),
              Text('Stok: ${p.stok}', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}
