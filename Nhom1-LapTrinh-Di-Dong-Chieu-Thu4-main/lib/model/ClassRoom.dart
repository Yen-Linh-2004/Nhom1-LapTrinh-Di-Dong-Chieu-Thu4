// lib/models/phonghoc.dart
class PhongHoc {
  final String maPhong;
  final String tenPhong;
  final int soLuongTB;
  final String? trangThai;

  PhongHoc({
    required this.maPhong,
    required this.tenPhong,
    required this.soLuongTB,
    this.trangThai,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaPhong': maPhong,
      'TenPhong': tenPhong,
      'SoLuongTB': soLuongTB,
      'TrangThai': trangThai,
    };
  }

  factory PhongHoc.fromMap(Map<String, dynamic> map) {
    return PhongHoc(
      maPhong: map['MaPhong'],
      tenPhong: map['TenPhong'],
      soLuongTB: map['SoLuongTB'],
      trangThai: map['TrangThai'],
    );
  }
}