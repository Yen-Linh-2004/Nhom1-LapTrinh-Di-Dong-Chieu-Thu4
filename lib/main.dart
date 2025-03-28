import 'package:code_baocao/admin/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_baocao/admin/payment_info.dart';
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(),
    );
  }
}