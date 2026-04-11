class Travel {
  final int id;
  final String nama;
  final String? alamat;
  final String? telepon;
  final String? email;
  final String? logo;

  Travel({
    required this.id,
    required this.nama,
    this.alamat,
    this.telepon,
    this.email,
    this.logo,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      id: json['id'],
      nama: json['nama_travel'] ?? '',
      alamat: json['alamat'],
      telepon: json['nomor_telepon'],
      email: json['email'],
      logo: json['logo'],
    );
  }
}