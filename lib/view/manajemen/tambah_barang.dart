import 'package:flutter/material.dart';
import 'package:invoice/models/kategori.dart';

import '../../helpers/db_helper.dart';
import '../../models/barang.dart';
import '../sidebar/mySideBar.dart';

class BarangPage extends StatefulWidget {
  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final DBHelper dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();

  List<Barang> barangList = [];
  List<Kategori> kategoriList = [];

  final _namaController = TextEditingController();
  final _kodeController = TextEditingController();
  final _hargaController = TextEditingController();
  final _tipeBarangController = TextEditingController();
  final _tipeStokController = TextEditingController();
  Kategori? _pilihKategori;

  int? selectedId;

  @override
  void initState() {
    super.initState();
    _refreshBarangList();
    _loadKategoriList();
  }

  void _loadKategoriList() async {
    final data = await dbHelper.getKategoriList();
    setState(() {
      kategoriList = data;
    });
  }

  void _refreshBarangList() async {
    final data = await dbHelper.getBarangList();
    setState(() {
      barangList = data;
      print('list berhasil muncul');
    });
  }

  void _clearForm() {
    _namaController.clear();
    _kodeController.clear();
    _hargaController.clear();
    _tipeBarangController.clear();
    _tipeStokController.clear();
    _pilihKategori = null;
    selectedId = null;
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      // Cek apakah kode_barang sudah ada di database (selain dari barang yang sedang diedit)
      bool isExist = await dbHelper.isKodeBarangExist(
        _kodeController.text.toLowerCase(),
        excludeId: selectedId,
      );

      if (isExist) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kode barang sudah digunakan!')),
        );
        return; // Hentikan proses simpan
      }

      final barang = Barang(
        id: selectedId,
        nama_barang: _namaController.text,
        kode_barang: _kodeController.text,
        harga_jual: double.parse(_hargaController.text),
        kategori: _pilihKategori?.nama_kategori ?? '',
        tipe_barang: 'default',
        tipe_stok: 'unlimited',
      );

      if (selectedId == null) {
        await dbHelper.insertBarang(barang);
      } else {
        await dbHelper.updateBarang(barang);
      }

      _clearForm();
      _refreshBarangList();
      print('berhasil simpan barang');
    }
  }

  void _deleteData(int id) async {
    await dbHelper.deleteBarang(id);
    print('berhasil hapus barang');
    _refreshBarangList();
  }

  // void _editData(Barang barang) {
  //   _namaController.text = barang.nama_barang;
  //   _kodeController.text = barang.kode_barang;
  //   _hargaController.text = barang.harga_jual.toString();
  //   _pilihKategori = kategoriList.firstWhere(
  //         (kategori) => kategori.nama_kategori == barang.kategori,
  //     orElse: () => Kategori(id: 0, nama_kategori: 'Tidak diketahui'),
  //   );
  //   selectedId = barang.id;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const mySideBar(),
      appBar: AppBar(
        title: Text('Tambah Barang'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushNamed(context, '/manajemen');
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'Nama Barang'),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: _kodeController,
                  decoration: InputDecoration(labelText: 'Kode Barang'),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: _hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Harga Barang'),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                DropdownButtonFormField<Kategori>(
                  value: _pilihKategori,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  items: kategoriList.map((Kategori category) {
                    return DropdownMenuItem<Kategori>(
                      value: category,
                      child: Text(category.nama_kategori),
                    );
                  }).toList(),
                  onChanged: (Kategori? newValue) {
                    setState(() {
                      _pilihKategori = newValue;
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text(selectedId == null ? 'Tambah' : 'Update'),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: barangList.length,
                itemBuilder: (context, index) {
                  final item = barangList[index];
                  return ListTile(
                    title: Text(item.nama_barang),
                    subtitle: Text('${item.kode_barang} | ${item.harga_jual} | ${item.kategori}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => print("_editData(item)"),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteData(item.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
