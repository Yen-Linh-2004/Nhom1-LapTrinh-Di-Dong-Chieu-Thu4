import 'package:flutter/material.dart';
import 'package:code_baocao/admin/payment_info.dart';
import 'bank_transfer_screen.dart'; // Import màn hình chuyển khoản

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Dữ liệu thanh toán mẫu
  final PaymentInfo paymentInfo = PaymentInfo(
    contractCode: 'HD001',
    deviceName: 'Máy chủ HP Proliant Gen10',
    deviceType: 'Thiết bị máy chủ',
    renterName: 'Nguyễn Văn A',
    amount: 1500000,
  );
  String _selectedPaymentMethod = ''; // Lưu trữ phương thức thanh toán đã chọn
  bool _isPaid = false; // Trạng thái thanh toán

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán Thuê Thiết Bị'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Xử lý thông báo
              _showNotificationDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContractInfo(),
              SizedBox(height: 16),
              _buildDeviceInfo(),
              SizedBox(height: 16),
              _buildAmountInfo(),
              SizedBox(height: 16),
              _buildPaymentButton(context),
              SizedBox(height: 16),
              _buildDueDate(), // Hiển thị ngày đến hạn
              SizedBox(height: 24),
              _buildPaymentMethods(),
              if (_selectedPaymentMethod == 'Chuyển khoản') _buildBankTransferInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContractInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mã Hợp Đồng:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(paymentInfo.contractCode),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paymentInfo.renterName, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('123 Đường ABC, Quận XYZ, TP.HCM'),
                  Text('Thuê máy chủ trong 3 tháng'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isPaid ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_isPaid ? 'Đã thanh toán' : 'Chưa thanh toán', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Số Tiền Thanh Toán:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('${paymentInfo.amount} VND'),
        ),
      ],
    );
  }

  Widget _buildDeviceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông Tin Thiết Bị:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tên thiết bị: ${paymentInfo.deviceName}'),
              Text('Loại thiết bị: ${paymentInfo.deviceType}'),
            ],
          ),
        ),
      ],
    );
  }

    Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _processPayment(context);
        },
        child: Text('Thanh Toán'),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Chọn phương thức thanh toán', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPaymentMethodIcon(Icons.account_balance, 'Chuyển khoản'),
            _buildPaymentMethodIcon(Icons.money, 'Tiền mặt'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodIcon(IconData icon, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = label;
        });
      },
      child: Column(
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 8),
          Text(label),
          if (_selectedPaymentMethod == label) Icon(Icons.check, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildBankTransferInfo() {
    final BankTransferInfo transferInfo = BankTransferInfo(
      bankName: 'Vietcombank',
      accountNumber: '1234567890',
      accountHolder: 'Công ty TNHH ABC',
      qrCodeUrl: 'https://via.placeholder.com/150',
      transferContent: 'Thanh toán hợp đồng ${paymentInfo.contractCode}',
    );

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BankTransferScreen(transferInfo: transferInfo),
          ),
        );
      },
      child: Text('Chi tiết chuyển khoản'),
    );
  }

  void _processPayment(BuildContext context) {
    if (_selectedPaymentMethod == 'Chuyển khoản') {
      final BankTransferInfo transferInfo = BankTransferInfo(
        bankName: 'Vietcombank',
        accountNumber: '1234567890',
        accountHolder: 'Công ty TNHH ABC',
        qrCodeUrl: 'https://via.placeholder.com/150',
        transferContent: 'Thanh toán hợp đồng ${paymentInfo.contractCode}',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BankTransferScreen(transferInfo: transferInfo),
        ),
      );
    } else if (_selectedPaymentMethod == 'Tiền mặt') {
      setState(() {
        _isPaid = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thanh toán tiền mặt thành công!')));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xác nhận thanh toán'),
            content: Text('Bạn có chắc chắn muốn thanh toán ${paymentInfo.amount} VND?'),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Xác nhận'),
                onPressed: () {
                  setState(() {
                    _isPaid = true;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thanh toán thành công!')));
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildDueDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ngày Đến Hạn:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('30/12/2023'), // Thay đổi ngày đến hạn theo yêu cầu
        ),
      ],
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Không có thông báo mới'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}