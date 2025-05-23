import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thống kê nhanh
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Tổng Thiết Bị", "3", Colors.blue),
                _buildStatCard("Sắp Hết Hạn", "2", Colors.orange),
                _buildStatCard("Cần Bảo Trì", "1", Colors.red),
              ],
            ),
            SizedBox(height: 20),
            // Danh sách thiết bị quan trọng
            _buildSectionTitle("Thiết Bị Quan Trọng"),
            _buildDeviceList(),
            SizedBox(height: 20),
            // Danh sách thành viên được xem chung
            _buildSectionTitle("Thành Viên Có Quyền Xem"),
            _buildMemberList(),
            SizedBox(height: 20),
            // Sự kiện ưu đãi
            _buildSectionTitle("Sự Kiện & Ưu Đãi"),
            ClipRRect(
              borderRadius: BorderRadius.circular(15), // Bo góc 15px
              child: Image.asset(
                "assets/images/banner_sukien.png",
                width: 800,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 3,
      color: color,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDeviceList() {
    return Column(
      children: [
        _buildDeviceItem("Laptop Dell XPS 13", "Sắp hết hạn", Colors.orange),
        _buildDeviceItem("Máy in Canon LBP2900", "Sắp hết hạn", Colors.orange),
        _buildDeviceItem("Máy chiếu Sony VPL-EX", "Cần bảo trì", Colors.red),
      ],
    );
  }

  Widget _buildDeviceItem(String name, String status, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.devices, color: color),
        title: Text(name),
        subtitle: Text(status, style: TextStyle(color: color)),
      ),
    );
  }

  Widget _buildMemberList() {
    return Column(
      children: [
        _buildMemberItem("Nguyễn Văn A", "Trưởng phòng"),
        _buildMemberItem("Trần Thị B", "Nhân viên IT"),
        _buildMemberItem("Lê Minh C", "Quản lý tài sản"),
      ],
    );
  }

  Widget _buildMemberItem(String name, String role) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.blue),
        title: Text(name),
        subtitle: Text(role),
      ),
    );
  }
}
