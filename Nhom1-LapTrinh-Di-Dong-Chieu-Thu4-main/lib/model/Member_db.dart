// lib/models/thanhvien.dart
class ThanhVien {
  final String maTV;
  final String tenTV;
  final String? diaChi;
  final String? sdt;
  final String? maND;

  ThanhVien({
    required this.maTV,
    required this.tenTV,
    this.diaChi,
    this.sdt,
    this.maND,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaTV': maTV,
      'TenTV': tenTV,
      'DiaChi': diaChi,
      'SDT': sdt,
      'MaND': maND,
    };
  }

  factory ThanhVien.fromMap(Map<String, dynamic> map) {
    return ThanhVien(
      maTV: map['MaTV'],
      tenTV: map['TenTV'],
      diaChi: map['DiaChi'],
      sdt: map['SDT'],
      maND: map['MaND'],
    );
  }
}