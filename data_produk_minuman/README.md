# Data Produk — Mini Project Flutter (Tema Minuman)

## Cara menjalankan
1. Buka folder ini di Android Studio / VS Code (pastikan Flutter SDK sudah terpasang).
2. Jalankan `flutter pub get`.
3. Jalankan `flutter run` (pilih emulator/HP), atau tekan Run di editor.
4. Tekan tombol **TAMPILKAN DATA** setelah mengisi form untuk menambah & menampilkan produk baru.
5. Ambil screenshot aplikasi yang sudah berjalan untuk dikumpulkan (sesuai aturan tugas).

## Pemetaan konsep PBO (buat jaga-jaga kalau ditanya guru)

| Ketentuan               | Implementasi di `lib/main.dart`                                             |
|--------------------------|-------------------------------------------------------------------------------|
| Class Produk              | `class Produk { ... }`                                                       |
| Minimal 4 property        | `nama`, `harga`, `kategori`, `stok`                                          |
| Constructor                | `Produk({required this.nama, required this.harga, ...})`                    |
| Minimal 1 method           | `formatHarga()`, `statusStok()`, `warnaStok()`, `ikonKategori()`, `warnaKategori()` (5 method) |
| Minimal 1 object            | List `_daftarProduk` diisi 3 object contoh + 1 object baru dibuat setiap tombol TAMPILKAN DATA ditekan |
| Object dipakai di Flutter    | Setiap object di-render jadi kartu (`_kartuProduk(p)`) di `ListView`         |

## Kenapa datanya seperti itu
- Tema: kedai minuman (kopi, teh, jus, susu, soda) — bebas kamu ganti nama produknya.
- `statusStok()` otomatis kasih label **Habis / Menipis / Tersedia** berdasarkan angka stok, jadi ini contoh nyata "method yang mengolah property miliknya sendiri" (ciri OOP), bukan cuma variabel biasa.
- Warna & ikon kartu berubah otomatis sesuai kategori (`warnaKategori()`, `ikonKategori()`) — ini juga method, bukan hardcode di UI, supaya gampang dijelaskan kalau guru tanya "yang mana implementasi PBO-nya".

## Catatan
Tidak pakai database, API, atau login — sesuai aturan tugas. Semua data hanya tersimpan sementara di memori (List) selama aplikasi berjalan.
