import 'package:code_baocao/model/PaymentInfo.dart';
import 'package:flutter/material.dart';
import 'PaymentScreen.dart'; 

class InvoiceListScreen extends StatefulWidget {
  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  int _selectedIndex = 2; // Mặc định ở mục "Hóa đơn"

  final List<PaymentInfo> invoices = [
    PaymentInfo(
      contractCode: 'HD001',
      deviceName: 'Máy chủ HP Proliant Gen10',
      deviceType: 'Thiết bị máy chủ',
      renterName: 'Nguyễn Văn A',
      amount: 1500000,
    ),
    PaymentInfo(
      contractCode: 'HD002',
      deviceName: 'Laptop Dell XPS 13',
      deviceType: 'Laptop',
      renterName: 'Trần Thị B',
      amount: 1200000,
    ),
    PaymentInfo(
      contractCode: 'HD003',
      deviceName: 'Máy in Canon LBP2900',
      deviceType: 'Máy in',
      renterName: 'Lê Văn C',
      amount: 800000,
    ),
  ];

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
      title: Text('Danh Sách Hóa Đơn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
    return ListView.builder(
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.receipt_long, color: Colors.blue),
            title: Text('Hợp đồng: ${invoices[index].contractCode}'),
            subtitle: Text(
              'Tên thiết bị: ${invoices[index].deviceName}\nSố tiền: ${invoices[index].amount} VND',
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(paymentInfo: invoices[index]),
                ),
              );
            },
          ),
        );
      },
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
