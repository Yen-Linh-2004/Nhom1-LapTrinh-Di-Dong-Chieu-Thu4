// lib/models/nhom.dart
class Nhom {
  final String maNhom;
  final String tenNhom;
  final String? moTa;

  Nhom({
    required this.maNhom,
    required this.tenNhom,
    this.moTa,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaNhom': maNhom,
      'TenNhom': tenNhom,
      'MoTa': moTa,
    };
  }

  factory Nhom.fromMap(Map<String, dynamic> map) {
    return Nhom(
      maNhom: map['MaNhom'],
      tenNhom: map['TenNhom'],
      moTa: map['MoTa'],
    );
  }
}