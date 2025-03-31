import 'package:code_baocao/Users/thongtincanhan.dart';
import 'package:code_baocao/admin/baocao.dart';
import 'package:code_baocao/admin/baotri.dart';
import 'package:code_baocao/admin/equipment_management.dart';
import 'package:code_baocao/admin/hopdong.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220), // Chiều cao AppBar
        child: Stack(
          children: [
            // Ảnh nền
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/banner_appbar_admin.jpg",
                  ), // Thay đường dẫn ảnh phù hợp
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Tiêu đề (Căn góc trên trái)
            Positioned(
              top: 10, // Căn trên
              left: 16, // Căn trái
              child: Text(
                "Xin chào, Admin!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Đổi màu để dễ nhìn trên nền ảnh
                ),
              ),
            ),
            // Các icon góc trên phải
            Positioned(
              top: 10, // Căn trên
              right: 16, // Căn phải
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(LucideIcons.bell, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ), // Thay bằng trang cần chuyển đến
                      );
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(LucideIcons.user),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Body đè lên AppBar một chút
      body: Transform.translate(
        offset: Offset(0, -20), // Đẩy lên 20px
        child: Container(
          padding: EdgeInsets.only(top: 35, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white, // Nếu cần màu nền
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Các chức năng chính:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.green),
                      Text("Tìm kiếm", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Chức năng chính
              Expanded(
                child: ListView(
                  children: [
                    _buildFeatureCard(
                      context,
                      "Quản lý thiết bị",
                      LucideIcons.list,
                      Colors.orange,
                      EquipmentUserScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      "Quản lý hợp đồng",
                      LucideIcons.fileText,
                      Colors.blue,
                      ContractListPage(),
                    ),
                    _buildFeatureCard(
                      context,
                      "quản lý bảo trì",
                      LucideIcons.calendar,
                      Colors.red,
                      MaintenanceScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      "Báo cáo thống kê",
                      LucideIcons.barChart,
                      Colors.purple,
                      MainScreen1(),
                    ),
                    // _buildFeatureCard(
                    //   context,
                    //   "Cài đặt hệ thống",
                    //   LucideIcons.settings,
                    //   Colors.grey,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
