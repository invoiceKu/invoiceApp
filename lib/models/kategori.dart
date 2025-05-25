class Kategori{
  final int? id_kategori;
  final String nama_kategori;

  Kategori({this.id_kategori, required this.nama_kategori});

  Map<String, dynamic> toMap(){
    return{
      'id_kategori': id_kategori,
      'nama_kategori': nama_kategori,
    };
  }

  factory Kategori.fromMap(Map<String, dynamic>map){
    return Kategori(
      id_kategori: map['id_kategori'],
      nama_kategori: map['nama_kategori'],
    );
  }
}