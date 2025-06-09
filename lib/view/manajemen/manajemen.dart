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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF58D3D3), Color(0xFFB6F0DA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          _buildMenuTile(
            icon: Icons.inventory_2_outlined,
            label: 'Data Barang',
            onTap: () => Navigator.pushNamed(context, '/barang'),
          ),
          _buildMenuTile(
            icon: Icons.category_outlined,
            label: 'Data Kategori',
            onTap: () => Navigator.pushNamed(context, '/kategori'),
          ),
          _buildMenuTile(
            icon: Icons.person_outline,
            label: 'Data Pelanggan',
            onTap: () => Navigator.pushNamed(context, '/pelanggan'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(icon, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
