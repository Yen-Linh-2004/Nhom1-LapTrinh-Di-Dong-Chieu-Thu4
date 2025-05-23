// lib/models/hopdong.dart
class HopDong {
  final String maHD;
  final String tenDVThue;
  final String? diaChiThue;
  final String? maCHD;
  final String? maNV;
  final String? ngayBD;
  final String? ngayKT;
  final double? thanhTien;
  final String? trangThaiTT;
  final String? ngayTT;

  HopDong({
    required this.maHD,
    required this.tenDVThue,
    this.diaChiThue,
    this.maCHD,
    this.maNV,
    this.ngayBD,
    this.ngayKT,
    this.thanhTien,
    this.trangThaiTT,
    this.ngayTT,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaHD': maHD,
      'TenDVThue': tenDVThue,
      'DiaChiThue': diaChiThue,
      'MaCHD': maCHD,
      'MaNV': maNV,
      'NgayBD': ngayBD,
      'NgayKT': ngayKT,
      'ThanhTien': thanhTien,
      'TrangThaiTT': trangThaiTT,
      'NgayTT': ngayTT,
    };
  }

  factory HopDong.fromMap(Map<String, dynamic> map) {
    return HopDong(
      maHD: map['MaHD'],
      tenDVThue: map['TenDVThue'],
      diaChiThue: map['DiaChiThue'],
      maCHD: map['MaCHD'],
      maNV: map['MaNV'],
      ngayBD: map['NgayBD'],
      ngayKT: map['NgayKT'],
      thanhTien: map['ThanhTien'],
      trangThaiTT: map['TrangThaiTT'],
      ngayTT: map['NgayTT'],
    );
  }
}