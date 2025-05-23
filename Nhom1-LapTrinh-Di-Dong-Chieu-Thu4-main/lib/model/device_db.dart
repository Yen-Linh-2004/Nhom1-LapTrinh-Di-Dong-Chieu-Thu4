// lib/models/thietbi.dart
class ThietBi {
  final String maTB;
  final String tenTB;
  final String? hinhAnh;
  final String? maLoai;
  final double? donGia;
  final String? trangThaiTB;
  final String? thongSoKyThuat;

  ThietBi({
    required this.maTB,
    required this.tenTB,
    this.hinhAnh,
    this.maLoai,
    this.donGia,
    this.trangThaiTB,
    this.thongSoKyThuat,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaTB': maTB,
      'TenTB': tenTB,
      'HinhAnh': hinhAnh,
      'MaLoai': maLoai,
      'DonGia': donGia,
      'TrangThaiTB': trangThaiTB,
      'ThongSoKyThuat': thongSoKyThuat,
    };
  }

  factory ThietBi.fromMap(Map<String, dynamic> map) {
    return ThietBi(
      maTB: map['MaTB'],
      tenTB: map['TenTB'],
      hinhAnh: map['HinhAnh'],
      maLoai: map['MaLoai'],
      donGia: map['DonGia'],
      trangThaiTB: map['TrangThaiTB'],
      thongSoKyThuat: map['ThongSoKyThuat'],
    );
  }
}