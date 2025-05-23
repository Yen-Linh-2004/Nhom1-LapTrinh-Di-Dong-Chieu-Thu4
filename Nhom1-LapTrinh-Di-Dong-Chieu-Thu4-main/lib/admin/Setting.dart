import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> settingsItems = [
    {
      'icon': Icons.account_circle,
      'title': 'Quản lý tài khoản',
      'onTap': () {},
    },
    {
      'icon': Icons.lock,
      'title': 'Thay đổi mật khẩu',
      'onTap': () {},
    },
    {
      'icon': Icons.exit_to_app,
      'title': 'Đăng xuất',
      'onTap': () {},
    },
    {
      'icon': Icons.delete_rounded,
      'title': 'Xóa tài khoản',
      'onTap': () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Cài Đặt Admin",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 2,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: settingsItems.length,
        itemBuilder: (context, index) {
          final item = settingsItems[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Icon(item['icon'], color: Colors.blue),
              ),
              title: Text(
                item['title'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: item['onTap'],
            ),
          );
        },
      ),
    );
  }
}
