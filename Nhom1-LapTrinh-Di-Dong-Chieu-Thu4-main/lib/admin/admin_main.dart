import 'package:code_baocao/admin/ListContract.dart';
import 'package:code_baocao/admin/ListCustomer.dart';
import 'package:code_baocao/admin/ListDevice.dart';
import 'package:code_baocao/admin/ListStaff.dart';
import 'package:code_baocao/admin/ListSupplier.dart';
import 'package:code_baocao/admin/Maintenance.dart';
import 'package:code_baocao/admin/Notification.dart';
import 'package:code_baocao/admin/Report.dart';
import 'package:code_baocao/admin/Setting.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          title: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: 30, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm chức năng...",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/banner_appbar_admin.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildFunctionItem(context, "Thiết bị", LucideIcons.monitor,
                      Colors.blue, EquipmentUserScreen()),
                  _buildFunctionItem(context, "Hợp đồng", LucideIcons.fileText,
                      Colors.green, ContractListPage()),
                  _buildFunctionItem(
                      context,
                      "Bảo trì",
                      LucideIcons.calendarClock,
                      Colors.orange,
                      MaintenanceFlowScreen()),
                  _buildFunctionItem(context, "Báo cáo", LucideIcons.barChart2,
                      Colors.red, MainScreen1()),
                  _buildFunctionItem(context, "Nhân viên", LucideIcons.star,
                      Colors.purple, EmployeeListScreen()),
                  _buildFunctionItem(context, "Khách hàng",
                      LucideIcons.briefcase, Colors.teal, CustomerListScreen()),
                  _buildFunctionItem(context, "Nhà cung cấp",
                      LucideIcons.factory, Colors.indigo, SupplierListScreen()),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Chức năng gần đây",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildRecentCard("Bảo trì", Icons.build, Colors.orange),
                  _buildRecentCard("Hợp đồng", Icons.article, Colors.blue),
                  _buildRecentCard("Thiết bị", Icons.devices, Colors.green),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionItem(BuildContext context, String title, IconData icon,
      Color color, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCard(String title, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: color),
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            "Truy cập gần đây",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminHomePage(), // Trang chủ
    AdminNotificationPage(), // Thông báo
    SettingsPage(), // Cài đặt
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Cài đặt",
          ),
        ],
      ),
    );
  }
}
