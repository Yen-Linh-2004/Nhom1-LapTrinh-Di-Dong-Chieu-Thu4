import 'package:flutter/material.dart';
import 'package:code_baocao/model/PaymentInfo.dart';
import 'bank_transfer_screen.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentInfo paymentInfo;

  PaymentScreen({required this.paymentInfo});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = 2;
  String _selectedPaymentMethod = '';
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
   //   bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Hóa Đơn Thanh Toán', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.receipt_long, size: 50, color: Colors.indigo),
                      SizedBox(height: 8),
                      Text("HÓA ĐƠN THANH TOÁN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Divider(thickness: 1.5),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _buildInfoRow("Mã hợp đồng:", widget.paymentInfo.contractCode),
                _buildInfoRow("Tên thiết bị:", widget.paymentInfo.deviceName),
                _buildInfoRow("Loại thiết bị:", widget.paymentInfo.deviceType),
                _buildInfoRow("Số tiền cần thanh toán:", "${widget.paymentInfo.amount} VND"),
                SizedBox(height: 20),
                Text("Phương thức thanh toán", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPaymentOption(Icons.account_balance, "Chuyển khoản"),
                    _buildPaymentOption(Icons.money, "Tiền mặt"),
                  ],
                ),
                if (_selectedPaymentMethod == 'Chuyển khoản') ...[
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.account_balance_wallet_outlined),
                      label: Text('Chi tiết chuyển khoản', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
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
                    ),
                  )
                ],
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: _isPaid ? Colors.grey : Colors.green,
                    ),
                    onPressed: _isPaid
                        ? null
                        : () {
                            setState(() => _isPaid = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Thanh toán thành công!')),
                            );
                          },
                    child: Text(
                      _isPaid ? 'Đã Thanh Toán' : 'Xác Nhận Thanh Toán',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(title, style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 5, child: Text(content)),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String method) {
    final isSelected = _selectedPaymentMethod == method;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.indigo : Colors.grey),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: isSelected ? Colors.indigo : Colors.black),
            SizedBox(height: 6),
            Text(method),
            if (isSelected) Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Danh mục'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Hóa đơn'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
      ],
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        // TODO: Điều hướng danh mục
        break;
      case 3:
        // TODO: Điều hướng cài đặt
        break;
    }
  }
}
