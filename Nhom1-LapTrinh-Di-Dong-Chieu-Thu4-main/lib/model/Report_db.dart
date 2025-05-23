// lib/models/baosucobaotri.dart
class BaoSuCoBaoTri {
  final String maBSBT;
  final String? maTB;
  final String? ngayBao;
  final String? ngaySua;
  final String? tinhTrang;
  final String? moTa;

  BaoSuCoBaoTri({
    required this.maBSBT,
    this.maTB,
    this.ngayBao,
    this.ngaySua,
    this.tinhTrang,
    this.moTa,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaBSBT': maBSBT,
      'MaTB': maTB,
      'NgayBao': ngayBao,
      'NgaySua': ngaySua,
      'TinhTrang': tinhTrang,
      'MoTa': moTa,
    };
  }

  factory BaoSuCoBaoTri.fromMap(Map<String, dynamic> map) {
    return BaoSuCoBaoTri(
      maBSBT: map['MaBSBT'],
      maTB: map['MaTB'],
      ngayBao: map['NgayBao'],
      ngaySua: map['NgaySua'],
      tinhTrang: map['TinhTrang'],
      moTa: map['MoTa'],
    );
  }
}