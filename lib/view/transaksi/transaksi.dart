import 'package:flutter/material.dart';

import '../../helpers/db_helper.dart';
import '../../models/barang.dart';
import '../sidebar/mySideBar.dart';


class Transaksi extends StatelessWidget {
  const Transaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransaksiPage();
  }
}

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String selectedKategori = 'Semua';
  String searchText = '';
  List<String> kategoriList = [];
  List<Barang> barangList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  Future<void> fetchBarang() async {
    final data = await DBHelper().getBarangList();
    final allKategori = data
        .map((e) => e.kategori)
        .whereType<String>()
        .toSet()
        .toList();

    setState(() {
      barangList = data;
      kategoriList = allKategori;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = barangList.where((barang) {
      final matchKategori = selectedKategori == 'Semua' || barang.kategori == selectedKategori;
      final matchSearch = barang.nama_barang.toLowerCase().contains(searchText.toLowerCase());
      return matchKategori && matchSearch;
    }).toList();

    return Scaffold(
      drawer: const mySideBar(),
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cari barang...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await fetchBarang();
                    setState(() {
                      searchText = '';
                      selectedKategori = 'Semua';
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                filterButton('Semua'),
                ...kategoriList.map((kategori) => filterButton(kategori)).toList(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final barang = filteredList[index];
                return ListTile(
                  title: Text(barang.nama_barang),
                  subtitle: Text('Rp ${barang.harga_jual}'),
                  onTap: () {
                    // Tambahkan aksi jika dibutuhkan
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget filterButton(String title) {
    final isSelected = selectedKategori == title;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedKategori = title;
          });
        },
        child: Text(title),
      ),
    );
  }
}
