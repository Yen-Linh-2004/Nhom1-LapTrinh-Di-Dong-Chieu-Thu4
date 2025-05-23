// lib/models/user.dart
class User {
  final String maND;
  final String tenND;
  final String? email;
  final String matKhau;
  final String? vaiTro;
  final String? chucVuTaiDV;

  User({
    required this.maND,
    required this.tenND,
    this.email,
    required this.matKhau,
    this.vaiTro,
    this.chucVuTaiDV,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaND': maND,
      'TenND': tenND,
      'Email': email,
      'MatKhau': matKhau,
      'VaiTro': vaiTro,
      'ChucVuTaiDV': chucVuTaiDV,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      maND: map['MaND'],
      tenND: map['TenND'],
      email: map['Email'],
      matKhau: map['MatKhau'],
      vaiTro: map['VaiTro'],
      chucVuTaiDV: map['ChucVuTaiDV'],
    );
  }
}