import 'package:flutter/material.dart';
import 'package:code_baocao/admin/payment_info.dart';

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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Tạo AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Thông tin chuyển khoản'),
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
          _buildTitleSection(),
          SizedBox(height: 10),
          _buildInstructionBox(),
          SizedBox(height: 20),
          _buildBankDetails(),
          SizedBox(height: 30),
          _buildShippingInfo(),
        ],
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

  // Tiêu đề "THÔNG TIN CHUYỂN KHOẢN"
  Widget _buildTitleSection() {
    return Text(
      'THÔNG TIN CHUYỂN KHOẢN',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  // Hộp hướng dẫn
  Widget _buildInstructionBox() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Dùng app ngân hàng hoặc MoMo quét mã QR hoặc chuyển khoản theo thông tin bên dưới.\n'
        'Không sửa nội dung chuyển khoản, bạn có thể thêm vào phía sau.',
        style: TextStyle(fontSize: 14),
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
          _buildInfoRow('Ngân hàng:', widget.transferInfo.bankName),
          _buildInfoRow('Người nhận:', widget.transferInfo.accountHolder),
          _buildInfoRow('Số tài khoản:', widget.transferInfo.accountNumber),
          _buildInfoRow('Số tiền:', '1.500.000 VNĐ'),
          _buildInfoRow('Nội dung:', widget.transferInfo.transferContent),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Thêm chức năng tải ảnh nếu cần
            },
            icon: Icon(Icons.download),
            label: Text('Tải ảnh về máy'),
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

  // Thông tin vận chuyển
  Widget _buildShippingInfo() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
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
            'Khi đơn bắt đầu được vận chuyển, shop sẽ nhắn tin cho bạn, '
            'bạn có thể xem lịch trình đơn hàng ở bên dưới.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
