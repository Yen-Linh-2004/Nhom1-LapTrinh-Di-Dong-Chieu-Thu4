import 'package:code_baocao/Users/Contract.dart';
import 'package:code_baocao/Users/Device.dart';
import 'package:code_baocao/Users/Setting.dart';
import 'package:code_baocao/Users/ChatBox.dart';
import 'package:code_baocao/Users/HomePage.dart';
import 'package:code_baocao/Users/LogIn.dart';
import 'package:code_baocao/Users/MaintenanceRequired.dart';
import 'package:code_baocao/Users/Personal_Information.dart';
import 'package:code_baocao/Users/Notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng
  final List<Widget> _screens = [
    HomeScreen(), // index 0: trang chủ
    EquipmentUserScreen(), // index 1: Thiết bị
    ContractsScreen(), // index 2: hợp đồng
    SettingsScreen(), // index 3: Cài đặt
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Drawer item helper
  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (index == -1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context); // Đóng Drawer
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text(
          "Hello, Yến Linh",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/image.png'),
              ),
            ),
          ),
        ],
      ),

      // Drawer
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
            const Divider(),
            _buildDrawerItem(Icons.exit_to_app, "Đăng xuất", -1),
          ],
        ),
      ),

      // Nội dung chính
      body: _screens[_selectedIndex],

      // Bottom Navigation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Bottom Navigation
            Expanded(
              child: Container(
                height:
                    60, // Điều chỉnh chiều cao cho phù hợp với giao diện nhỏ
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Giảm độ tròn cho phù hợp
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, // Màu sắc nhẹ hơn
                      blurRadius: 5, // Giảm độ mờ
                      spreadRadius: 1, // Giảm độ lan tỏa của bóng
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Column(
                        mainAxisSize:
                            MainAxisSize
                                .min, // Đảm bảo column không chiếm không gian dư thừa
                        children: [
                          Icon(Icons.info_outline, color: Colors.black),
                          Text(
                            'Thiết bị', // Thêm nhãn cho icon
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12, // Điều chỉnh font size nhỏ hơn
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => _onItemTapped(1),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MaintenanceRequestPage(),
                          ),
                        );
                      },
                      shape:
                          const CircleBorder(), 
                      child: const Icon(
                        // ignore: deprecated_member_use
                        FontAwesomeIcons.tools,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    IconButton(
                      icon: Column(
                        mainAxisSize:
                            MainAxisSize
                                .min, // Đảm bảo column không chiếm không gian dư thừa
                        children: [
                          Icon(Icons.settings, color: Colors.black),
                          Text(
                            'Cài đặt',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                      onPressed: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Chatbox
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBoxScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(
                  6,
                ), // Giảm padding để tiết kiệm không gian
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Màu sắc bóng nhẹ
                      blurRadius: 5, // Giảm độ mờ bóng
                      spreadRadius: 1, // Giảm độ lan tỏa
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/hinh_chatbox.jpg",
                  width: 40, // Giảm kích thước hình ảnh
                  height: 40, // Giảm kích thước hình ảnh
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
