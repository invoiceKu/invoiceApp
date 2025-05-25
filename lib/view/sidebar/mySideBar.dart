import 'package:flutter/material.dart';

class mySideBar extends StatelessWidget {
  const mySideBar({super.key});

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 135,
                    height: 135,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            buildDrawerItem(Icons.inventory, "Manajemen", () {
              Navigator.pushNamed(context, '/manajemen');
            }),
            buildDrawerItem(Icons.shopping_cart, "Transaksi", () {
              Navigator.pushNamed(context, '/transaksi');
            }),
            buildDrawerItem(Icons.receipt, "Laporan", () {
              Navigator.pushNamed(context, '/laporan');
            }),
            buildDrawerItem(Icons.settings, "Pengaturan", () {
              Navigator.pushNamed(context, '/pengaturan');
            }),
          ],
        ),
      ),
    );
  }
}
