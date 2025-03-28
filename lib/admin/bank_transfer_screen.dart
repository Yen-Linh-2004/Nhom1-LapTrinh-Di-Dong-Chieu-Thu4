import 'package:flutter/material.dart';
import 'package:code_baocao/admin/payment_info.dart'; // Đảm bảo đường dẫn chính xác

class BankTransferScreen extends StatelessWidget {
  final BankTransferInfo transferInfo;

  BankTransferScreen({required this.transferInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin chuyển khoản'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'THÔNG TIN CHUYỂN KHOẢN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Dùng app ngân hàng hoặc MoMo quét mã QR hoặc chuyển khoản theo thông tin bên dưới, không sửa nội dung chuyển khoản, bạn có thể thêm vào phía sau.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2, // Thay đổi tỉ lệ cho phù hợp
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ngân hàng: ${transferInfo.bankName}'),
                      Text('Người nhận: ${transferInfo.accountHolder}'),
                      Text('Số tài khoản: ${transferInfo.accountNumber}'),
                      Text('Số tiền: 325.000 VNĐ'), // Giữ nguyên số tiền tĩnh
                      Text('Nội dung: ${transferInfo.transferContent}'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.image),
                Text('Tải ảnh về máy'),
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VẬN CHUYỂN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Khi đơn bắt đầu được vận chuyển, shop sẽ nhắn tin cho bạn, bạn có thể xem lịch trình đơn hàng đã tới đâu ở bên dưới.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}