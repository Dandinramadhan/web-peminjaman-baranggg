class SiswaModel {
  final int id;
  final String nama, tplahir, tglahir, kelamin, agama, alamat;
  SiswaModel({required this.id, required this.nama, required this.tplahir,
    required this.tglahir, required this.kelamin, required this.agama, required this.alamat});

  factory SiswaModel.fromJson(Map<String, dynamic> json){
    return SiswaModel(
        id: json['id'],
        nama: json['nama'],
        tplahir: json['tplahir'],
        tglahir: json['tglahir'],
        kelamin: json['kelamin'],
        agama: json['agama'],
        alamat: json['alamat']
    );
  }
  Map<String, dynamic> toJson() => {
    'nama': nama,
    'tplahir': tplahir,
    'tglahir': tglahir,
    'kelamin': kelamin,
    'agama': agama,
    'alamat': alamat,
  };


}