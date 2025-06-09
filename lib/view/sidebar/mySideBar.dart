import 'package:flutter/material.dart';

class mySideBar extends StatelessWidget {
  const mySideBar({super.key});

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BgSidebar.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/BgSidebar.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_circle, color: Colors.white, size: 48),
                  SizedBox(height: 10),
                  Text(
                    'Nama Perusahaan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Menu Items
          buildDrawerItem(Icons.inventory_2_outlined, "Manajemen", () {
            Navigator.pushNamed(context, '/manajemen');
          }),
          buildDrawerItem(Icons.shopping_cart, "Transaksi", () {
            Navigator.pushNamed(context, '/transaksi');
          }),
          buildDrawerItem(Icons.receipt_long_outlined, "Laporan", () {
            Navigator.pushNamed(context, '/laporan');
          }),
          buildDrawerItem(Icons.settings_outlined, "Pengaturan", () {
            Navigator.pushNamed(context, '/pengaturan');
          }),
          buildDrawerItem(Icons.phone_in_talk_outlined, "Bantuan", () {
            Navigator.pushNamed(context, '/bantuan');
          }),
        ],
      ),
    );
  }
}
