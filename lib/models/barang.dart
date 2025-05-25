class Barang{
  int? id;
  String nama_barang;
  String kode_barang;
  double harga_jual;
  String kategori;

  Barang({this.id, required this.nama_barang, required this.kode_barang, required this.harga_jual, required this.kategori});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'nama_barang': nama_barang,
      'kode_barang': kode_barang,
      'harga_jual': harga_jual,
      'kategori': kategori,
    };
  }

  factory Barang.fromMap(Map<String, dynamic>map){
    return Barang(
      id: map['id'],
      nama_barang: map['nama_barang'],
      kode_barang: map['kode_barang'],
      harga_jual: map['harga_jual'],
      kategori: map['kategori'],
    );
  }
}