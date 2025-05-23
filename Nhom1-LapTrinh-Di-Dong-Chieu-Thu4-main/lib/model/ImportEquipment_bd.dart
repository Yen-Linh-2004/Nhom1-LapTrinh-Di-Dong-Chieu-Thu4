// lib/models/loai.dart
class Loai {
  final String maLoai;
  final String tenLoai;

  Loai({
    required this.maLoai,
    required this.tenLoai,
  });

  Map<String, dynamic> toMap() {
    return {
      'MaLoai': maLoai,
      'TenLoai': tenLoai,
    };
  }

  factory Loai.fromMap(Map<String, dynamic> map) {
    return Loai(
      maLoai: map['MaLoai'],
      tenLoai: map['TenLoai'],
    );
  }
}