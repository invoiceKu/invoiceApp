import 'package:flutter/material.dart';

import '../../helpers/db_helper.dart';
import '../../models/kategori.dart';

class DataKategoriPage extends StatefulWidget{
  @override
  _DataKategoriPageState createState() => _DataKategoriPageState();
}

class _DataKategoriPageState extends State<DataKategoriPage>{
  final DBHelper dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();

  List<Kategori> kategoriList = [];
  final _namaController = TextEditingController();
  int? selectedId;

  @override
  void initState(){
    super.initState();
    _refreshKategoriList();
  }

  void _refreshKategoriList() async{
    final data = await dbHelper.getKategoriList();
    setState(() {
      kategoriList = data;
      print('list kategori berhasil muncul');
    });
  }

  void _clearForm(){
    _namaController.clear();
    selectedId = null;
  }

  void _saveData() async{
    if (_formKey.currentState!.validate()) {
      final kategori = Kategori(
        id_kategori: selectedId,
        nama_kategori: _namaController.text,
      );

      if (selectedId == null){
        await dbHelper.insertKategori(kategori);
      } else{
        await dbHelper.updateKategori(kategori);
      }

      _clearForm();
      _refreshKategoriList();
      print('berhasil simpan kategori');
    }
  }

  void _deleteData(int id_kategori) async{
    await dbHelper.deleteKategori(id_kategori);
    _refreshKategoriList();
    print('berhasil hapus kategori');
  }

  void _editData(Kategori kategori) async{
    _namaController.text = kategori.nama_kategori;
    selectedId = kategori.id_kategori;
  }

  void _tambahDialog({Map<String, dynamic>? kategori}){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Tambah Kategori'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _namaController,
                validator: (value)=>
                value == null || value.isEmpty ? 'wajib diisi' : null,
                decoration: const InputDecoration(
                  labelText: 'Nama Kategori',
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async{
                    _saveData();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                  ),
                  child: const Text('Simpan'),
              ),
            ],
          );
        },
    );
  }

  void _editDialog(Kategori kategori) {
    // Isi controller dengan data kategori yang akan diedit
    _namaController.text = kategori.nama_kategori;
    selectedId = kategori.id_kategori;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Kategori'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _namaController,
              validator: (value) =>
              value == null || value.isEmpty ? 'Wajib diisi' : null,
              decoration: const InputDecoration(
                labelText: 'Nama Kategori',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final updatedKategori = Kategori(
                    id_kategori: selectedId,
                    nama_kategori: _namaController.text,
                  );
                  await dbHelper.updateKategori(updatedKategori);
                  Navigator.pop(context);
                  _clearForm();
                  _refreshKategoriList();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[200],
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }


  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap){
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kategori'),
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
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: kategoriList.length,
                itemBuilder: (context, index){
                  final item = kategoriList[index];
                  return ListTile(
                    title: Text(item.nama_kategori),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: ()=> _editDialog(item),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: ()=> _deleteData(item.id_kategori!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: ()=> _tambahDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Tambah Kategori'),
            ),
          ],
        ),
      ),
    );
  }
}