import 'package:flutter/material.dart';
import 'package:code_baocao/model/PaymentInfo.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BankTransferScreen extends StatefulWidget {
  final BankTransferInfo transferInfo;

  BankTransferScreen({required this.transferInfo});

  @override
  _BankTransferScreenState createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  int _selectedIndex = 2; // Mặc định ở mục "Hóa đơn"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // Tạo AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Thông tin chuyển khoản', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // Tạo phần thân trang
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          _buildBankDetails(),
        ],
      ),
    );
  } 

  // Thông tin ngân hàng
  Widget _buildBankDetails() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('THÔNG TIN CHUYỂN KHOẢN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),),
          SizedBox(height: 10),
          _buildInfoRow('Ngân hàng:', widget.transferInfo.bankName),
          _buildInfoRow('Người nhận:', widget.transferInfo.accountHolder),
          _buildInfoRow('Số tài khoản:', widget.transferInfo.accountNumber),
          _buildInfoRow('Số tiền:', '1.500.000 VNĐ'),
          _buildInfoRow('Nội dung:', widget.transferInfo.transferContent),
          SizedBox(height: 20),
          Center(
            child: QrImageView(
              data: "qrData",
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Hàng hiển thị thông tin
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}


