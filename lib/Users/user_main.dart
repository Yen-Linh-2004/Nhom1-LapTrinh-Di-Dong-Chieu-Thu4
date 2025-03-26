import 'package:code_baocao/admin/DangNhap.dart';
import 'package:code_baocao/Users/QuanlyThietbi.dart';
import 'package:code_baocao/Users/caidat.dart';
import 'package:code_baocao/Users/hopdong.dart';
import 'package:code_baocao/Users/thongtincanhan.dart';
import 'package:code_baocao/Users/trangchu.dart';
import 'package:code_baocao/Users/xemyeucaubaotri.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng với Bottom Navigation
  final List<Widget> _screens = [
    HomeScreen(),
    EquipmentUserScreen(),
    ContractsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, Yến Linh", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaintenanceRequestsScreen(),
                ),
              );
            },
          ),
          CircleAvatar(
            radius: 30, // Điều chỉnh kích thước ảnh đại diện
            backgroundImage: AssetImage('assets/images/image.png'),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ), // Thay bằng trang cần chuyển đến
                );
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Yến Linh"),
              accountEmail: Text("Yenlinh2004@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/image.png"),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            _buildDrawerItem(Icons.home, "Trang chủ", 0),
            _buildDrawerItem(Icons.devices, "Thiết bị", 1),
            _buildDrawerItem(Icons.assignment, "Hợp đồng", 2),
            _buildDrawerItem(Icons.settings, "Cài đặt", 3),
            Divider(),
            _buildDrawerItem(Icons.exit_to_app, "Đăng xuất", -1),
          ],
        ),
      ),
      body: _screens[_selectedIndex], // Hiển thị màn hình tương ứng
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: "Thiết bị"),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Hợp đồng",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Cài đặt"),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (index == -1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
        }
      },
    );
  }
}
