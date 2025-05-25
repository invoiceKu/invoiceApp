import 'package:flutter/material.dart';
import 'package:invoice/helpers/db_helper.dart';
import 'package:invoice/models/barang.dart';

class BarangProvider with ChangeNotifier {
  List<Barang> _barangList = [];

  List<Barang> get barangList => _barangList;

  Future<void> fetchBarang() async {
    final dbHelper = DBHelper();
    final data = await dbHelper.getBarangList();
    _barangList = data.map((e) => Barang.fromMap(e as Map<String, dynamic>)).toList();
    notifyListeners();
  }
}