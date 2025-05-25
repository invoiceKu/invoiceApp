import 'package:flutter/material.dart';

import '../sidebar/mySideBar.dart';

class ManajemenPage extends StatelessWidget {
  const ManajemenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const mySideBar(),
      appBar: AppBar(
        title: const Text('Manajemen'),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Data Barang'),
            onTap: () {
              Navigator.pushNamed(context, '/barang');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Data Kategori'),
            onTap: () {
              Navigator.pushNamed(context, '/kategori');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Data Pelanggan'),
            selected: true,
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.pushNamed(context, '/pelanggan');
            },
          ),
        ],
      ),
    );
  }
}
