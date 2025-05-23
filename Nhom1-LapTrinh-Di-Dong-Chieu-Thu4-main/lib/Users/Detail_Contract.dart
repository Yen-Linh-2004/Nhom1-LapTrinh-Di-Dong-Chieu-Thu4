import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContractDetailScreen extends StatelessWidget {
  final Map<String, dynamic> contract = {
    "MAHD": "HD001",
    "TENHD": "Trường ĐH Công Thương TP.HCM",
    "NGAYBATDAU": DateTime(2023, 5, 10),
    "NGAYKETTHUC": DateTime(2024, 5, 10),
    "CHIPHI": 15000000.50,
    "DIEUKHOAN": "1. Không sử dụng thiết bị vào mục đích cá nhân.\n"
        "2. Bảo trì định kỳ hàng tháng.\n"
        "3. Thanh toán trước 15 ngày khi hết hạn hợp đồng.",
  };

  ContractDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Chi tiết hợp đồng",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Thông tin cơ bản", Icons.assignment),
            _infoCard("Mã hợp đồng", contract["MAHD"]),
            _infoCard("Tên hợp đồng", contract["TENHD"]),
            _infoCard("Ngày bắt đầu", dateFormat.format(contract["NGAYBATDAU"])),
            _infoCard("Ngày kết thúc", dateFormat.format(contract["NGAYKETTHUC"])),

            _sectionTitle("Chi phí", Icons.monetization_on),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.orange[50],
              child: ListTile(
                leading: const Icon(Icons.price_change, color: Colors.deepOrange),
                title: Text(
                  currencyFormat.format(contract["CHIPHI"]),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _sectionTitle("Điều khoản hợp đồng", Icons.description),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                contract["DIEUKHOAN"],
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.info_outline_rounded, color: Colors.indigo),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
