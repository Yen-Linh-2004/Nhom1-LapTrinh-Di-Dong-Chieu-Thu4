import 'package:flutter/material.dart';
import 'package:equipment_management/admin/equipment_management.dart'; // Import file giao diện quản lý thiết bị

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EquipmentUserScreen(), // Chạy màn hình quản lý thiết bị
    );
  }
}
