import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  // Thay thế bằng dữ liệu hóa đơn thực tế từ ứng dụng của bạn
  final Map<String, dynamic> invoiceData = {
    'maHopDong': 'HD001', // Thêm mã hợp đồng
    'tenKhachHang': 'Nguyễn Văn A',
    'diaChiKhachHang': '123 Đường ABC, Quận XYZ, TP.HCM',
    'thongTinKhac': 'Thuê máy chủ trong 3 tháng',
    'moTaThietBi': 'Máy chủ HP Proliant Gen10',
    'soTienCanThanhToan': 1500000,
    'ngayDenHan': '2023-11-15',
    'trangThai': 'Chưa thanh toán',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán Thuê Thiết Bị'),
        backgroundColor: Colors.blue[300], // Màu appbar xanh nhạt
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Thay URL avatar
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Box Mã Hợp Đồng (giống box Mô Tả Thiết Bị)
            Text('Mã Hợp Đồng:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity, // Kéo dài hết chiều ngang
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(invoiceData['maHopDong']),
            ),
            SizedBox(height: 16.0),
            // ... (Phần hiển thị thông tin hóa đơn giữ nguyên)
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(invoiceData['tenKhachHang'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(invoiceData['diaChiKhachHang']),
                      Text(invoiceData['thongTinKhac']),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: invoiceData['trangThai'] == 'Đã thanh toán'
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    invoiceData['trangThai'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Mô Tả Thiết Bị:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(invoiceData['moTaThietBi']),
            ),
            SizedBox(height: 16.0),
            Text('Số Tiền Cần Thanh Toán:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text('${invoiceData['soTienCanThanhToan']} VND'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý thanh toán
                },
                child: Text('Thanh Toán'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Ngày đến hạn'),
                Text(invoiceData['ngayDenHan']),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text('Chọn phương thức thanh toán',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.credit_card),
                    Text('Thẻ tín dụng'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.credit_card),
                    Text('Ví điện tử'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.account_balance),
                    Text('Chuyển khoản'),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Hợp đồng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Chọn item "Hợp đồng"
      ),
    );
  }
}