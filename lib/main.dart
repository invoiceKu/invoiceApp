import 'package:flutter/material.dart';

import 'view/manajemen/data_kategori.dart';
import 'view/manajemen/manajemen.dart';
import 'view/manajemen/tambah_barang.dart';
import 'view/transaksi/transaksi.dart';

void main() {
  runApp(

      const MyApp(),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/transaksi',
      routes: {
        '/manajemen': (context) => ManajemenPage(),
        '/barang': (context) => BarangPage(),
        '/kategori': (context) => DataKategoriPage(),
        '/transaksi': (context) =>  Transaksi(),
        // '/laporan': (context) => LaporanPage(),
        // '/pengaturan': (context) => PengaturanPage(),
      },
    );
  }
}
