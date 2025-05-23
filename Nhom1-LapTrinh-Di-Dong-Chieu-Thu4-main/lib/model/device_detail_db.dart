// lib/models/chitiethd.dart
class ChiTietHD {
  final String maHD;
  final String maTB;
  final int soLuong;
  final double donGia;

  ChiTietHD({
    required this.maHD,
    required this.maTB,
    required this.soLuong,
    required this.donGia,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaHD': maHD,
      'MaTB': maTB,
      'SoLuong': soLuong,
      'DonGia': donGia,
    };
  }

  factory ChiTietHD.fromMap(Map<String, dynamic> map) {
    return ChiTietHD(
      maHD: map['MaHD'],
      maTB: map['MaTB'],
      soLuong: map['SoLuong'],
      donGia: map['DonGia'],
    );
  }
}