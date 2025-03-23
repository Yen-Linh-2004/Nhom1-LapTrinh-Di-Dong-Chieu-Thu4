import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Định dạng tiền tệ và ngày

class ContractDetailScreen extends StatelessWidget {
  final Map<String, dynamic> contract = {
    "MAHD": "HD001",
    "TENHD": "Trường DH Công thương Tp.HCM",
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
      appBar: AppBar(
        title: Text("Chi tiết hợp đồng", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề hợp đồng
            Row(
              children: [
                Icon(Icons.assignment, size: 30, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text(
                  "Thông tin hợp đồng",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Nội dung hợp đồng
            _buildContractDetail("Mã hợp đồng", contract["MAHD"]),
            _buildContractDetail("Tên hợp đồng", contract["TENHD"]),
            _buildContractDetail("Ngày bắt đầu", dateFormat.format(contract["NGAYBATDAU"])),
            _buildContractDetail("Ngày kết thúc", dateFormat.format(contract["NGAYKETTHUC"])),

            // Chi phí
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Text(
                    "Chi phí: ${currencyFormat.format(contract["CHIPHI"])}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                ],
              ),
            ),

            // Điều khoản hợp đồng
            Text(
              "Điều khoản hợp đồng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Text(
                  contract["DIEUKHOAN"],
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            // Nút quay lại
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                label: Text("Quay lại"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị từng dòng thông tin hợp đồng
  Widget _buildContractDetail(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: "$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
