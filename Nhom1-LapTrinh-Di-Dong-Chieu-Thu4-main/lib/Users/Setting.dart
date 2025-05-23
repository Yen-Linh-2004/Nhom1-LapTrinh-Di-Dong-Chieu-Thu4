// ignore: file_names
import 'package:code_baocao/Users/LogIn.dart';
import 'package:code_baocao/Users/Personal_Information.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Tài khoản"),
          subtitle: Text("Quản lý thông tin cá nhân"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Thông báo"),
          subtitle: Text("Cài đặt thông báo ứng dụng"),
          trailing: Switch(value: true, onChanged: (val) {}),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.language),
          title: Text("Ngôn ngữ"),
          subtitle: Text("Tiếng Việt"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text("Đăng xuất", style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }
}
