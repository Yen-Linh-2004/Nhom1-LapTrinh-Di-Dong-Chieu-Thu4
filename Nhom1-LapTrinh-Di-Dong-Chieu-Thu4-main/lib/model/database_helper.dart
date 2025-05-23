import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('management.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // USERS table
    await db.execute('''
    CREATE TABLE USERS (
      MaND TEXT PRIMARY KEY,
      HoTen TEXT NOT NULL,
      SDT TEXT,
      MatKhau TEXT NOT NULL,
      VaiTro TEXT,
      ChucVuTaiDV TEXT,
      NgayVaoLam TEXT
    )
    ''');

    // HOPDONG table
    await db.execute('''
    CREATE TABLE HOPDONG (
      MaHD TEXT PRIMARY KEY,
      TenDVThue TEXT NOT NULL,
      DiaChiThue TEXT,
      MaCHD TEXT,
      MaNV TEXT,
      NgayBD TEXT,
      NgayKT TEXT,
      ThanhTien REAL,
      TrangThaiTT TEXT,
      NgayTT TEXT,
      FOREIGN KEY (MaNV) REFERENCES USERS(MaND)
    )
    ''');

    // PHONGHOC table
    await db.execute('''
    CREATE TABLE PHONGHOC (
      MaP TEXT PRIMARY KEY,
      TenP TEXT NOT NULL
    )
    ''');

    // THANHVIEN table
    await db.execute('''
    CREATE TABLE THANHVIEN (
      MaTV TEXT PRIMARY KEY,
      MaHD TEXT,
      MaP TEXT,
      HoTen TEXT NOT NULL,
      SDT TEXT,
      MatKhau TEXT NOT NULL,
      NgayThamGia TEXT,
      ChucVuTaiDV TEXT,
      FOREIGN KEY (MaHD) REFERENCES HOPDONG(MaHD),
      FOREIGN KEY (MaP) REFERENCES PHONGHOC(MaP)
    )
    ''');

    // NHOM table
    await db.execute('''
    CREATE TABLE NHOM (
      MaNhom TEXT PRIMARY KEY,
      TenNhom TEXT NOT NULL,
      MaHD TEXT,
      FOREIGN KEY (MaHD) REFERENCES HOPDONG(MaHD)
    )
    ''');

    // TINNHAN table
    await db.execute('''
    CREATE TABLE TINNHAN (
      MaTN TEXT PRIMARY KEY,
      MaNhom TEXT,
      MaND TEXT,
      NoiDung TEXT,
      HinhAnh TEXT,
      TgianGui TEXT,
      MaNV TEXT,
      FOREIGN KEY (MaNhom) REFERENCES NHOM(MaNhom),
      FOREIGN KEY (MaND) REFERENCES USERS(MaND),
      FOREIGN KEY (MaNV) REFERENCES USERS(MaND)
    )
    ''');

    // LOAI table
    await db.execute('''
    CREATE TABLE LOAI (
      MaLoai TEXT PRIMARY KEY,
      TenLoai TEXT NOT NULL
    )
    ''');

    // THIETBI table
    await db.execute('''
    CREATE TABLE THIETBI (
      MaTB TEXT PRIMARY KEY,
      TenTB TEXT NOT NULL,
      HinhAnh TEXT,
      MaLoai TEXT,
      DonGia REAL,
      TrangThaiTB TEXT,
      ThongSoKyThuat TEXT,
      FOREIGN KEY (MaLoai) REFERENCES LOAI(MaLoai)
    )
    ''');

    // CHITIETHD table
    await db.execute('''
    CREATE TABLE CHITIETHD (
      MaHD TEXT,
      MaTB TEXT,
      SoLuong INTEGER,
      DonGia REAL,
      PRIMARY KEY (MaHD, MaTB),
      FOREIGN KEY (MaHD) REFERENCES HOPDONG(MaHD),
      FOREIGN KEY (MaTB) REFERENCES THIETBI(MaTB)
    )
    ''');

    // BAOSUCO_BAOTRI table
    await db.execute('''
    CREATE TABLE BAOSUCO_BAOTRI (
      MaBC TEXT PRIMARY KEY,
      MaND TEXT,
      MaHD TEXT,
      MaTB TEXT,
      MaNV TEXT,
      MoTaSuCo TEXT,
      HinhAnh TEXT,
      ThoiGianDeXuat TEXT,
      NgayBaotri TEXT,
      TrangThai TEXT,
      GhiChu TEXT,
      FOREIGN KEY (MaND) REFERENCES USERS(MaND),
      FOREIGN KEY (MaHD) REFERENCES HOPDONG(MaHD),
      FOREIGN KEY (MaTB) REFERENCES THIETBI(MaTB),
      FOREIGN KEY (MaNV) REFERENCES USERS(MaND)
    )
    ''');
  }

  Future<void> insertHopDong(Map<String, dynamic> hopDong) async {
    final db = await database;
    await db.insert('HOPDONG', hopDong, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getHopDong(String maHD) async {
    final db = await database;
    final result = await db.query('HOPDONG', where: 'MaHD = ?', whereArgs: [maHD]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getHopDongs() async {
    final db = await database;
    return await db.query('HOPDONG');
  }

  Future<void> updateHopDong(String maHD, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('HOPDONG', updates, where: 'MaHD = ?', whereArgs: [maHD]);
  }

  Future<void> insertThietBi(Map<String, dynamic> thietBi) async {
    final db = await database;
    await db.insert('THIETBI', thietBi, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getDevice(String maTB) async {
    final db = await database;
    final result = await db.query('THIETBI', where: 'MaTB = ?', whereArgs: [maTB]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getDevices() async {
    final db = await database;
    return await db.query('THIETBI');
  }

  Future<void> updateDevice(String maTB, Map<String, dynamic> device) async {
    final db = await database;
    await db.update('THIETBI', device, where: 'MaTB = ?', whereArgs: [maTB]);
  }

  Future<List<Map<String, dynamic>>> getRentalHistory(String maTB) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT HOPDONG.NgayBD, HOPDONG.TenDVThue, HOPDONG.NgayKT
      FROM CHITIETHD
      JOIN HOPDONG ON CHITIETHD.MaHD = HOPDONG.MaHD
      WHERE CHITIETHD.MaTB = ?
    ''', [maTB]);
  }

  Future<void> insertChiTietHD(Map<String, dynamic> chiTietHD) async {
    final db = await database;
    await db.insert('CHITIETHD', chiTietHD, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getChiTietHD(String maHD) async {
    final db = await database;
    return await db.query('CHITIETHD', where: 'MaHD = ?', whereArgs: [maHD]);
  }

  Future<bool> isValidMaTB(String maTB) async {
    final db = await database;
    final result = await db.query('THIETBI', where: 'MaTB = ?', whereArgs: [maTB]);
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getLoai(String maLoai) async {
    final db = await database;
    final result = await db.query('LOAI', where: 'MaLoai = ?', whereArgs: [maLoai]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('USERS', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(String maND) async {
    final db = await database;
    final result = await db.query('USERS', where: 'MaND = ?', whereArgs: [maND]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('USERS');
  }

  Future<void> updateUser(String maND, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('USERS', updates, where: 'MaND = ?', whereArgs: [maND]);
  }

  Future<void> insertPhongHoc(Map<String, dynamic> phongHoc) async {
    final db = await database;
    await db.insert('PHONGHOC', phongHoc, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getPhongHoc(String maPhong) async {
    final db = await database;
    final result = await db.query('PHONGHOC', where: 'MaPhong = ?', whereArgs: [maPhong]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getPhongHocs() async {
    final db = await database;
    return await db.query('PHONGHOC');
  }

  Future<void> updatePhongHoc(String maPhong, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('PHONGHOC', updates, where: 'MaPhong = ?', whereArgs: [maPhong]);
  }

  Future<void> insertThanhVien(Map<String, dynamic> thanhVien) async {
    final db = await database;
    await db.insert('THANHVIEN', thanhVien, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getThanhVien(String maTV) async {
    final db = await database;
    final result = await db.query('THANHVIEN', where: 'MaTV = ?', whereArgs: [maTV]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getThanhViens() async {
    final db = await database;
    return await db.query('THANHVIEN');
  }

  Future<void> updateThanhVien(String maTV, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('THANHVIEN', updates, where: 'MaTV = ?', whereArgs: [maTV]);
  }

  Future<void> insertNhom(Map<String, dynamic> nhom) async {
    final db = await database;
    await db.insert('NHOM', nhom, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getNhom(String maNhom) async {
    final db = await database;
    final result = await db.query('NHOM', where: 'MaNhom = ?', whereArgs: [maNhom]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getNhoms() async {
    final db = await database;
    return await db.query('NHOM');
  }

  Future<void> updateNhom(String maNhom, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('NHOM', updates, where: 'MaNhom = ?', whereArgs: [maNhom]);
  }

  Future<void> insertTinNhan(Map<String, dynamic> tinNhan) async {
    final db = await database;
    await db.insert('TINNHAN', tinNhan, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getTinNhan(String maTN) async {
    final db = await database;
    final result = await db.query('TINNHAN', where: 'MaTN = ?', whereArgs: [maTN]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getTinNhans() async {
    final db = await database;
    return await db.query('TINNHAN');
  }

  Future<void> updateTinNhan(String maTN, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('TINNHAN', updates, where: 'MaTN = ?', whereArgs: [maTN]);
  }

  Future<void> insertBaoSuCoBaoTri(Map<String, dynamic> baoSuCoBaoTri) async {
    final db = await database;
    await db.insert('BAOSUCO_BAOTRI', baoSuCoBaoTri, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getBaoSuCoBaoTri(String maBSBT) async {
    final db = await database;
    final result = await db.query('BAOSUCO_BAOTRI', where: 'MaBSBT = ?', whereArgs: [maBSBT]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getBaoSuCoBaoTris() async {
    final db = await database;
    return await db.query('BAOSUCO_BAOTRI');
  }

  Future<void> updateBaoSuCoBaoTri(String maBSBT, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('BAOSUCO_BAOTRI', updates, where: 'MaBSBT = ?', whereArgs: [maBSBT]);
  }
}

