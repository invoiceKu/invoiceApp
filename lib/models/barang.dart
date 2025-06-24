class Barang {
  int? id;
  String nama_barang;
  String kode_barang;
  double harga_jual;
  String? kategori;
  String tipe_barang;
  String tipe_stok;

  Barang({
    this.id,
    required this.nama_barang,
    required String kode_barang, // ambil sebagai argumen
    required this.harga_jual,
    this.kategori,
    required this.tipe_barang,
    required this.tipe_stok,
  }) : kode_barang = kode_barang.toLowerCase(); // simpan dalam lowercase

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_barang': nama_barang,
      'kode_barang': kode_barang, // sudah pasti lowercase
      'harga_jual': harga_jual,
      'kategori': kategori ?? '',
      'tipe_barang': tipe_barang,
      'tipe_stok': tipe_stok,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'],
      nama_barang: map['nama_barang'],
      kode_barang: map['kode_barang'],
      harga_jual: map['harga_jual'],
      kategori: map['kategori'] ?? '',
      tipe_barang: map['tipe_barang'],
      tipe_stok: map['tipe_stok'],
    );
  }
}
