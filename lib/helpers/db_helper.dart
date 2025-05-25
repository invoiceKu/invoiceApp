import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/barang.dart';
import '../models/kategori.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  
  DBHelper._internal();
  
  static Database? _db;
  
  Future<Database> get database async{
    if (_db != null) return _db!; 
    _db = await initDB();
    return _db!;
  }
  
  Future<Database> initDB() async{
    final path = join(await getDatabasesPath(), 'invoice.db');
    return await openDatabase(
        path, version: 1,
        onCreate: (db, version) async{
      await db.execute('''CREATE TABLE barang(id INTEGER PRIMARY KEY AUTOINCREMENT, nama_barang TEXT, kode_barang TEXT, harga_jual DOUBLE, kategori TEXT)''');
      await db.execute('''CREATE TABLE kategori(id_kategori INTEGER PRIMARY KEY AUTOINCREMENT, nama_kategori TEXT)''');
    }
    );
  }
  
  Future<int> insertBarang(Barang barang) async{
    final db = await database;
    return await db.insert('barang', barang.toMap());
  }
  Future<List<Barang>> getBarangList() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('barang');
    return List.generate(maps.length, (i) => Barang.fromMap(maps[i]));
  }

  Future<int> updateBarang(Barang barang) async {
    final db = await database;
    return await db.update('barang', barang.toMap(), where: 'id = ?', whereArgs: [barang.id]);
  }

  Future<int> deleteBarang(int id) async {
    final db = await database;
    return await db.delete('barang', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertKategori(Kategori kategori) async{
    final db =await database;
    return await db.insert('kategori', kategori.toMap());
  }

  Future<List<Kategori>> getKategoriList() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kategori');
    return List.generate(maps.length, (i) => Kategori.fromMap(maps[i]));
  }

  Future<int> updateKategori(Kategori kategori) async{
    final db = await database;
    return await db.update('kategori', kategori.toMap(), where: 'id_kategori = ?', whereArgs: [kategori.id_kategori]);
  }

  Future<int> deleteKategori(int id_kategori) async{
    final db = await database;
    return await db.delete('kategori', where: 'id_kategori = ?', whereArgs: [id_kategori]);
  }

}