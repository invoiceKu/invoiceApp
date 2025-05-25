import 'package:flutter/material.dart';

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
  final _namaController = TextEditingController();
  final _kodeController = TextEditingController();
  final _hargaController = TextEditingController();
  final _kategoriController = TextEditingController();

  int? selectedId;

  @override
  void initState() {
    super.initState();
    _refreshBarangList();
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
    _kategoriController.clear();
    selectedId = null;
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final barang = Barang(
        id: selectedId,
        nama_barang: _namaController.text,
        kode_barang: _kodeController.text,
        harga_jual: double.parse(_hargaController.text),
        kategori: _kategoriController.text,
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

  void _editData(Barang barang) {
    _namaController.text = barang.nama_barang;
    _kodeController.text = barang.kode_barang;
    _hargaController.text = barang.harga_jual.toString();
    _kategoriController.text = barang.kategori;
    selectedId = barang.id;
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const mySideBar(),
      appBar: AppBar(
        title: Text('Tambah Barang'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
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
                TextFormField(
                  controller: _kategoriController,
                  decoration: InputDecoration(labelText: 'Kategori'),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text(selectedId == null ? 'Tambah' : 'Update'),
                )
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
                          onPressed: () => _editData(item),
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
            )
          ],
        ),
      ),
    );
  }
}
