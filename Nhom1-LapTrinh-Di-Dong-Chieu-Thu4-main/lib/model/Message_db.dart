// lib/models/tinnhan.dart
class TinNhan {
  final String maTN;
  final String? maND;
  final String noiDung;
  final String? thoiGianGui;
  final String? maNhom;

  TinNhan({
    required this.maTN,
    this.maND,
    required this.noiDung,
    this.thoiGianGui,
    this.maNhom,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaTN': maTN,
      'MaND': maND,
      'NoiDung': noiDung,
      'ThoiGianGui': thoiGianGui,
      'MaNhom': maNhom,
    };
  }

  factory TinNhan.fromMap(Map<String, dynamic> map) {
    return TinNhan(
      maTN: map['MaTN'],
      maND: map['MaND'],
      noiDung: map['NoiDung'],
      thoiGianGui: map['ThoiGianGui'],
      maNhom: map['MaNhom'],
    );
  }
}