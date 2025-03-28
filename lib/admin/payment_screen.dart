import 'package:flutter/material.dart';
import 'package:code_baocao/admin/payment_info.dart';
import 'bank_transfer_screen.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentInfo paymentInfo;

  PaymentScreen({required this.paymentInfo});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = 2; // Mặc định ở mục "Hóa đơn"
  String _selectedPaymentMethod = '';
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Tạo AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Thanh Toán Hóa Đơn'),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // Tạo phần thân trang
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContractInfo(),
          SizedBox(height: 16),
          _buildDeviceInfo(),
          SizedBox(height: 16),
          _buildAmountInfo(),
          SizedBox(height: 16),
          _buildPaymentMethods(),
          if (_selectedPaymentMethod == 'Chuyển khoản') _buildBankTransferInfo(),
          SizedBox(height: 16),
          _buildPaymentButton(context),
        ],
      ),
    );
  }

  Widget _buildContractInfo() {
    return _buildInfoBox('Mã Hợp Đồng:', widget.paymentInfo.contractCode);
  }

  Widget _buildDeviceInfo() {
    return _buildInfoBox(
      'Thông Tin Thiết Bị:',
      'Tên thiết bị: ${widget.paymentInfo.deviceName}\nLoại thiết bị: ${widget.paymentInfo.deviceType}',
    );
  }

  Widget _buildAmountInfo() {
    return _buildInfoBox('Số Tiền Thanh Toán:', '${widget.paymentInfo.amount} VND');
  }

  Widget _buildInfoBox(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(content),
        ),
      ],
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
          if (_selectedPaymentMethod == label)
            Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildBankTransferInfo() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BankTransferScreen(
              transferInfo: BankTransferInfo(
                bankName: 'Vietcombank',
                accountNumber: '1234567890',
                accountHolder: 'Công ty TNHH ABC',
                qrCodeUrl: 'https://via.placeholder.com/150',
                transferContent: 'Thanh toán hợp đồng ${widget.paymentInfo.contractCode}',
              ),
            ),
          ),
        );
      },
      child: Text('Chi tiết chuyển khoản'),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isPaid = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thanh toán thành công!')));
        },
        child: Text('Thanh Toán'),
      ),
    );
  }

  // Tạo thanh điều hướng Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Danh mục'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Hóa đơn'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
      ],
    );
  }

  // Xử lý khi bấm vào BottomNavigationBar
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Không làm gì nếu chọn lại cùng mục

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pop(context); // Quay về trang trước (hoặc điều hướng Home)
        break;
      case 1:
        // Điều hướng đến Danh mục (nếu có)
        break;
      case 3:
        // Điều hướng đến Cài đặt (nếu có)
        break;
    }
  }
}
